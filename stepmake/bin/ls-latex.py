#!@PYTHON@

# FIXME: 
#  name isn't really appropriate now ...
#  see mudela-book: cater for different formats in uniform way

name = 'ls-latex'
version = '0.1'

import sys
import os
import string

def gulp_file(f):
	try:
		i = open(f)
		i.seek (0, 2)
		n = i.tell ()
		i.seek (0,0)
	except:
		sys.stderr.write ("can't open file: %s\n" % f)
		return ''
	s = i.read (n)
	if len (s) <= 0:
		sys.stderr.write ("gulped emty file: %s\n" % f)
	i.close ()
	return s

import __main__
import glob
import regex

latex_author_re = regex.compile(r'\\author{\([^}]+\)}')
latex_title_re = regex.compile(r'\\title{\([^}]+\)}')

class Latex_head:
    def __init__ (self):
	self.author = ''
	self.title = ''
	self.date = ''
	self.format = ''

	
def read_latex_header (fn):
    s = gulp_file (fn)
    i = regex.search( '\\\\begin{document}', s)

    if i < 0:
	sys.stderr.write ("ls-latex: no \\begin{document} in %s\n" % fn)
	s = "\\author{(unknown)}\\title{(file: %s)}" % fn
	
    s = s[:i]
    s = regsub.gsub('%.*$', '', s)
    s = regsub.gsub('\n', ' ', s)

    header = Latex_head()
    header.filename= fn;

    if latex_author_re.search (s) == -1 :
	sys.stderr.write ("ls-latex: can't find author in %s\n" % fn)
	header.author = 'unknown'
    else:
        header.author = latex_author_re.group (1)
    if latex_title_re.search (s) == -1:
	sys.stderr.write ("ls-latex: can't find title in %s\n" % fn)
	header.title = "(file: %s)" % fn
    else:
	header.title = latex_title_re.group (1)
    header.outfile = fn
    header.outfile = regsub.gsub ('\.latex$', '.ps.gz', header.outfile)
    header.outfile = regsub.gsub ('\.tex$', '.ps.gz', header.outfile)
    header.outfile = regsub.gsub ('\.doc$', '.ps.gz', header.outfile)
    header.format = 'gzipped postscript'
    return  header


bib_author_re = regex.compile('% *AUTHOR *= *\(.*\)$')
bib_title_re = regex.compile('% *TITLE *= *\(.*\)$')

def bib_header (fn):
    s = gulp_file (fn)
    if bib_author_re.search (s) == -1 :
	sys.stderr.write ('gulped file: ' + fn + '\n')
	raise 'huh?'

    header = Latex_head()
    header.filename= fn;
    header.author = bib_author_re.group (1)
    if bib_title_re.search (s) == -1:
	sys.stderr.write ('gulped file: ' + fn + '\n')
	raise 'huh?'    
    header.title = bib_title_re.group (1)
    header.outfile = regsub.gsub ( '\.bib$', '.html' , fn)
    header.format = 'HTML'    
    return header


def read_pod_header (fn):
    header = Latex_head ()
    s = gulp_file (fn)
    i = regex.search( '[^\n \t]', s)
    s = s[i:]
    i = regex.search( '\n\n', s)
    s = s[i+2:]    
    if i < 0:
	sys.stderr.write ('gulped file: ' + fn + '\n')
	raise 'huh?'
    i = regex.search( '\n\n', s)
    header.title = s[:i]
    header.filename = fn
    header.outfile = regsub.gsub ('\.pod$', '.html', fn)
    return  header

texinfo_author_re = regex.compile(r'^@author  *\(.*\) *$')
texinfo_title_re = regex.compile(r'^@title  *\(.*\) *$')

def read_texinfo_header (fn):
    header = Latex_head ()
    s = gulp_file (fn)
    if texinfo_author_re.search (s) == -1 :
	sys.stderr.write ("ls-latex: can't find author in %s\n" % fn)
	header.author = 'unknown'
    else:
        header.author = texinfo_author_re.group (1)
    if texinfo_title_re.search (s) == -1:
	sys.stderr.write ("ls-latex: can't find title in %s\n" % fn)
	header.title = "(file: %s)" % fn
    i = regex.search( '@node ', s)
    s = s[i+5:]
    i = regex.search( ',', s)
    if i < 0:
	sys.stderr.write ('gulped file: ' + fn + '\n')
	raise 'huh?'
    if not header.title:
	header.title = s[:i]
    header.filename = fn
    header.outfile = regsub.gsub ('\.texinfo$', '.html', fn)
    header.format = 'HTML'
    return  header

def read_tely_header (fn):
    header = Latex_head ()
    s = gulp_file (fn)
    if texinfo_author_re.search (s) == -1 :
	sys.stderr.write ("ls-latex: can't find author in %s\n" % fn)
	header.author = 'unknown'
    else:
        header.author = texinfo_author_re.group (1)
    if texinfo_title_re.search (s) == -1:
	sys.stderr.write ("ls-latex: can't find title in %s\n" % fn)
	header.title = "(file: %s)" % fn
    i = regex.search( '@settitle', s)
    s = s[i+10:]
    i = regex.search( '\n', s)
    if i < 0:
	sys.stderr.write ('gulped file: ' + fn + '\n')
	raise 'huh?'
    if not header.title:
	header.title = s[:i]
    header.filename = fn
    header.outfile = regsub.gsub ('\.tely', '.html', fn)
    header.format = 'HTML'
    return  header

# urg
# should make a 'next_parens'
yo_article_re = regex.compile('article(\\([^)]*\\))[ \t\n]*(\\([^)]*\\))')
yo_report_re = regex.compile('report(\\([^)]*\\))[\t\n ]*(\\([^)]*\\))')
yo_sect_re  =  regex.compile('sect(\\([^)]*\\))')
yo_chap_re  =  regex.compile('sect(\\([^)]*\\))')

def read_yo_header (fn):
    header = Latex_head ()
    s = gulp_file (fn)
    if 0:
	    pass
    elif yo_report_re.search (s) <> -1:
	    header.author = yo_report_re.group(2)
	    header.title = yo_report_re.group(1)
    elif yo_article_re.search (s) <> -1:
	    header.author = yo_article_re.group(2)
	    header.title = yo_article_re.group(1)
    elif yo_chap_re.search (s) <> -1:
	    header.title = yo_chap_re.group (1)
    elif yo_sect_re.search (s) <> -1:
	    header.title = yo_sect_re.group (1)
    header.filename = fn
    header.outfile = regsub.gsub ('\.yo$', '.html', fn)
    header.format = 'HTML'
    return  header

def print_html_head (l,o,h):
    pre =o

    l.write ('<li><a href=%s>%s (%s)</a>' % (pre + h.outfile, h.title, h.format ))
    if h.author:
	l.write ('<p>by %s</p>' % h.author)
    l.write ('</li>\n')

def help ():
    sys.stdout.write ("Usage: ls-latex [OPTION]... FILE...\n"
		 "Generate html index file for FILE...\n\n"
		 + "Options:\n"
		 + "  -h, --help             print this help\n"
		 + "  -p, --package=DIR      specify package\n"
		      )
    sys.exit (0)

import getopt

(options, files) = getopt.getopt(sys.argv[1:], 
    'e:hp:', ['help', 'prefix=', 'package=', 'title='])

tex = ''
output =''
pre = ''
title = ''
for opt in options:
    o = opt[0]
    a = opt[1]
    if o == '--prefix':
	pre = a
    elif o == '--title':
	title = a  
    elif o == '-h' or o == '--help':
    	help ()
    elif o == '-p' or o == '--package':
	topdir = a

sys.path.append (topdir + '/stepmake/bin')
from packagepython import *
package = Package (topdir)
packager = Packager ()

l = sys.stdout

l.write ('<html><title>%s</title><h1> %s</h1><ul>\n' % (title, title))


for x in files:
    if regex.search ('\\.bib$', x) <> -1:
	head = bib_header (x)
    elif regex.search ('\\.pod$', x) <> -1:
	head = read_pod_header (x)
    elif regex.search ('\\.texinfo$', x) <> -1:
	head = read_texinfo_header (x)
    elif regex.search ('\\.tely$', x) <> -1:
	head = read_tely_header (x)
    elif regex.search ('\\.yo$', x) <> -1:
	head = read_yo_header (x)
    else:
	head = read_latex_header (x)
    if head.title == '':
	head.title = head.filename
    print_html_head (l, pre, head)

l.write ('</ul></html>')

