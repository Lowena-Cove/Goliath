# This Makefile understands the following targets:
#
# all (default):   build wine
# clean:           remove all intermediate files
# distclean:       also remove all files created by configure
# test:            run tests
# testclean:       clean test results to force running all tests again
# install-lib:     install libraries needed to run applications
# install-dev:     install development environment
# install:         install everything
# uninstall:       uninstall everything
# ctags:           create a tags file for vim and others.
# etags:           create a TAGS file for Emacs.

am__quote = 
SHELL = /bin/sh
PATH_SEPARATOR = :
PACKAGE_NAME = Wine
PACKAGE_TARNAME = wine
PACKAGE_VERSION = 10.0
PACKAGE_STRING = Wine 10.0
PACKAGE_BUGREPORT = wine-devel@winehq.org
PACKAGE_URL = https://www.winehq.org
exec_prefix = ${prefix}
prefix = /usr/local
program_transform_name = s,x,x,
bindir = ${exec_prefix}/bin
sbindir = ${exec_prefix}/sbin
libexecdir = ${exec_prefix}/libexec
datarootdir = ${prefix}/share
datadir = ${datarootdir}
sysconfdir = ${prefix}/etc
sharedstatedir = ${prefix}/com
localstatedir = ${prefix}/var
runstatedir = ${localstatedir}/run
includedir = ${prefix}/include
oldincludedir = /usr/include
docdir = ${datarootdir}/doc/${PACKAGE_TARNAME}
infodir = ${datarootdir}/info
htmldir = ${docdir}
dvidir = ${docdir}
pdfdir = ${docdir}
psdir = ${docdir}
libdir = ${exec_prefix}/lib
localedir = ${datarootdir}/locale
mandir = ${datarootdir}/man
DEFS = -DHAVE_CONFIG_H
ECHO_C = 
ECHO_N = -n
ECHO_T = 
LIBS = 
build_alias = 
host_alias = 
target_alias = 
INSTALL_PROGRAM = ${INSTALL}
INSTALL_SCRIPT = ${INSTALL}
INSTALL_DATA = ${INSTALL} -m 644
am__isrc = 
CYGPATH_W = echo
PACKAGE = wine
VERSION = 10.0
ACLOCAL = ${SHELL} '/home/runner/work/Goliath/Goliath/tools/missing' aclocal-1.16
AUTOCONF = ${SHELL} '/home/runner/work/Goliath/Goliath/tools/missing' autoconf
AUTOMAKE = ${SHELL} '/home/runner/work/Goliath/Goliath/tools/missing' automake-1.16
AUTOHEADER = ${SHELL} '/home/runner/work/Goliath/Goliath/tools/missing' autoheader
MAKEINFO = ${SHELL} '/home/runner/work/Goliath/Goliath/tools/missing' makeinfo
install_sh = ${SHELL} /home/runner/work/Goliath/Goliath/tools/install-sh
STRIP = strip
INSTALL_STRIP_PROGRAM = $(install_sh) -c -s
MKDIR_P = /usr/bin/mkdir -p
mkdir_p = $(MKDIR_P)
AWK = gawk
SET_MAKE = 
am__leading_dot = .
AMTAR = $${TAR-tar}
am__tar = $${TAR-tar} chof - "$$tardir"
am__untar = $${TAR-tar} xf -
CTAGS = ctags
ETAGS = etags
CSCOPE = cscope
AM_V = $(V)
AM_DEFAULT_V = $(AM_DEFAULT_VERBOSITY)
AM_DEFAULT_VERBOSITY = 1
AM_BACKSLASH = \
LIBTOOL = $(SHELL) $(top_builddir)/libtool
build = x86_64-pc-linux-gnu
build_cpu = x86_64
build_vendor = pc
build_os = linux-gnu
host = x86_64-pc-linux-gnu
host_cpu = x86_64
host_vendor = pc
host_os = linux-gnu
CC = gcc
CFLAGS = -g -O2
LDFLAGS = 
CPPFLAGS = 
ac_ct_CC = gcc
EXEEXT = 
OBJEXT = o
DEPDIR = .deps
am__include = include
AMDEP_TRUE = 
AMDEP_FALSE = #
AMDEPBACKSLASH = \
am__nodep = _no
CCDEPMODE = depmode=gcc3
am__fastdepCC_TRUE = 
am__fastdepCC_FALSE = #
SED = /usr/bin/sed
GREP = /usr/bin/grep
EGREP = /usr/bin/grep -E
FGREP = /usr/bin/grep -F
LD = /usr/bin/ld -m elf_x86_64
DUMPBIN = 
ac_ct_DUMPBIN = 
NM = /usr/bin/nm -B
LN_S = ln -s
FILECMD = file
OBJDUMP = objdump
DLLTOOL = false
AR = ar
ac_ct_AR = ar
RANLIB = ranlib
MANIFEST_TOOL = :
DSYMUTIL = 
NMEDIT = 
LIPO = 
OTOOL = 
OTOOL64 = 
LT_SYS_LIBRARY_PATH = 
wine_makedep = tools/makedep
HAVE_MACOS_TRUE = #
HAVE_MACOS_FALSE = 
TAGSFLAGS = --langmap='c:+.idl.l.rh,make:(Make*.in)'
LIBOBJS = 
LTLIBOBJS = 
am__EXEEXT_TRUE = #
am__EXEEXT_FALSE = 


all: wine
	@echo "Wine build complete."
Makefile: config.status
	@./config.status Makefile
config.status: configure
	@./config.status --recheck
include/config.h: include/stamp-h
include/stamp-h: include/config.h.in config.status
	@./config.status include/config.h include/stamp-h
distclean:: clean
	rm -rf autom4te.cache
maintainer-clean::
	rm -f configure include/config.h.in
dlls/ntdll/unix/version.c: dummy
	@version=`(GIT_DIR=.git git describe HEAD 2>/dev/null || echo "wine-$(PACKAGE_VERSION)") | sed -n -e '$$s/\(.*\)/const char wine_build[] = "\1";/p'` && (echo $$version | cmp -s - $@) || echo $$version >$@ || (rm -f $@ && exit 1)
programs/winetest/build.rc: dummy
	@build="STRINGTABLE { 1 \"`GIT_DIR=.git git rev-parse HEAD 2>/dev/null`\" }" && (echo $$build | cmp -s - $@) || echo $$build >$@ || (rm -f $@ && exit 1)
programs/winetest/build.nfo:
	@-$(CC) -v 2>$@
dlls/wineandroid.drv/wine-debug.apk: dlls/wineandroid.drv/build.gradle dlls/wineandroid.drv/AndroidManifest.xml dlls/wineandroid.drv/WineActivity.java dlls/wineandroid.drv/wine.svg
	cd dlls/wineandroid.drv && gradle -q -Psrcdir=. assembleDebug
	mv dlls/wineandroid.drv/build/outputs/apk/wine-debug.apk $@
TAGS etags:
	rm -f TAGS
	(test -d .git && git ls-files || find -L . -name '*.[ch]' -print) | xargs etags -a $(TAGSFLAGS)
tags ctags:
	rm -f tags
	(test -d .git && git ls-files || find -L . -name '*.[ch]' -print) | xargs ctags -a $(TAGSFLAGS)
dummy:
.PHONY: dummy

### Dependencies (everything below this line is auto-generated; DO NOT EDIT!!)
.INIT: Makefile
.MAKEFILEDEPS:
.SUFFIXES:
Makefile: tools/makedep
depend: tools/makedep
	tools/makedep -C
all:
Makefile:
:
check test:
clean::
testclean::
distclean::
	rm -f .gitignore Makefile
maintainer-clean::
.PHONY: depend all check test distclean testclean maintainer-clean
