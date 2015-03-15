# includeme.el --- Automatic C/C++ '#include' and 'using' in Emacs
# Copyright (c) 2013 Justine Tunney

# This file is responsible for pulling data about standard functions and
# headers from as many sources as possible (like man pages and
# cppreference.com) and assembling it all into a precomputed lisp binary tree.

import gzip
import itertools
import operator
import os
import re
import sys
import xml.etree.cElementTree as ET


shadows = {
    'assert.h': 'cassert',
    'complex.h': 'ccomplex',
    'ctype.h': 'cctype',
    'errno.h': 'cerrno',
    'fenv.h': 'cfenv',
    'float.h': 'cfloat',
    'inttypes.h': 'cinttypes',
    'limits.h': 'climits',
    'locale.h': 'clocale',
    'math.h': 'cmath',
    'setjmp.h': 'csetjmp',
    'signal.h': 'csignal',
    'stdalign.h': 'cstdalign',
    'stdarg.h': 'cstdarg',
    'stdbool.h': 'cstdbool',
    'stddef.h': 'cstddef',
    'stdint.h': 'cstdint',
    'stdio.h': 'cstdio',
    'stdlib.h': 'cstdlib',
    'string.h': 'cstring',
    'tgmath.h': 'ctgmath',
    'time.h': 'ctime',
    'wchar.h': 'cwchar',
    'wctype.h': 'cwctype',
}


def make_happy_list(out, syms):
    """Outputs a list that gets turned into a btree by emacs."""
    syms.sort(key=operator.itemgetter(0))
    out.write('(setq includeme! \'(\n')
    for name, hdrs in syms:
        if isinstance(hdrs, basestring):
            out.write('("%s" . "%s")\n' % (name, hdrs))
        else:
            out.write('("%s" %s)\n' % (name, " ".join(hdrs)))
    out.write('))\n')


def get_mans(level=3, root='/usr/share/man'):
    """Yields ``(abs-path, file-obj)`` for each man in root."""
    root = os.path.join(root, 'man%d' % (level))
    for name in os.listdir(root):
        path = os.path.join(root, name)
        if path.endswith('.%d.gz' % (level)):
            yield (path, gzip.open(path))
        elif path.endswith('.%d' % (level)):
            yield (path, open(path))


def parse_man(path, text):
    """Reads raw man page text and yields ``(func-name, [headers])`` pairs."""
    includes = set()
    for line in text:
        if line.startswith('.B ') or line.startswith('.BR "#inc'):
            m = re.search('#include <(.*?)>', line)
            if m:
                includes.add(m.group(1))
        if line.startswith('.BR "#inc'):
            m = re.search('#include <(.*?)>', line)
            if m:
                includes.add(m.group(1))
        if line.startswith('.B'):
            m = re.search(r'BI? ".+ \*?([a-zA-Z_0-9]+)\(', line)
            if m:
                func = m.group(1)
                if not includes:
                    print >>sys.stderr, "no includes for", func, "in", path
                    continue
                yield func, set(includes)
        if 'DESCRIPTION' in line:
            break


def main(cppdir):
    xml_c_index = '%s/index-functions-c.xml' % (cppdir)
    xml_cpp_index = '%s/index-functions-cpp.xml' % (cppdir)
    htmldir = '%s/reference/en.cppreference.com/w' % (cppdir)

    links = {}
    c_syms = {}
    cpp_syms = {}
    man_syms = {}

    # Load information about (assumedly) C functions in man 2/3 pages.
    for path, text in itertools.chain(get_mans(3), get_mans(2)):
        for func, includes in parse_man(path, text):
            if func in man_syms:
                if includes != man_syms[func]:
                    print >>sys.stderr, 'does %s have %r or %r?' % (
                        func, man_syms[func], includes)
                continue
            man_syms[func] = includes

    # C: Load all the symbols.
    for child in ET.parse(xml_c_index).getroot():
        # Math functions seem to be having a hard time.
        if 'link' not in child.attrib:
            continue
        if '/' not in child.attrib['link']:
            continue
        if child.attrib['link'].startswith('cpp/'):
            continue
        # aghhh!@
        if '(' in child.attrib['name']:
            continue
        sym = {'name': child.attrib['name'],
               'type': child.tag,
               'link': child.attrib['link']}
        c_syms[sym['name']] = sym
        links.setdefault(sym['link'], []).append(sym)

    # C++: Load all the symbols.
    for child in ET.parse(xml_cpp_index).getroot():
        # aghhh!@
        if '(' in child.attrib['name']:
            continue
        sym = {'name': child.attrib['name'],
               'type': child.tag,
               'alias': child.attrib.get('alias'),
               'link': child.attrib.get('link')}
        cpp_syms[sym['name']] = sym

    # C++: Second pass to resolve typedef aliases.
    for sym in cpp_syms.values():
        if not sym['alias']:
            continue
        other = cpp_syms[sym['alias']]
        sym['type'] = '%s(%s)' % (sym['type'], other['type'])
        sym['link'] = other['link']

    # C++: Third pass to construct backlinks.
    for sym in cpp_syms.values():
        links.setdefault(sym['link'], []).append(sym)

    # Figure out what headers contain all these symbols.
    for link, syms in links.items():
        htmlfile = '%s/%s.html' % (htmldir, link)
        if not os.path.exists(htmlfile):
            print >>sys.stderr, 'missing html:', htmlfile
            continue
        html = open(htmlfile).read()
        m = re.search(r'Defined in header.+?;(.+?)&', html, re.I)
        if m:
            header = m.group(1)
            # fenv.h goofiness workaround :\
            header = header.replace('&lt;', '')
            for sym in syms:
                sym['header'] = header
        else:
            print >>sys.stderr, 'no header found:', htmlfile

    # Simplify down to `symbol: set(header)` and get rid of symbols for which
    # no header was found.
    def filter_syms(lang, syms):
        for name, sym in syms.items():
            if sym.get('header'):
                yield name, set([sym['header']])
            else:
                # Salvage some symbols where html page missing ugh.
                if (name.startswith('std::') and
                    name[5:] in c_syms and
                    c_syms[name[5:]] & set(shadows.keys())):
                    hdrs = set(shadows.get(hdr, hdr)
                               for hdr in c_syms[name[5:]])
                    print >>sys.stderr, \
                        'salvaging %s -> %s (from c)' % (name, hdrs)
                    yield (name, hdrs)
                elif (name.startswith('std::') and
                      name[5:] in man_syms and
                      man_syms[name[5:]] & set(shadows.keys())):
                    hdrs = set(shadows.get(hdr, hdr)
                               for hdr in man_syms[name[5:]])
                    print >>sys.stderr, \
                        'salvaging %s -> %s (from man)' % (name, hdrs)
                    yield (name, hdrs)
                else:
                    print >>sys.stderr, 'discard %s symbol: %s' % (lang, name)
    c_syms = dict(filter_syms('C', c_syms))
    cpp_syms = dict(filter_syms('C++', cpp_syms))

    # Display some countage.
    print "len(c_syms) =", len(c_syms)
    print "len(cpp_syms) =", len(cpp_syms)
    print "len(man_syms) =", len(man_syms)

    # Merge man symbols into C/C++ symbol indexes.
    for name, hdrs in man_syms.items():
        if name not in c_syms:
            c_syms[name] = hdrs
        if name not in cpp_syms and 'std::' + name not in cpp_syms:
            cpp_syms[name] = set(shadows.get(hdr, hdr) for hdr in hdrs)

    # Decanonicalize the C++ symbol index.
    for name, hdrs in cpp_syms.items()[:]:
        try:
            short_name = name[name.rindex('::') + 2:]
        except ValueError:
            pass
        else:
            if short_name in cpp_syms:
                print >>sys.stderr, 'conflict', name
            else:
                cpp_syms[short_name] = name

    # Manual adjustments to annoying problems.
    cpp_syms['std::cin'] = ['iostream']
    cpp_syms['std::cout'] = ['iostream']
    cpp_syms['std::cerr'] = ['iostream']
    cpp_syms['std::clog'] = ['iostream']
    cpp_syms['std::wcin'] = ['iostream']
    cpp_syms['std::wcout'] = ['iostream']
    cpp_syms['std::wcerr'] = ['iostream']
    cpp_syms['std::wclog'] = ['iostream']

    # Output a data structure for emacs.
    for name, syms in [('includeme-index-c', c_syms),
                       ('includeme-index-cpp', cpp_syms)]:
        out = open(name + '.el', 'w')
        make_happy_list(out, syms.items())

if __name__ == '__main__':
    main(*sys.argv[1:])
