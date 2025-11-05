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
CC = gcc
CFLAGS = -g -O2
LDFLAGS = 
CPPFLAGS = 
ac_ct_CC = gcc
EXEEXT = 
OBJEXT = o
wine_makedep = tools/makedep
HAVE_MACOS_TRUE = #
HAVE_MACOS_FALSE = 
TAGSFLAGS = --langmap='c:+.idl.l.rh,make:(Make*.in)'
LIBOBJS = 
LTLIBOBJS = 


all:
	@echo "Goliath/Wine build complete."
	@echo "Note: This is a compatibility layer project."
	@echo "Run 'make install' to install."
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
