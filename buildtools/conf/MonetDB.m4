dnl The contents of this file are subject to the MonetDB Public License
dnl Version 1.1 (the "License"); you may not use this file except in
dnl compliance with the License. You may obtain a copy of the License at
dnl http://monetdb.cwi.nl/Legal/MonetDBLicense-1.1.html
dnl
dnl Software distributed under the License is distributed on an "AS IS"
dnl basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
dnl License for the specific language governing rights and limitations
dnl under the License.
dnl
dnl The Original Code is the MonetDB Database System.
dnl
dnl The Initial Developer of the Original Code is CWI.
dnl Portions created by CWI are Copyright (C) 1997-2007 CWI.
dnl All Rights Reserved.

dnl Defaults that differ between development trunk and release branch:
AC_DEFUN([AM_MONETDB_DEFAULTS],
[
dft_strict=no
dft_assert=no
dft_optimi=yes
dft_warning=no
dft_netcdf=no

dnl small hack to get icc -no-gcc, done here because AC_PROG_CC shouldn't
dnl set GCC=yes if we use icc.
case "$CC" in
*icc*-no-gcc*) ;;
*icc*)
	dnl  Since version 8.0, ecc/ecpc are also called icc/icpc,
	dnl  and icc/icpc requires "-no-gcc" to avoid predefining
	dnl  __GNUC__, __GNUC_MINOR__, and __GNUC_PATCHLEVEL__ macros.
	icc_ver="`$CC -dumpversion 2>/dev/null`"
	case $icc_ver in
	8.*)	CC="$CC -no-gcc";;
	9.*)	CC="$CC -no-gcc";;
	10.*)	CC="$CC -no-gcc";;
	esac
	;;
esac

])


dnl  setting various path-variables; part 1
AC_DEFUN([AM_MONETDB_XQ_VARS_1],
[
# if no --prefix option, we must set Qprefix to the default value
# the problem is that prefix is set very late in the process if it
# wasn't set by --prefix
if test "${prefix}x" = "NONEx"; then
	Qprefix="${ac_default_prefix}"
else
	Qprefix="${prefix}"
fi
Qprefix="`echo "$Qprefix" | sed 's/\\\\/\\\\\\\\/g'`"
AC_SUBST(Qprefix)
# exec_prefix is created very late, so let make do the expansion
if test "${exec_prefix}x" = "NONEx"; then
	Qexec_prefix='${prefix}'
else
	Qexec_prefix="`echo "$exec_prefix" | sed 's/\\\\/\\\\\\\\/g'`"
fi
AC_SUBST(Qexec_prefix)
])

dnl  setting various path-variables; part 2
AC_DEFUN([AM_MONETDB_XQ_VARS_2],
[
dnl provide different versions of the paths derived above
if test "${prefix}x" = "NONEx"; then
	Xprefix="`$translatepath "$Qprefix"`"
	QXprefix="`echo "$Xprefix" | sed 's/\\\\/\\\\\\\\/g'`"
else
	Xprefix="`$translatepath "$prefix"`"
	QXprefix="`echo "$Xprefix" | sed 's/\\\\/\\\\\\\\/g'`"
fi
if test "${exec_prefix}x" = "NONEx"; then
	Xexec_prefix="`$translatepath "$Qexec_prefix"`"
	QXexec_prefix="`echo "$Xexec_prefix" | sed 's/\\\\/\\\\\\\\/g'`"
else
	Xexec_prefix="`$translatepath "$exec_prefix"`"
	QXexec_prefix="`echo "$Xexec_prefix" | sed 's/\\\\/\\\\\\\\/g'`"
fi
AC_SUBST(Xprefix)
AC_SUBST(QXprefix)
AC_SUBST(Xexec_prefix)
AC_SUBST(QXexec_prefix)
Qsrcdir="$srcdir"
Xsrcdir="`$translatepath "$srcdir"`"
QXsrcdir="`echo "$Xsrcdir" | sed 's/\\\\/\\\\\\\\/g'`"
AC_SUBST(Qsrcdir)
AC_SUBST(Xsrcdir)
AC_SUBST(QXsrcdir)
Qlocalstatedir="$localstatedir"
Xlocalstatedir="`$translatepath "$localstatedir"`"
QXlocalstatedir="`echo "$Xlocalstatedir" | sed 's/\\\\/\\\\\\\\/g'`"
AC_SUBST(Qlocalstatedir)
AC_SUBST(Xlocalstatedir)
AC_SUBST(QXlocalstatedir)
Qlibdir="$libdir"
Xlibdir="`$translatepath "$libdir"`"
QXlibdir="`echo "$Xlibdir" | sed 's/\\\\/\\\\\\\\/g'`"
AC_SUBST(Qlibdir)
AC_SUBST(Xlibdir)
AC_SUBST(QXlibdir)
Qsysconfdir="$sysconfdir"
Xsysconfdir="`$translatepath "$sysconfdir"`"
QXsysconfdir="`echo "$Xsysconfdir" | sed 's/\\\\/\\\\\\\\/g'`"
AC_SUBST(Qsysconfdir)
AC_SUBST(Xsysconfdir)
AC_SUBST(QXsysconfdir)
Qbindir="$bindir"
Xbindir="`$translatepath "$bindir"`"
QXbindir="`echo "$Xbindir" | sed 's/\\\\/\\\\\\\\/g'`"
AC_SUBST(Qbindir)
AC_SUBST(Xbindir)
AC_SUBST(QXbindir)
Qlibexecdir="$libexecdir"
Xlibexecdir="`$translatepath "$libexecdir"`"
QXlibexecdir="`echo "$Xlibexecdir" | sed 's/\\\\/\\\\\\\\/g'`"
AC_SUBST(Qlibexecdir)
AC_SUBST(Xlibexecdir)
AC_SUBST(QXlibexecdir)
Qdatarootdir="$datarootdir"
Xdatarootdir="`$translatepath "$datarootdir"`"
QXdatarootdir="`echo "$Xdatarootdir" | sed 's/\\\\/\\\\\\\\/g'`"
AC_SUBST(Qdatarootdir)
AC_SUBST(Xdatarootdir)
AC_SUBST(QXdatarootdir)
if test "${datadir}" = '${datarootdir}'; then
	datadir="${datarootdir}"
fi
Qdatadir="$datadir"
Xdatadir="`$translatepath "$datadir"`"
QXdatadir="`echo "$Xdatadir" | sed 's/\\\\/\\\\\\\\/g'`"
AC_SUBST(Qdatadir)
AC_SUBST(Xdatadir)
AC_SUBST(QXdatadir)
Qmandir="$mandir"
Xmandir="`$translatepath "$mandir"`"
QXmandir="`echo "$Xmandir" | sed 's/\\\\/\\\\\\\\/g'`"
AC_SUBST(Qmandir)
AC_SUBST(Xmandir)
AC_SUBST(QXmandir)
Qincludedir="$includedir"
Xincludedir="`$translatepath "$includedir"`"
QXincludedir="`echo "$Xincludedir" | sed 's/\\\\/\\\\\\\\/g'`"
AC_SUBST(Qincludedir)
AC_SUBST(Xincludedir)
AC_SUBST(QXincludedir)
Qinfodir="$infodir"
Xinfodir="`$translatepath "$infodir"`"
QXinfodir="`echo "$Xinfodir" | sed 's/\\\\/\\\\\\\\/g'`"
AC_SUBST(Qinfodir)
AC_SUBST(Xinfodir)
AC_SUBST(QXinfodir)
])


dnl VERSION_TO_NUMBER macro (copied from libxslt)
AC_DEFUN([MONETDB_VERSION_TO_NUMBER],
[`$1 | sed 's|[[_\-]][[a-zA-Z0-9]]*$||' | awk 'BEGIN { FS = "."; } { printf "%d", ([$]1 * 1000 + [$]2) * 1000 + [$]3;}'`])

AC_DEFUN([AM_MONETDB_COMMON],
[

dnl check for MonetDB Common Libraries
have_monetdb=auto
MONETDB_LIBS=""
MONETDB_MODS=""
MONETDB_MOD_PATH=""
MONETDB_PREFIX="."
if test "x$1" = "x"; then
  MONETDB_REQUIRED_VERSION="1.20.0"
  #                         ^^^^^^
  # Maintained via vertoo. Please don't modify by hand!
  # Contact MonetDB-developers@lists.sourceforge.net for details and/or assistance.
else
  MONETDB_REQUIRED_VERSION="$1"
fi
AC_ARG_WITH(monetdb,
	AC_HELP_STRING([--with-monetdb=DIR], [MonetDB Common is installed in DIR]),
	have_monetdb="$withval")
if test "x$have_monetdb" != xno; then
  case "$have_monetdb" in
  yes|auto) MPATH="${MONETDB_PREFIX+$MONETDB_PREFIX/bin:}$PATH:$prefix/bin";;
  *) MPATH="$withval/bin:$PATH";;
  esac
  AC_PATH_PROG(MONETDB_CONFIG,monetdb-config,,$MPATH)

  if test "x$MONETDB_CONFIG" != x; then
    AC_MSG_CHECKING(whether MonetDB Common version $MONETDB_REQUIRED_VERSION or newer is installed) 
    MONETDB_VERSION=`$MONETDB_CONFIG --version`
    if test MONETDB_VERSION_TO_NUMBER(echo $MONETDB_VERSION) -ge MONETDB_VERSION_TO_NUMBER(echo $MONETDB_REQUIRED_VERSION); then
      have_monetdb=yes
      AC_MSG_RESULT($have_monetdb: found version $MONETDB_VERSION)
    else
      have_monetdb=no
      AC_MSG_RESULT($have_monetdb: found only version $MONETDB_VERSION)
    fi
  fi

  if test "x$have_monetdb" != xyes; then
    MONETDB_INCS=""
    MONETDB_INCLUDEDIR=""
    MONETDB_LIBS=""
    MONETDB_PREFIX=""
    MONETDB_CONFDIR=""
  else
    MONETDB_INCS=`$MONETDB_CONFIG --includes`
    MONETDB_INCLUDEDIR=`$MONETDB_CONFIG --pkgincludedir`
    MONETDB_LIBS=`$MONETDB_CONFIG --libs`
    MONETDB_PREFIX=`$MONETDB_CONFIG --prefix`
    MONETDB_CONFDIR=`$MONETDB_CONFIG --pkgdatadir`/conf
  fi
fi
AC_SUBST(MONETDB_INCS)
AC_SUBST(MONETDB_INCLUDEDIR)
AC_SUBST(MONETDB_LIBS)
AC_SUBST(MONETDB_PREFIX)
AC_SUBST(MONETDB_CONFDIR)
AC_SUBST(MONETDB_VERSION)
AM_CONDITIONAL(HAVE_MONETDB,test x$have_monetdb = xyes)
]) dnl AC_DEFUN AM_MONETDB_COMMON

AC_DEFUN([AM_MONETDB_CLIENTS],
[

dnl check for MonetDB Client Libraries
have_clients=auto
CLIENTS_CFLAGS=""
CLIENTS_LIBS=""
CLIENTS_MODS=""
CLIENTS_MOD_PATH=""
CLIENTS_PREFIX="."
if test "x$1" = "x"; then
  CLIENTS_REQUIRED_VERSION="1.20.0"
  #                         ^^^^^^
  # Maintained via vertoo. Please don't modify by hand!
  # Contact MonetDB-developers@lists.sourceforge.net for details and/or assistance.
else
  CLIENTS_REQUIRED_VERSION="$1"
fi
AC_ARG_WITH(clients,
	AC_HELP_STRING([--with-clients=DIR], [MonetDB Clients is installed in DIR]),
	have_clients="$withval")
if test "x$have_clients" != xno; then
  case "$have_clients" in
  yes|auto) MPATH="${CLIENTS_PREFIX+$CLIENTS_PREFIX/bin:}$PATH:$prefix/bin";;
  *) MPATH="$withval/bin:$PATH";;
  esac
  AC_PATH_PROG(CLIENTS_CONFIG,monetdb-clients-config,,$MPATH)

  if test "x$CLIENTS_CONFIG" != x; then
    AC_MSG_CHECKING(whether MonetDB Clients version $CLIENTS_REQUIRED_VERSION or newer is installed) 
    CLIENTS_VERSION=`$CLIENTS_CONFIG --version`
    if test MONETDB_VERSION_TO_NUMBER(echo $CLIENTS_VERSION) -ge MONETDB_VERSION_TO_NUMBER(echo $CLIENTS_REQUIRED_VERSION); then
      have_clients=yes
      AC_MSG_RESULT($have_clients: found version $CLIENTS_VERSION)
    else
      have_clients=no
      AC_MSG_RESULT($have_clients: found only version $CLIENTS_VERSION)
    fi
  fi

  if test "x$have_clients" != xyes; then
    CLIENTS_CFLAGS=""
    CLIENTS_INCS=""
    CLIENTS_INCLUDEDIR=""
    CLIENTS_LIBS=""
    CLIENTS_PREFIX=""
    CLIENTS_CONFDIR=""
  else
    CLIENTS_CFLAGS=`$CLIENTS_CONFIG --cflags`
    CLIENTS_INCS=`$CLIENTS_CONFIG --includes`
    CLIENTS_INCLUDEDIR=`$CLIENTS_CONFIG --pkgincludedir`
    CLIENTS_LIBS=`$CLIENTS_CONFIG --libs`
    CLIENTS_PREFIX=`$CLIENTS_CONFIG --prefix`
    CLIENTS_CONFDIR=`$CLIENTS_CONFIG --pkgdatadir`/conf
  fi
fi
AC_SUBST(CLIENTS_CFLAGS)
AC_SUBST(CLIENTS_INCS)
AC_SUBST(CLIENTS_INCLUDEDIR)
AC_SUBST(CLIENTS_LIBS)
AC_SUBST(CLIENTS_PREFIX)
AC_SUBST(CLIENTS_CONFDIR)
AC_SUBST(CLIENTS_VERSION)
AM_CONDITIONAL(HAVE_CLIENTS,test x$have_clients = xyes)
]) dnl AC_DEFUN AM_MONETDB_CLIENTS

AC_DEFUN([AM_MONETDB4],
[

dnl check for monetdb4
have_monetdb4=auto
MONETDB4_CFLAGS=""
MONETDB4_LIBS=""
MONETDB4_MODS=""
MONETDB4_MOD_PATH=""
MONETDB4_PREFIX="."
if test "x$1" = "x"; then
  MONETDB4_REQUIRED_VERSION="4.20.0"
  #                          ^^^^^^
  # Maintained via vertoo. Please don't modify by hand!
  # Contact MonetDB-developers@lists.sourceforge.net for details and/or assistance.
else
  MONETDB4_REQUIRED_VERSION="$1"
fi
AC_ARG_WITH(monetdb4,
	AC_HELP_STRING([--with-monetdb4=DIR], [MonetDB4 is installed in DIR]),
	have_monetdb4="$withval")
if test "x$have_monetdb4" != xno; then
  case "$have_monetdb4" in
  yes|auto) MPATH="${MONETDB4_PREFIX+$MONETDB4_PREFIX/bin:}$PATH:$prefix/bin";;
  *) MPATH="$withval/bin:$PATH";;
  esac
  AC_PATH_PROG(MONETDB4_CONFIG,monetdb4-config,,$MPATH)

  if test "x$MONETDB4_CONFIG" != x; then
    AC_MSG_CHECKING(whether MonetDB4 version $MONETDB4_REQUIRED_VERSION or newer is installed) 
    MONETDB4_VERSION=`$MONETDB4_CONFIG --version`
    if test MONETDB_VERSION_TO_NUMBER(echo $MONETDB4_VERSION) -ge MONETDB_VERSION_TO_NUMBER(echo $MONETDB4_REQUIRED_VERSION); then
      have_monetdb4=yes
      AC_MSG_RESULT($have_monetdb4: found version $MONETDB4_VERSION)
    else
      have_monetdb4=no
      AC_MSG_RESULT($have_monetdb4: found only version $MONETDB4_VERSION)
    fi
  fi

  if test "x$have_monetdb4" != xyes; then
    MONETDB4_CFLAGS=""
    MONETDB4_INCS=""
    MONETDB4_INCLUDEDIR=""
    MONETDB4_LIBS=""
    MONETDB4_MODS=""
    MONETDB4_MOD_PATH=""
    MONETDB4_PREFIX=""
  else
    MONETDB4_CFLAGS=`$MONETDB4_CONFIG --cflags`
    MONETDB4_INCS=`$MONETDB4_CONFIG --includes`
    MONETDB4_INCLUDEDIR=`$MONETDB4_CONFIG --pkgincludedir`
    MONETDB4_LIBS=`$MONETDB4_CONFIG --libs`
    MONETDB4_MODS=`$MONETDB4_CONFIG --mods | sed 's/-L\([[^ ]]*\)/& -R\1/g'`
    MONETDB4_MOD_PATH=`$MONETDB4_CONFIG --modpath`
    MONETDB4_PREFIX=`$MONETDB4_CONFIG --prefix`
  fi
fi
AC_SUBST(MONETDB4_CFLAGS)
AC_SUBST(MONETDB4_INCS)
AC_SUBST(MONETDB4_INCLUDEDIR)
AC_SUBST(MONETDB4_LIBS)
AC_SUBST(MONETDB4_MODS)
AC_SUBST(MONETDB4_MOD_PATH)
AC_SUBST(MONETDB4_PREFIX)
AC_SUBST(MONETDB4_VERSION)
AC_SUBST(CLASSPATH)
AM_MONETDB_MEL("NO ABORT")
AM_CONDITIONAL(HAVE_MONETDB4,test x$have_monetdb4 = xyes -a x$have_mel = xyes)
]) dnl AC_DEFUN AM_MONETDB4

AC_DEFUN([AM_MONETDB5],
[

dnl check for monetdb5
have_monetdb5=auto
MONETDB5_CFLAGS=""
MONETDB5_LIBS=""
MONETDB5_MODS=""
MONETDB5_MOD_PATH=""
MONETDB5_PREFIX="."
if test "x$1" = "x"; then
  MONETDB5_REQUIRED_VERSION="5.2.0"
  #                          ^^^^^
  # Maintained via vertoo. Please don't modify by hand!
  # Contact MonetDB-developers@lists.sourceforge.net for details and/or assistance.
else
  MONETDB5_REQUIRED_VERSION="$1"
fi
AC_ARG_WITH(monetdb5,
	AC_HELP_STRING([--with-monetdb5=DIR], [MonetDB5 is installed in DIR]),
	have_monetdb5="$withval")
if test "x$have_monetdb5" != xno; then
  case "$have_monetdb5" in
  yes|auto) MPATH="${MONETDB5_PREFIX+$MONETDB5_PREFIX/bin:}$PATH:$prefix/bin";;
  *) MPATH="$withval/bin:$PATH";;
  esac
  AC_PATH_PROG(MONETDB5_CONFIG,monetdb5-config,,$MPATH)

  if test "x$MONETDB5_CONFIG" != x; then
    AC_MSG_CHECKING(whether MonetDB5 version $MONETDB5_REQUIRED_VERSION or newer is installed) 
    MONETDB5_VERSION=`$MONETDB5_CONFIG --version`
    if test MONETDB_VERSION_TO_NUMBER(echo $MONETDB5_VERSION) -ge MONETDB_VERSION_TO_NUMBER(echo $MONETDB5_REQUIRED_VERSION); then
      have_monetdb5=yes
      AC_MSG_RESULT($have_monetdb5: found version $MONETDB5_VERSION)
    else
      have_monetdb5=no
      AC_MSG_RESULT($have_monetdb5: found only version $MONETDB5_VERSION)
    fi
  fi

  if test "x$have_monetdb5" != xyes; then
    MONETDB5_CFLAGS=""
    MONETDB5_INCS=""
    MONETDB5_INCLUDEDIR=""
    MONETDB5_LIBS=""
    MONETDB5_MODS=""
    MONETDB5_MOD_PATH=""
    MONETDB5_PREFIX=""
    # can't use MONETDB5_CONFIG: already in use, MONETDBCONFIG is out of line
    MONETDB5_CONFFILE=""
  else
    MONETDB5_CFLAGS=`$MONETDB5_CONFIG --cflags`
    MONETDB5_INCS=`$MONETDB5_CONFIG --includes`
    MONETDB5_INCLUDEDIR=`$MONETDB5_CONFIG --pkgincludedir`
    MONETDB5_LIBS=`$MONETDB5_CONFIG --libs`
    MONETDB5_MODS=`$MONETDB5_CONFIG --mods | sed 's/-L\([[^ ]]*\)/& -R\1/g'`
    MONETDB5_MOD_PATH=`$MONETDB5_CONFIG --modpath`
    MONETDB5_PREFIX=`$MONETDB5_CONFIG --prefix`
    MONETDB5_CONFFILE=`$MONETDB_CONFIG --sysconfdir`/monetdb5.conf
  fi
fi
AC_SUBST(MONETDB5_CFLAGS)
AC_SUBST(MONETDB5_INCS)
AC_SUBST(MONETDB5_INCLUDEDIR)
AC_SUBST(MONETDB5_LIBS)
AC_SUBST(MONETDB5_MODS)
AC_SUBST(MONETDB5_MOD_PATH)
AC_SUBST(MONETDB5_PREFIX)
AC_SUBST(MONETDB5_VERSION)
AM_CONDITIONAL(HAVE_MONETDB5,test x$have_monetdb5 = xyes)
]) dnl AC_DEFUN AM_MONETDB5

AC_DEFUN([AM_MONETDB_COMPILER],
[

AC_PROG_CPP()
dnl check for compiler (also set GCC (yes/no)).
AC_PROG_CC()

gcc_ver=""
icc_ver=""
case $GCC-$CC in
yes-*)	gcc_ver="`$CC -dumpversion 2>/dev/null`";;
-*icc*)	icc_ver="`$CC -dumpversion 2>/dev/null`";;
esac

AC_ARG_WITH(bits,
	AC_HELP_STRING([--with-bits=BITS],
		[obsolete: use --enable-bits instead]),
	AC_MSG_ERROR([argument --with-bits is obsolete: use --enable-bits instead]))

bits="no"
AC_ARG_ENABLE(bits,
	AC_HELP_STRING([--enable-bits=BITS],
		[specify number of bits (32 or 64)]), [
case $enableval in
32)	case "$host" in
	ia64*)	AC_MSG_ERROR([we do not support 32 bits on $host, yet]);;
	esac
	;;
64)	case "$host-$GCC-$CC" in
	i?86*-*-*)  AC_MSG_ERROR([$host does not support 64 bits]);;
	esac
	;;
*)	AC_MSG_ERROR(--enable-bits argument must be either 32 or 64);;
esac
bits=$enableval
])
if test "$bits" = "64"; then
	dnl  Keep in mind how to call the 32-bit compiler.
	case "$GCC-$CC-$host_os-$host" in
	yes-*-linux*-x86_64*)
		dnl  On our x86_64 machine, "gcc" defaults to "gcc -m64" ...
		CC32="$CC -m32";;
	-pgcc*-linux*-x86_64*)
		dnl  On our x86_64 machine, "pgcc" defaults to "pgcc -tp=k8-64" ...
		CC32="$CC -tp=k8-32";;
	*)	CC32="$CC";;
	esac
fi
if test x"$bits" != xno; then
case "$GCC-$CC-$host_os-$host-$bits" in
yes-*-solaris*-64)
	case `$CC -v 2>&1` in
	*'gcc version 3.'*)	;;
	*)	AC_MSG_ERROR([need GCC version 3.X for 64 bits]);;
	esac
	CC="$CC -m$bits"
	;;
-*-solaris*-64)
	CC="$CC -xarch=v9"
	;;
yes-*-irix*-64)
	CC="$CC -mabi=$bits"
	;;
-*-irix*-64)
	CC="$CC -$bits"
	;;
yes-*-aix*-64)
	CC="$CC -maix$bits"
	AR="ar -X64"
	NM="nm -X64 -B"
	;;
-*-aix*-64)
	CC="$CC -q$bits"
	AR="ar -X64"
	NM="nm -X64 -B"
	;;
yes-*-linux*-x86_64*-*)
	CC="$CC -m$bits"
	;;
-pgcc*-linux*-x86_64*-*)
	CC="$CC -tp=k8-$bits"
	;;
yes-*-darwin8*-powerpc*-*)
	CC="$CC -m$bits"
	;;
esac
else
	AC_CHECK_SIZEOF(long)
	bits=`expr $ac_cv_sizeof_long \* 8`
fi
AC_SUBST(bits)

oids=$bits
AC_ARG_ENABLE(oid32,
	AC_HELP_STRING([--enable-oid32],
		[use 32 bits vor OIDs on a 64-bit architecture]),
	enable_oid32=$enableval,
	enable_oid32=no)
case $enable_oid32 in
yes)	AC_DEFINE(MONET_OID32, 1, [Define if the oid type should use 32 bits on a 64-bit architecture])
	oids=32
	;;
esac
AC_SUBST(oids)

AC_C_BIGENDIAN()

LINUX_DIST=''
case "$host_os" in
    linux*)
	AC_MSG_CHECKING(which Linux distribution we're using) 
	dnl  Please keep this aligned / in sync with TestTools/.Mconfig.rc & TestTools/MdoServer & MonetDB/src/testing/Mtest.py.in !
	if test -s /etc/fedora-release ; then
		LINUX_DIST="`cat /etc/fedora-release | head -n1 \
			| sed 's|^.*\(Fedora\).* release \([[0-9]][[^ \n]]*\)\( .*\)*$|\1:\2|'`" 
	elif test -s /etc/centos-release ; then
		LINUX_DIST="`cat /etc/centos-release | head -n1 \
			| sed 's|^\(CentOS\) release \([[0-9]][[^ \n]]*\)\( .*\)*$|\1:\2|'`"
	elif test -s /etc/yellowdog-release ; then
		LINUX_DIST="`cat /etc/yellowdog-release | head -n1 \
			| sed 's|^\(Yellow\) Dog Linux release \([[0-9]][[^ \n]]*\)\( .*\)*$|\1:\2|'`"
	elif test -s /etc/redhat-release ; then
		LINUX_DIST="`cat /etc/redhat-release | head -n1 \
			| sed 's|^.*\(Red\) \(Hat\).* Linux *\([[A-Z]]*\) release \([[0-9]][[^ \n]]*\)\( .*\)*$|\1\2:\4\3|' \
			| sed 's|^Red Hat Enterprise Linux \([[AW]]S\) release \([[0-9]][[^ \n]]*\)\( .*\)*$|RHEL:\2\1|' \
			| sed 's|^\(CentOS\) release \([[0-9]][[^ \n]]*\)\( .*\)*$|\1:\2|' \
			| sed 's|^\(Scientific\) Linux SL release \([[0-9]][[^ \n]]*\)\( .*\)*$|\1:\2|'`" 
	elif test -s /etc/SuSE-release ; then
		LINUX_DIST="`cat /etc/SuSE-release   | head -n1 \
			| sed 's|^.*\(S[[Uu]]SE\) LINUX Enterprise \([[SD]]\)[[ervsktop]]* \([[0-9]][[^ \n]]*\)\( .*\)*$|\1:\3E\2|' \
			| sed 's|^S[[Uu]]SE LINUX Enterprise \([[SD]]\)[[ervsktop]]* \([[0-9]][[^ \n]]*\)\( .*\)*$|SLE\1:\2|' \
			| sed 's|^.*\(S[[Uu]]SE\) [[Ll]][[Ii]][[Nn]][[Uu]][[Xx]].* \([[0-9]][[^ \n]]*\)\( .*\)*$|\1:\2|' \
			| sed 's|^open\(S[[Uu]]SE\) \([[0-9]][[^ \n]]*\)\( .*\)*$|\1:\2|'`"
	elif test -s /etc/gentoo-release ; then
		LINUX_DIST="`cat /etc/gentoo-release | head -n1 \
			| sed 's|^.*\(Gentoo\) Base System.* [[versionrelease]]* \([[0-9]][[^ \n]]*\)\( .*\)*$|\1:\2|'`" 
	elif test -s /etc/debian_version ; then
		LINUX_DIST="Debian:`cat /etc/debian_version | head -n1`"
	else
		LINUX_DIST="`uname -s`:`uname -r | sed 's|^\([[0-9\.]]*\)\([[^0-9\.]].*\)$|\1|'`"
	fi
	LINUX_DIST="`echo "$LINUX_DIST" | sed 's|:||'`"
	AC_MSG_RESULT($LINUX_DIST)
	;;
esac
AC_SUBST(LINUX_DIST)

dnl MonetDB code requires some POSIX and XOPEN extensions 
case "$GCC-$CC-$host_os" in
yes-*-*)
	case "$host_os" in
	cygwin*|freebsd*|irix*|darwin*)
		;;
	solaris*)
		AC_DEFINE(__EXTENSIONS__, 1, [Compiler flag])
		dnl also add __EXTENSIONS__ to the CFLAGS as the Mapi swig 
		dnl clients include monetdb_config to late
		CFLAGS="$CFLAGS -D__EXTENSIONS__"
		;;
	*)
		AC_DEFINE(_POSIX_C_SOURCE, 200112L, [Compiler flag])
		AC_DEFINE(_POSIX_SOURCE, 1, [Compiler flag])
		AC_DEFINE(_XOPEN_SOURCE, 600, [Compiler flag])
		;;
	esac
	case "$gcc_ver-$host_os" in
	[[34]].*-linux-gnulibc1)
		dnl this is for FreeBSD with linux compat libraries
		AC_DEFINE(__BSD_VISIBLE, 1, [Compiler flag])
		;;
	esac
	;;
-icc*-linux*|-ecc*-linux*|-pgcc*-linux*)
	dnl Define the same settings as for gcc, as we use the same
	dnl header files
	AC_DEFINE(_POSIX_C_SOURCE, 200112L, [Compiler flag])
	AC_DEFINE(_POSIX_SOURCE, 1, [Compiler flag])
	AC_DEFINE(_XOPEN_SOURCE, 600, [Compiler flag])
	;;
esac

dnl  default javac flags
JAVACFLAGS="$JAVACFLAGS -g:none -O"
AC_SUBST(JAVACFLAGS)


dnl --enable-strict
AC_ARG_ENABLE(strict,
	AC_HELP_STRING([--enable-strict],
		[enable strict compiler flags [default=$dft_strict]]),
	enable_strict=$enableval,
	enable_strict=$dft_strict)
dnl  Set compiler switches.
dnl  The idea/goal is to be as strict as possible, i.e., enable preferable
dnl  *all* warnings and make them errors. This should help keeping the code
dnl  as clean and portable as possible.
dnl  It turned out, though, that this, especially turning all warnings into 
dnl  errors is a bit too ambitious for configure/autoconf. Hence, we set
dnl  the standard CFLAGS to what configure/autoconf can cope with
dnl  (basically everything except "-Werror"). For "-Werror" and some
dnl  switches that disable selected warnings that haven't been sorted out,
dnl  yet, we set X_CFLAGS, which are added to the standard
dnl  CFLAGS once configure/autoconf are done with their job,
dnl  i.e., at the end of the configure.m4 file that includes this monet.m4.
dnl  Only GNU (gcc) and Intel ([ie]cc/[ie]cpc on Linux) are done so far.
: ${X_CFLAGS=} # initialize to empty if not set
NO_X_CFLAGS='_NO_X_CFLAGS_'
NO_INLINE_CFLAGS=""
GCC_BISON_CFLAGS=""
ICC_BISON_CFLAGS=""
CFLAGS_NO_OPT="-O0"
if test "x$enable_strict" = xyes; then
case "$GCC-$CC-$host_os" in
yes-*-*)
	dnl  GNU (gcc/g++)
	case "$gcc_ver-$host_os" in
	*-cygwin*)
		LDFLAGS="$LDFLAGS -no-undefined"
		;;
	*-mingw*)
		dnl  On MinGW we need the -Wno-format flag since gcc
		dnl  doesn't know about the %I64d format string for
		dnl  long long
		X_CFLAGS="$X_CFLAGS -Wno-format"
		LDFLAGS="$LDFLAGS -no-undefined -L/usr/lib/w32api"
		;;
	esac
	dnl  Be picky; "-Werror" seems to be too rigid for autoconf...
	CFLAGS="$CFLAGS -Wall"
	case "$gcc_ver-$host_os" in
	3.[[4-9]].*-*|[[4-9]].*-*)
		CFLAGS="$CFLAGS -Wextra";;
	*)
		CFLAGS="$CFLAGS -W";;
	esac
	dnl  Be rigid; MonetDB code is supposed to adhere to this... ;-)
	    X_CFLAGS="$X_CFLAGS -Werror-implicit-function-declaration"
	    X_CFLAGS="$X_CFLAGS -Werror"
	dnl  Make sure that gcc is as strict as icc, MSVC++, etc.:
	    X_CFLAGS="$X_CFLAGS -Wpointer-arith"
	case "$gcc_ver-$host_os" in
	3.[[4-9]].*-*|[[4-9]].*-*)
	    X_CFLAGS="$X_CFLAGS -Wdeclaration-after-statement";;
	esac
	X_CFLAGS="$X_CFLAGS -Wundef"
	dnl  The default configure invocation when doing an rpmbuild also uses this
	X_CFLAGS="$X_CFLAGS -Wp,-D_FORTIFY_SOURCE=2"
	dnl  Some versions of flex & bison seem to generate code
	dnl  that does not compile with `gcc -Wundef`;
	dnl  we use GCC_BISON_CFLAGS to disable the respective warning as
	dnl  locally as possible via "-Wno-undef"
	dnl  (see also MonetDB4/src/monet/Makefile.ag, sql/src/server/Makefile.ag,
	dnl   pathfinder/modules/pftijah/Makefile.ag, amdb/src/lang/Makefile.ag).
	GCC_BISON_CFLAGS="$GCC_BISON_CFLAGS -Wno-undef"
	dnl  Our code it not (yet?) up to these:
	dnl X_CFLAGS="$X_CFLAGS -Wshadow"
	dnl X_CFLAGS="$X_CFLAGS -Wconversion"
	dnl X_CFLAGS="$X_CFLAGS -Wstrict-prototypes"
	dnl X_CFLAGS="$X_CFLAGS -Wold-style-definition"
	dnl X_CFLAGS="$X_CFLAGS -Wmissing-prototypes"
	dnl X_CFLAGS="$X_CFLAGS -Wmissing-declarations"
	dnl X_CFLAGS="$X_CFLAGS -Wmissing-format-attribute"
	dnl X_CFLAGS="$X_CFLAGS -Wredundant-decls"
	dnl X_CFLAGS="$X_CFLAGS -Wnested-externs"
	dnl X_CFLAGS="$X_CFLAGS -Wunreachable-code"
	dnl  ... however, some things are beyond our control:
	case $gcc_ver-$host_os in
	2.9*-aix*)
		dnl  In some cases, there is a (possibly) uninitialized
		dnl  variable in bison.simple ... |-(
		dnl  However, gcc-2.9-aix51-020209 on SARA's solo
		dnl  seems to ignore "-Wno-uninitialized";
		dnl  hence, we switch-off "-Werror" by disabling
		dnl  X_CFLAGS locally in src/monet/Makefile.ag:
		dnl  @NO_X_CFLAGS@ with NO_X_CFLAGS='X_CFLAGS'
		dnl  generates "X_CFLAGS =" in the generated Makefile.
		NO_X_CFLAGS='X_CFLAGS'
		;;
	*-solaris*|*-darwin*|*-aix*)
		dnl  In some cases, there is a (possibly) uninitialized
		dnl  variable in bison.simple ... |-(
		X_CFLAGS="$X_CFLAGS -Wno-uninitialized"
		;;
	esac
	NO_INLINE_CFLAGS="-fno-inline -fno-inline-functions"
	;;
-icc*-linux*|-ecc*-linux*)
	dnl  Intel ([ie]cc/[ie]cpc on Linux)
 	LDFLAGS="$LDFLAGS -i_dynamic"
	dnl  Let warning #140 "too many arguments in function call"
	dnl  become an error to make configure tests work properly.
	CFLAGS="$CFLAGS -we140"
	dnl  Check for PIC does not work with Version 8.1, unless we disable
	dnl  remark #1418: external definition with no prior declaration ... !?
	case $icc_ver in
	8.1*)	CFLAGS="$CFLAGS -wd1418" ;;
	9.*)	CFLAGS="$CFLAGS -wd1418" ;;
	10.*)	CFLAGS="$CFLAGS -wd1418" 
		dnl icc needs -fPIC (but the current autoconf still uses -KPIC)
		CC="$CC -fPIC"		 ;;
	*)	;;
	esac
	dnl  Version 8.* doesn't find sigset_t when -ansi is set... !?
	case $icc_ver in
	8.*)	;;
	9.*)	;;
	10.*)	;;
	*)	CFLAGS="$CFLAGS -ansi";;
	esac
	dnl  Be picky; "-Werror" seems to be too rigid for autoconf...
	CFLAGS="$CFLAGS -Wall -w2"
	dnl  Be rigid; MonetDB code is supposed to adhere to this... ;-)
	dnl  Let warning #266 "function declared implicitly" become an error.
	X_CFLAGS="$X_CFLAGS -we266"
	X_CFLAGS="$X_CFLAGS -Werror"
	dnl  ... however, some things aren't solved, yet:
	dnl  (for the time being,) we need to disable some warnings (making them remarks doesn't seem to work with -Werror):
	X_CFLAGS="$X_CFLAGS -wd1418,1419,279,981,810,193,111,1357"
	case $icc_ver in
	8.[[1-9]]*)	X_CFLAGS="$X_CFLAGS,1572" ;;
	9.[[1-9]]*)	X_CFLAGS="$X_CFLAGS,1572,1599" ;;
	10.*)		X_CFLAGS="$X_CFLAGS,1572,1599" ;;
	esac
	dnl  #1418: external definition with no prior declaration
	dnl  #1419: external declaration in primary source file
	dnl  # 279: controlling expression is constant
	dnl  # 981: operands are evaluated in unspecified order
	dnl  # 810: conversion from "." to "." may lose significant bits
	dnl  # 193: zero used for undefined preprocessing identifier
	dnl  # 111: statement is unreachable
	dnl  #1357: optimization disabled due to excessive resource requirements; contact Intel Premier Support for assistance
	dnl  #1572: floating-point equality and inequality comparisons are unreliable
	dnl  #1599: declaration hides variable 

	dnl  (At least on Fedora Core 4,) bison 2.0 seems to generate code
	dnl  that icc does not like; since the problem only occurs with
	dnl  sql/src/server/sql_parser.mx & amdb/src/lang/parser.y, 
	dnl  we use ICC_BISON_CFLAGS 
	dnl  to disable the respective warning as locally as possible
	dnl  (see also sql/src/server/Makefile.ag & amdb/src/lang/Makefile.ag).
	case "`bison -V | head -n1`" in
	*2.0*)
		ICC_BISON_CFLAGS="$ICC_BISON_CFLAGS -wd592"
		dnl  # 592: variable "." is used before its value is set
	esac
	
	dnl  Some versions of flex & bison seem to generate code that icc does not like;
	dnl  we use ICC_BISON_CFLAGS to disable the respective warning as
	dnl  locally as possible via "-wd177"
	dnl  (#177: label "." was declared but never referenced)
	dnl  (see also pathfinder/modules/pftijah/Makefile.ag).
	ICC_BISON_CFLAGS="$ICC_BISON_CFLAGS -wd177"
	NO_INLINE_CFLAGS="-fno-inline -fno-inline-functions"
	;;
-pgcc*-linux*)
	dnl  Portland Group (PGI) (pgcc/pgCC on Linux)
	dnl  required for "scale" in module "decimal"
	CFLAGS="$CFLAGS -Msignextend"
	CC="$CC -fPIC"
	;;
-*-irix*)
	dnl  MIPS compiler on IRIX64
	dnl  treat warnings as errors
	X_CFLAGS="$X_CFLAGS -w2"
	;;
esac
fi
AC_SUBST(CFLAGS)
AC_SUBST(X_CFLAGS)
AC_SUBST(NO_X_CFLAGS)

dnl find out, whether the C compiler is C99 compliant
AC_MSG_CHECKING([if your compiler is C99 compliant])
have_c99=no

dnl  We need more features than the C89 standard offers, but not all
dnl  (if any at all) C/C++ compilers implements the complete C99
dnl  standard.  Moreover, there seems to be no standard for the
dnl  defines that enable the features beyond C89 in the various
dnl  platforms.  Here's what we found working so far...

case "$GCC-$CC-$host_os" in
yes-*-*)
	dnl  GNU (gcc/g++)
	case "$gcc_ver-$host_os" in
	*-cygwin*|*-mingw*)
		dnl  MonetDB/src/testing/Mtimeout.c fails to compile with
		dnl  "--std=c99" as the compiler then refuses to recognize
		dnl  the "sa_handler" member of the "sigaction" struct,
		dnl  which is defined in an unnamed union in
		dnl  /usr/include/cygwin/signal.h ...
		CFLAGS="$CFLAGS -std=gnu99"
		;;
	4.2.*-*)
		dnl gcc 4.2 has a warning on inline functions in C99 mode being
		dnl made for real in gcc 4.3.  We disable the warning and we
		dnl want to get away for a little while with GNU89 inlining
		dnl semantics, until gcc 4.3 is within reach to get real ISO C99
		dnl I think
		CFLAGS="$CFLAGS -std=c99 -fgnu89-inline"
		;;
	*-freebsd*|*-irix*|*-darwin*|*-solaris*|[[34]].*-*)
		CFLAGS="$CFLAGS -std=c99"
		;;
	esac
	;;
-icc*-linux*|-ecc*-linux*)
      	case "$host-$icc_ver" in
        *-*-*-10.*)   	CFLAGS="$CFLAGS -std=c99"	;;
      	*-*-*-*)    	CFLAGS="$CFLAGS -c99" 		;;
      	esac   
	;;
-pgcc*-linux*)
	CFLAGS="$CFLAGS -c9x"
	;;
esac

AC_TRY_COMPILE([], [
#if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901
return 0;
#else
#error "NOT C99 compliant"
/* With some compilers, "#error" only triggers a warning; hence: */
!Error "NOT C99 compliant"
#endif
], 
[AC_DEFINE([HAVE_C99], 1, [Is your compiler C99 compliant?])
have_c99=yes
AC_MSG_RESULT(yes)],
AC_MSG_RESULT(no))


dnl some dirty hacks
dnl we use LEXLIB=-ll because this is usually correctly installed 
dnl and -lfl usually only in the 32bit version
THREAD_SAVE_FLAGS="\$(thread_safe_flag_spec) -D_REENTRANT"
# only needed in monet
MEL_LIBS=""
NO_OPTIMIZE_FILES=""
case "$host_os" in
solaris*)
    case "$GCC" in
      yes) ;;
      *) 
	MEL_LIBS="-z muldefs"
        THREAD_SAVE_FLAGS="$THREAD_SAVE_FLAGS -mt"
        ;;
    esac
    LEXLIB=-ll
    ;;
irix*)
    LEXLIB=-ll
    ;;
aix*)
    THREAD_SAVE_FLAGS="$THREAD_SAVE_FLAGS -D_THREAD_SAFE"
    case "$GCC" in
      yes)
        THREAD_SAVE_FLAGS="$THREAD_SAVE_FLAGS -mthreads"
        dnl  With "-On" (n>0), compilation of monet_multiplex.mx fails on sara's solo with
        dnl  "Assembler: /tmp/cc8qluZf.s: line 33198: Displacement must be divisible by 4.".
        dnl  Likewise, the MIL parser does not work correctly, unless compile monet_parse.yy.c
        dnl  without optimization (i.e., with "$(CFLAGS_NO_OPT)").
        dnl  Hence:
        NO_OPTIMIZE_FILES="monet_multiplex.mx monet_parse.yy.mx"
        ;;
      *)
        THREAD_SAVE_FLAGS="$THREAD_SAVE_FLAGS -qthreaded"
        MEL_LIBS="-qstaticinline"
        ;;
    esac
    ;;
esac
AC_SUBST(MEL_LIBS)
AC_SUBST(thread_safe_flag_spec)
AC_SUBST(THREAD_SAVE_FLAGS)
AC_SUBST(NO_OPTIMIZE_FILES)

AC_ARG_WITH(ant,
	AC_HELP_STRING([--with-ant=FILE], [ant is installed as FILE]),
	ANT="$withval",
	ANT=ant)
case "$ANT" in
yes|auto)
  ANT=ant;;
esac
case "$ANT" in
no) ;;
/*) AC_MSG_CHECKING(whether $ANT exists and is executable)
    if test -x "$ANT"; then
      AC_MSG_RESULT(yes)
    else
      AC_MSG_RESULT(no)
      ANT=no
    fi;;
*)  AC_PATH_PROG(ANT,$ANT,no,$PATH);;
esac
AC_SUBST(ANT)
AM_CONDITIONAL(HAVE_ANT, test x"$ANT" != xno)

JAVA_VERSION=""
JAVA="java"
JAVAC="javac"
JAR="jar"
JAVADOC="javadoc"
AC_ARG_WITH(java,
	AC_HELP_STRING([--with-java=DIR],
		[java, javac, jar and javadoc are installed in DIR/bin]),
	have_java="$withval",
	have_java=auto)
JPATH=$PATH
case $have_java in
yes|no|auto)
	;;
*)
	JPATH="$withval/bin:$JPATH"
	;;
esac
if test "x$have_java" != xno; then
  AC_PATH_PROG(JAVA,java,,$JPATH)
  if test "x$JAVA" != "x"; then
    AC_MSG_CHECKING([for Java >= 1.4, but < 1.6])
    JAVA_VERSION=[`"$JAVA" -version 2>&1 | grep '[0-9]\.[0-9]' | head -n1 | sed -e 's|^[^0-9]*||' -e 's|[^0-9]*$||'`]
    have_java_1_4=no
    if test MONETDB_VERSION_TO_NUMBER(echo $JAVA_VERSION) -ge MONETDB_VERSION_TO_NUMBER(echo "1.4"); then
      if test MONETDB_VERSION_TO_NUMBER(echo $JAVA_VERSION) -lt MONETDB_VERSION_TO_NUMBER(echo "1.6"); then
        have_java_1_4=yes
      fi
    fi
    AC_MSG_RESULT($have_java_1_4 -> $JAVA_VERSION found)
  fi

  AC_PATH_PROG(JAVAC,javac,,$JPATH)
  AC_PATH_PROG(JAR,jar,,$JPATH)
  AC_PATH_PROG(JAVADOC,javadoc,,$JPATH)
  if test x$have_java_1_4 != xyes; then
     if test "x$have_java" = xyes; then
	AC_MSG_ERROR([Java version too old (1.4 required) or too new (1.6 an higher not yet supported)])
     fi
     have_java=no
  elif test "x$JAVAC" = "x"; then
     if test "x$have_java" = xyes; then
	AC_MSG_ERROR([No javac found])
     fi
     have_java=no
  elif test "x$JAR" = "x"; then
     if test "x$have_java" = xyes; then
	AC_MSG_ERROR([No jar found])
     fi
     have_java=no
  else
     have_java=yes
  fi

  if test "x$have_java" != xyes; then
    JAVA_VERSION=""
    JAVA=""
    JAVAC=""
    JAR=""
    JAVADOC=""
    CLASSPATH=""
  fi
  if test x"$ANT" = xno; then
    have_java="no"
  fi
fi
AC_SUBST(JAVAVERS)
AC_SUBST(JAVA)
AC_SUBST(JAVAC)
AC_SUBST(JAR)
AC_SUBST(JAVADOC)
AC_SUBST(CLASSPATH)
AM_CONDITIONAL(HAVE_JAVA,test x$have_java != xno)

]) dnl AC_DEFUN AM_MONETDB_COMPILER

AC_DEFUN([AM_MONETDB_TOOLS],[

dnl AM_PROG_LIBTOOL has loads of required macros, when those are not satisfied within
dnl this macro block the requirement is pushed to the next level, e.g. configure.ag
dnl this can lead to unwanted orders of checks and thus to wrong settings, e.g.
dnl - the compilers are set for 64 bit, but the linker for 32 bit;
dnl - --enable-shared and --disabled-static are ignored as AC_LIBTOOL_SETUP is
dnl   called earlier then AC_DISABLE_STATIC and AC_ENABLE_SHARED
dnl To prevent this we take over some of these required macros and call them explicitly.

AC_PROG_INSTALL()
AC_PROG_LD()
AC_DISABLE_STATIC()
AC_ENABLE_SHARED()

AC_LIBTOOL_DLOPEN
AC_LIBTOOL_WIN32_DLL
AC_LIBTOOL_SETUP()
AC_PROG_LIBTOOL()
AM_PROG_LIBTOOL()

# Checks for header files.
AC_HEADER_STDC
AC_HEADER_TIME
AC_HEADER_DIRENT
AC_CHECK_HEADERS([alloca.h getopt.h netdb.h sys/types.h])

AC_SYS_LARGEFILE()

# Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_TYPE_SIZE_T
AC_TYPE_SIGNAL()
AC_CHECK_TYPES([ptrdiff_t, ssize_t],,,[#include <stddef.h>
#include <sys/types.h>])
AC_CHECK_TYPES([__int64, long long])
case $host_os in
*mingw*)
	AC_DEFINE([LLFMT],["%I64d"],[Format to print 64 bit signed integers.])
	AC_DEFINE([ULLFMT],["%I64u"],[Format to print 64 bit unsigned integers.])
	;;
*)
	AC_DEFINE([LLFMT],["%lld"],[Format to print 64 bit signed integers.])
	AC_DEFINE([ULLFMT],["%llu"],[Format to print 64 bit unsigned integers.])
	;;
esac
AC_CHECK_SIZEOF(char)
AC_CHECK_SIZEOF(short)
AC_CHECK_SIZEOF(int)
AC_CHECK_SIZEOF(long)
AC_CHECK_SIZEOF(void *)
AC_CHECK_SIZEOF(size_t)
AC_CHECK_SIZEOF(ssize_t,,[#include <stddef.h>
#include <sys/types.h>])
AC_CHECK_SIZEOF(ptrdiff_t,,[#include <stddef.h>
#include <sys/types.h>])
AC_CHECK_SIZEOF(long long)
AC_CHECK_SIZEOF(__int64)

# Checks for library functions.
AC_CHECK_FUNCS([ftruncate gettimeofday opendir])

dnl AC_PROG_CC_STDC()
if test -f "$srcdir"/vertoo.data; then
AM_PROG_LEX()
AC_PROG_YACC()
else
LEX=''
YACC=''
fi
AC_PROG_LN_S()
AC_CHECK_PROG(RM,rm,rm -f)
AC_CHECK_PROG(MV,mv,mv -f)
AC_CHECK_PROG(LOCKFILE,lockfile,lockfile -r 2,echo)
AC_PATH_PROG(BASH,bash, /usr/bin/bash, $PATH)
AC_CHECK_PROGS(RPMBUILD,rpmbuild rpm)

SOPREF=lib
case "$host_os" in
mac*)
	dnl Mac OS 9 stuff
	DIRSEP=':'
	QDIRSEP=':'
	AC_ERROR([mac not supported])
	;;
*mingw*)
	DIRSEP='\'
	QDIRSEP='\\'
	PATHSEP=';'
	SOEXT='-0.dll'
	AC_DEFINE([HAVE_GLOBALMEMORYSTATUS], 1, [Define to 1 if you have the `GlobalMemoryStatus' function.])
	;;
*cygwin*)
	DIRSEP='/'
	QDIRSEP='/'
	PATHSEP=':'
	SOEXT='-0.dll'
	SOPREF=cyg
	;;
*darwin*)
	DIRSEP='/'
	QDIRSEP='/'
	PATHSEP=':'
	SOEXT='.dylib'
	;;
*)
	DIRSEP='/'
	QDIRSEP='/'
	PATHSEP=':'
	SOEXT='.so'
	;;
esac
AC_SUBST(DIRSEP)
AC_SUBST(QDIRSEP)
AC_SUBST(PATHSEP)
AC_SUBST(SOEXT)
AC_DEFINE_UNQUOTED([DIR_SEP], '$QDIRSEP', [Directory separator])
AC_DEFINE_UNQUOTED([DIR_SEP_STR], "$QDIRSEP", [Directory separator])
AC_DEFINE_UNQUOTED([PATH_SEP], '$PATHSEP', [Path separator])
AC_DEFINE_UNQUOTED([PATH_SEP_STR], "$PATHSEP", [Path separator])
AC_DEFINE_UNQUOTED([SO_PREFIX], "$SOPREF", [Shared Object prefix])
AC_DEFINE_UNQUOTED([SO_EXT], "$SOEXT", [Shared Object extension])

AC_C_CONST()
AC_C_INLINE()

dnl Pathfinder's and MEL's lexer code do not work properly with flex 2.5.31;
dnl they work fine with both flex 2.5.4 and 2.5.33.
dnl To avoid any problems, we refuse to work with flex 2.5.31 "everywhre",
dnl not only with Pathfider & MEL.

if test "x$LEX" != "x"; then    dnl flex found on the system?

AC_MSG_CHECKING([for flex version])
flex_ver="`$LEX -V | head -n1`"
AC_MSG_RESULT($flex_ver)

case "$flex_ver" in
*2.5.31*)
  AC_MSG_ERROR([MonetDB's lexer code does not work properly with flex 2.5.31;
               please install/use flex 2.5.4 or flex 2.5.33 instead.])
esac

fi   dnl flex found on the system?

if test -f "$srcdir"/vertoo.data; then
        AC_ARG_WITH(swig,
                AC_HELP_STRING([--with-swig=FILE], [swig is installed as FILE]),
                SWIG="$withval",
                SWIG=swig)
        case "$SWIG" in
        yes|auto)
          SWIG=swig;;
        esac
        case "$SWIG" in
        no) ;;
        /*) AC_MSG_CHECKING(whether $SWIG exists and is executable)
            if test -x "$SWIG"; then
              AC_MSG_RESULT(yes)
            else
              AC_MSG_RESULT(no)
              SWIG=no
            fi;;
        *)  AC_PATH_PROG(SWIG,$SWIG,no,$PATH);;
        esac
        if test "x$SWIG" != xno; then
          # we want the right version...
          req_swig_ver="1.3.20"
          AC_MSG_CHECKING(whether $SWIG is >= $req_swig_ver)
          swig_ver="`"$SWIG" -version 2>&1 | grep Version | sed -e 's|^[[^0-9]]*||' -e 's|[[^0-9]]*$||'`"
          if test MONETDB_VERSION_TO_NUMBER(echo $swig_ver) -ge MONETDB_VERSION_TO_NUMBER(echo $req_swig_ver); then
              AC_MSG_RESULT(yes: $swig_ver)
          else
              AC_MSG_RESULT(no: $swig_ver)
              SWIG=no
          fi
        fi
        if test "x$SWIG" != xno; then
          # ...and it must support -outdir
          AC_MSG_CHECKING(whether $SWIG supports "-outdir")
          case `$SWIG -help 2>&1` in
          *-outdir*) 
              AC_MSG_RESULT(yes);;
          *)  AC_MSG_RESULT(no)
              SWIG=no;;
          esac
        fi
        AC_SUBST(SWIG)
        AM_CONDITIONAL(HAVE_SWIG, test x"$SWIG" != xno)
else
        AM_CONDITIONAL(HAVE_SWIG, false)
fi

have_python=auto
PYTHON=python
PYTHON_INCS=
PYTHON_LIBS=
PYTHON_VERSION=
AC_ARG_WITH(python,
	AC_HELP_STRING([--with-python=FILE], [python is installed as FILE]),
	have_python="$withval")
case "$have_python" in
yes|no|auto)
	;;
*)
	PYTHON="$have_python"
	have_python=yes
	;;
esac
if test "x$have_python" != xno; then
	if test $cross_compiling != xyes; then
		AC_PATH_PROG(PYTHON,$PYTHON,no,$PATH)
		if test "x$PYTHON" = xno; then
			if test "x$have_python" != xauto; then
				AC_MSG_ERROR([No Python executable found])
			fi
			have_python=no
		fi
	fi
fi
if test "x$have_python" != xno; then
	have_python_incdir=auto
	AC_ARG_WITH(python-incdir,
		AC_HELP_STRING([--with-python-incdir=DIR],
			[Python include directory]),
		have_python_incdir="$withval")
	case "$have_python_incdir" in
	yes|auto)
		if test $cross_compiling = xyes; then
			AC_MSG_ERROR([Must specify --with-python-incdir --with-python-libdir --with-python-library when cross compiling])
		fi
		PYTHON_INCS=`"$PYTHON" -c 'from distutils.sysconfig import get_python_inc; print get_python_inc()' 2>/dev/null`
		;;
	no)	;;
	*)	PYTHON_INCS="$have_python_incdir"
		have_python_incdir=yes
		;;
	esac
	if test "x$have_python_incdir" != no -a ! -f "$PYTHON_INCS/Python.h"; then
		if test "x$have_python_incdir" = yes; then
			AC_MSG_ERROR([No Python.h found, is Python installed properly?])
		fi
		have_python_incdir=no
	fi
	if test "x$have_python_incdir" != no; then
		PYTHON_INCS="-I$PYTHON_INCS"
	fi

	have_python_library=auto
	AC_ARG_WITH(python-library,
		AC_HELP_STRING([--with-python-library=DIR],
			[Python library directory (where -lpython can be found)]),
		have_python_library="$withval")
	case "$have_python_library" in
	yes|auto)
		if test $cross_compiling = xyes; then
			AC_MSG_ERROR([Must specify --with-python-incdir --with-python-libdir --with-python-library when cross compiling])
		fi
		PYTHON_LIBS=`"$PYTHON" -c 'import distutils.sysconfig, os, sys; print "-L%s -lpython%s" % (os.path.dirname(distutils.sysconfig.get_makefile_filename()), sys.version[[:3]])' 2>/dev/null`
		;;
	no)	;;
	*)	PYTHON_LIBS="$have_python_library"
		have_python_library=yes
		;;
	esac

	have_python_libdir=auto
	AC_ARG_WITH(python-libdir,
		AC_HELP_STRING([--with-python-libdir=DIR],
			[relative path for Python library directory (where Python modules should be installed)]),
		have_python_libdir="$withval")
	case "$have_python_libdir" in
	yes|auto)
		if test $cross_compiling = xyes; then
			AC_MSG_ERROR([Must specify --with-python-incdir --with-python-libdir --with-python-library when cross compiling])
		fi
		PYTHON_LIBDIR=`"$PYTHON" -c 'import distutils.sysconfig; print distutils.sysconfig.get_python_lib(1,0,"")' 2>/dev/null`
		;;
	no)	;;
	*)	PYTHON_LIBDIR="$have_python_libdir"
		have_python_libdir=yes
		;;
	esac

	if test $cross_compiling = xyes; then
		case "$PYTHON_LIBS" in
		*/python2.[0-9]/*)
			PYTHON_VERSION=`expr "$PYTHON_LIBS" : '.*/python\(2\.[0-9]\)/.*'`
			;;
		*)
			AC_MSG_ERROR([Cannot determine Python version])
			;;
		esac
	else
		PYTHON_VERSION=`"$PYTHON" -c 'import sys; print sys.version[[:3]]'`
	fi
else
	# no Python implies no Python includes or libraries
	have_python_incdir=no
	have_python_libdir=no
fi
if test "x$have_python_incdir" != xno -a "x$have_python_libdir" != xno; then
	save_CPPFLAGS="$CPPFLAGS"
	CPPFLAGS="$CPPFLAGS $PYTHON_INCS"
	AC_TRY_COMPILE([#include <Python.h>], [], [],
		[ if test "x$have_python_incdir" != xauto -o "x$have_python_libdir" != xauto; then AC_MSG_ERROR([Cannot compile with Python]); fi; have_python_incdir=no have_python_libdir=no ])
	CPPFLAGS="$save_CPPFLAGS"
fi
AC_SUBST(PYTHON)
AM_CONDITIONAL(HAVE_PYTHON, test x"$have_python" != xno)
AC_SUBST(PYTHON_INCS)
AC_SUBST(PYTHON_LIBS)
AC_SUBST(PYTHON_LIBDIR)
AC_SUBST(PYTHON_VERSION)
AM_CONDITIONAL(HAVE_PYTHON_DEVEL, test "x$have_python_incdir" != xno -a "x$have_python_libdir" != xno)
if test -f "$srcdir"/vertoo.data; then
	AM_CONDITIONAL(HAVE_PYTHON_SWIG,  test "x$have_python_incdir" != xno -a "x$have_python_libdir" != xno -a x"$SWIG" != xno)
else
	AM_CONDITIONAL(HAVE_PYTHON_SWIG,  test "x$have_python_incdir" != xno -a "x$have_python_libdir" != xno)
fi

have_perl=auto
PERL=perl
PERL_INCS=
PERL_LIBS=
AC_ARG_WITH(perl,
	AC_HELP_STRING([--with-perl=FILE], [perl is installed as FILE]),
	have_perl="$withval")
case "$have_perl" in
yes|no|auto)
	;;
*)
	PERL="$have_perl"
	have_perl=yes
	;;
esac
if test "x$have_perl" != xno; then
	if test $cross_compiling != xyes; then
		AC_PATH_PROG(PERL,$PERL,no,$PATH)
		if test "x$PERL" = xno; then
			if test "x$have_perl" != xauto; then
				AC_MSG_ERROR([No Perl executable found])
			fi
			have_perl=no
		fi
	fi
fi
if test "x$have_perl" != xno; then
	have_perl_incdir=auto
	AC_ARG_WITH(perl-incdir,
		AC_HELP_STRING([--with-perl-incdir=DIR],
			[Perl include directory]),
		have_perl_incdir="$withval")
	case "$have_perl_incdir" in
	yes|auto)
		if test $cross_compiling = xyes; then
			AC_MSG_ERROR([Must specify --with-perl-incdir --with-perl-libdir --with-perl-library when cross compiling])
		fi
		PERL_INCS=`"$PERL" -MConfig -e 'print "$Config{archlib}/CORE"' 2>/dev/null`
		;;
	no)	;;
	*)	PERL_INCS="$have_perl_incdir"
		have_perl_incdir=yes
		;;
	esac
	if test "x$have_perl_incdir" != no -a ! -f "$PERL_INCS/perl.h"; then
		if test "x$have_perl_incdir" = yes; then
			AC_MSG_ERROR([No perl.h found, is Perl installed properly?])
		fi
		have_perl_incdir=no
	fi
	if test "x$have_perl_incdir" != no; then
		PERL_INCS="-I$PERL_INCS"
	fi

	have_perl_library=auto
	AC_ARG_WITH(perl-library,
		AC_HELP_STRING([--with-perl-library=DIR],
			[Perl library directory (where -lperl can be found)]),
		have_perl_library="$withval")
	case "$have_perl_library" in
	yes|auto)
		if test $cross_compiling = xyes; then
			AC_MSG_ERROR([Must specify --with-perl-incdir --with-perl-libdir --with-perl-library when cross compiling])
		fi
		PERL_LIBS=`"$PERL" -MConfig -e 'print "$Config{archlib}/CORE"' 2>/dev/null`
		;;
	no)	;;
	*)	PERL_LIBS="$have_perl_library"
		have_perl_library=yes
		;;
	esac
	if test "x$have_perl_library" != no; then
		PERL_LIBS="-L$PERL_LIBS -lperl"
	fi

	have_perl_libdir=auto
	AC_ARG_WITH(perl-libdir,
		AC_HELP_STRING([--with-perl-libdir=DIR],
			[relative path for Perl library directory (where Perl modules should be installed)]),
		have_perl_libdir="$withval")
	case "$have_perl_libdir" in
	yes|auto)
		if test $cross_compiling = xyes; then
			AC_MSG_ERROR([Must specify --with-perl-incdir --with-perl-libdir --with-perl-library when cross compiling])
		fi
		PERL_LIBDIR=`"$PERL" -MConfig -e '$x=$Config{installvendorarch}; $x =~ s|$Config{vendorprefix}/||; print $x;' 2>/dev/null`
		;;
	no)	;;
	*)	PERL_LIBDIR="$have_perl_libdir"
		have_perl_libdir=yes
		;;
	esac
else
	# no Perl implies no Perl includes or libraries
	have_perl_incdir=no
	have_perl_libdir=no
fi
if test "x$have_perl_incdir" != xno -a "x$have_perl_libdir" != xno; then
	save_CPPFLAGS="$CPPFLAGS"
	save_LIBS="$LIBS"
	CPPFLAGS="$CPPFLAGS $PERL_INCS"
	LIBS="$LIBS $PERL_LIBS"
	AC_TRY_LINK([#include <EXTERN.h>
#include <perl.h>], [], [],
		[ if test "x$have_perl_incdir" != xauto -o "x$have_perl_libdir" != xauto; then AC_MSG_ERROR([Cannot compile with Perl]); fi; have_perl_incdir=no have_perl_libdir=no ])
	CPPFLAGS="$save_CPPFLAGS"
	LIBS="$save_LIBS"
fi
AC_SUBST(PERL)
AM_CONDITIONAL(HAVE_PERL, test x"$have_perl" != xno)
AC_SUBST(PERL_INCS)
AC_SUBST(PERL_LIBS)
AC_SUBST(PERL_LIBDIR)
AM_CONDITIONAL(HAVE_PERL_DEVEL, test "x$have_perl_incdir" != xno -a "x$have_perl_libdir" != xno)
if test -f "$srcdir"/vertoo.data; then
	AM_CONDITIONAL(HAVE_PERL_SWIG,  test "x$have_perl_incdir" != xno -a "x$have_perl_libdir" != xno -a x"$SWIG" != xno)
else
	AM_CONDITIONAL(HAVE_PERL_SWIG,  test "x$have_perl_incdir" != xno -a "x$have_perl_libdir" != xno)
fi

dnl to shut up automake (.m files are used for mel not for objc)
AC_CHECK_TOOL(OBJC,objc)

dnl #AM_DEPENDENCIES(CC)

dnl Checks for header files.
dnl AC_HEADER_STDC()

case "$host_os" in
    cygwin*)
	;;
    *)
	CYGPATH_W=echo
	CYGPATH_WP=echo
	AC_SUBST(CYGPATH_W)
	AC_SUBST(CYGPATH_WP)
	;;
esac

]) dnl AC_DEFUN AM_MONETDB_TOOLS

AC_DEFUN([AM_MONETDB_OPTIONS],
[
dnl --with-translatepath
translatepath=echo
AC_ARG_WITH(translatepath,
	AC_HELP_STRING([--with-translatepath=PROG],
		[program to translate paths from configure-time format to execute-time format.  Take care that this program can be given paths like ${prefix}/etc which should be translated carefully.]),
	translatepath="$withval",
	[if test $cross_compiling = yes; then
		AC_MSG_WARN([Cross compiling, but no --with-translatepath option given])
	fi])
AC_SUBST(translatepath)

dnl --with-anttranslatepath
anttranslatepath="$translatepath"
AC_ARG_WITH(anttranslatepath,
	AC_HELP_STRING([--with-anttranslatepath=PROG],
		[program to translate paths from configure-time format to a format that can be given to the ant program [default: value for --with-translatepath]]),
	anttranslatepath="$withval")
AC_SUBST(anttranslatepath)

dnl --enable-noexpand
AC_ARG_ENABLE(noexpand,
	AC_HELP_STRING([--enable-noexpand],
		[do not expand the comma-separated list of MIL types given as argument, or "all" if no expansion should be done [default=]]),
	enable_noexpand=$enableval,
	enable_noexpand=)
case $enable_noexpand in
bat|bat,*|*,bat|*,bat,*|all)
	AC_DEFINE(NOEXPAND_BAT, 1, [Define if you don't want to expand the bat type]);;
esac
case $enable_noexpand in
bit|bit,*|*,bit|*,bit,*|all)
	AC_DEFINE(NOEXPAND_BIT, 1, [Define if you don't want to expand the bit type]);;
esac
case $enable_noexpand in
bte|bte,*|*,bte|*,bte,*|all)
	AC_DEFINE(NOEXPAND_BTE, 1, [Define if you don't want to expand the bte type]);;
esac
case $enable_noexpand in
chr|chr,*|*,chr|*,chr,*|all)
	AC_DEFINE(NOEXPAND_CHR, 1, [Define if you don't want to expand the chr type]);;
esac
case $enable_noexpand in
dbl|dbl,*|*,dbl|*,dbl,*|all)
	AC_DEFINE(NOEXPAND_DBL, 1, [Define if you don't want to expand the dbl type]);;
esac
case $enable_noexpand in
flt|flt,*|*,flt|*,flt,*|all)
	AC_DEFINE(NOEXPAND_FLT, 1, [Define if you don't want to expand the flt type]);;
esac
case $enable_noexpand in
int|int,*|*,int|*,int,*|all)
	AC_DEFINE(NOEXPAND_INT, 1, [Define if you don't want to expand the int type]);;
esac
case $enable_noexpand in
lng|lng,*|*,lng|*,lng,*|all)
	AC_DEFINE(NOEXPAND_LNG, 1, [Define if you don't want to expand the lng type]);;
esac
case $enable_noexpand in
oid|oid,*|*,oid|*,oid,*|all)
	AC_DEFINE(NOEXPAND_OID, 1, [Define if you don't want to expand the oid type]);;
esac
case $enable_noexpand in
ptr|ptr,*|*,ptr|*,ptr,*|all)
	AC_DEFINE(NOEXPAND_PTR, 1, [Define if you don't want to expand the ptr type]);;
esac
case $enable_noexpand in
sht|sht,*|*,sht|*,sht,*|all)
	AC_DEFINE(NOEXPAND_SHT, 1, [Define if you don't want to expand the sht type]);;
esac
case $enable_noexpand in
str|str,*|*,str|*,str,*|all)
	AC_DEFINE(NOEXPAND_STR, 1, [Define if you don't want to expand the str type]);;
esac
case $enable_noexpand in
wrd|wrd,*|*,wrd|*,wrd,*|all)
	AC_DEFINE(NOEXPAND_WRD, 1, [Define if you don't want to expand the wrd type]);;
esac

dnl --enable-debug
AC_ARG_ENABLE(debug,
	AC_HELP_STRING([--enable-debug],
		[enable full debugging [default=no]]),
	enable_debug=$enableval,
	enable_debug=no)
if test "x$enable_debug" = xyes; then
  if test "x$enable_optim" = xyes; then
    AC_MSG_ERROR([combining --enable-optimize and --enable-debug is not possible.])
  else
    dnl  remove "-Ox" as some compilers don't like "-g -Ox" combinations
    CFLAGS=" $CFLAGS "
    CFLAGS="`echo "$CFLAGS" | sed -e 's| -O[[0-9]] | |g' -e 's| -g | |g' -e 's|^ ||' -e 's| $||'`"
    JAVACFLAGS=" $JAVACFLAGS "
    JAVACFLAGS="`echo "$JAVACFLAGS" | sed -e 's| -O | |g' -e 's| -g | |g' -e 's| -g:[[a-z]]* | |g' -e 's|^ ||' -e 's| $||'`"
    dnl  add "-g"
    CFLAGS="$CFLAGS -g"
    JAVACFLAGS="$JAVACFLAGS -g"
    case "$GCC-$host_os" in
      yes-aix*)
        CFLAGS="$CFLAGS -gxcoff"
        ;;
    esac
  fi
fi

dnl --enable-assert
AC_ARG_ENABLE(assert,
	AC_HELP_STRING([--enable-assert],
		[enable assertions in the code [default=$dft_assert]]),
	enable_assert=$enableval,
	enable_assert=$dft_assert)
if test "x$enable_assert" = xno; then
  AC_DEFINE(NDEBUG, 1, [Define if you do not want assertions])
fi

dnl --enable-optimize
AC_ARG_ENABLE(optimize,
	AC_HELP_STRING([--enable-optimize],
		[enable extra optimization [default=$dft_optimi]]),
	enable_optim=$enableval, enable_optim=$dft_optimi)
if test "x$enable_optim" = xyes; then
  if test "x$enable_debug" = xyes; then
    AC_MSG_ERROR([combining --enable-optimize and --enable-debug is not possible.])
  elif test "x$enable_prof" = xyes; then
    AC_MSG_ERROR([combining --enable-optimize and --enable-profile is not (yet?) possible.])
  elif test "x$enable_instrument" = xyes; then
    AC_MSG_ERROR([combining --enable-optimize and --enable-instrument is not (yet?) possible.])
  else
    dnl  remove "-g" as some compilers don't like "-g -Ox" combinations
    CFLAGS=" $CFLAGS "
    CFLAGS="`echo "$CFLAGS" | sed -e 's| -g | |g' -e 's|^ ||' -e 's| $||'`"
    JAVACFLAGS=" $JAVACFLAGS "
    JAVACFLAGS="`echo "$JAVACFLAGS" | sed -e 's| -g | |g' -e 's| -g:[[a-z]]* | |g' -e 's|^ ||' -e 's| $||'`"
    dnl  Optimization flags
    JAVACFLAGS="$JAVACFLAGS -g:none -O"
    if test "x$GCC" = xyes; then
      dnl -fomit-frame-pointer crashes memprof
      case "$host-$gcc_ver" in
      x86_64-*-*-3.[[2-9]]*|i*86-*-*-3.[[2-9]]*|x86_64-*-*-4.*|i*86-*-*-4.*)
                      CFLAGS="$CFLAGS -O6"
                      case "$host" in
                      i*86-*-cygwin) 
                           dnl  With gcc 3.2, the combination of "-On -fomit-frame-pointer" (n>1)
                           dnl  does not seem to produce stable/correct? binaries under CYGWIN
                           dnl  (Mdiff and Mserver crash with segmentation faults);
                           dnl  hence, we omit -fomit-frame-pointer, here.
                           ;;
                      *)   CFLAGS="$CFLAGS -fomit-frame-pointer";;
                      esac
                      CFLAGS="$CFLAGS                          -finline-functions -falign-loops=4 -falign-jumps=4 -falign-functions=4 -fexpensive-optimizations                     -funroll-loops -frerun-cse-after-loop -frerun-loop-opt"
                      dnl  With gcc 3.2, the combination of "-On -funroll-all-loops" (n>1)
                      dnl  does not seem to produce stable/correct? binaries
                      dnl  (Mserver produces tons of incorrect BATpropcheck warnings);
                      dnl  hence, we omit -funroll-all-loops, here.
                      ;;
      x86_64-*-*|i*86-*-*)
                      CFLAGS="$CFLAGS -O6 -fomit-frame-pointer -finline-functions -malign-loops=4 -malign-jumps=4 -malign-functions=4 -fexpensive-optimizations -funroll-all-loops  -funroll-loops -frerun-cse-after-loop -frerun-loop-opt";;
      ia64-*-*)       CFLAGS="$CFLAGS -O6 -fomit-frame-pointer -finline-functions                                                     -fexpensive-optimizations                                    -frerun-cse-after-loop -frerun-loop-opt"
                      dnl  Obviously, 4-byte alignment doesn't make sense on Linux64; didn't try 8-byte alignment, yet.
                      dnl  Further, when combining either of "-funroll-all-loops" and "-funroll-loops" with "-On" (n>1),
                      dnl  gcc (3.2.1 & 2.96) does not seem to produce stable/correct? binaries under Linux64
                      dnl  (Mserver crashes with segmentation fault);
                      dnl  hence, we omit both "-funroll-all-loops" and "-funroll-loops", here
                      ;;
      *-sun-solaris*) CFLAGS="$CFLAGS -O2 -fomit-frame-pointer -finline-functions"
                      if test "$bits" = "64" ; then
                        NO_INLINE_CFLAGS="$NO_INLINE_CFLAGS -O1"
                      fi
                      ;;
      *irix*)         CFLAGS="$CFLAGS -O6 -fomit-frame-pointer -finline-functions"
                      ;;
      *aix*)          CFLAGS="$CFLAGS -O6 -fomit-frame-pointer -finline-functions"
                      if test "$bits" = "64" ; then
                        NO_INLINE_CFLAGS="$NO_INLINE_CFLAGS -O0"
                      fi
                      ;;
      *)              CFLAGS="$CFLAGS -O6 -fomit-frame-pointer -finline-functions";;
      esac
    else
      case "$host-$icc_ver" in
      dnl Portland Group compiler (pgcc/pgCC) has $icc_ver=""
      *-*-*-)    ;;
      dnl  With icc-8.*, Interprocedural (IP) Optimization does not seem to work with MonetDB:
      dnl  With "-ipo -ipo_obj", pass-through linker options ("-Wl,...") are not handled correctly,
      dnl  and with "-ip -ipo_obj", the resulting Mserver segfaults immediately.
      dnl  Hence, we skip Interprocedural (IP) Optimization with icc-8.*.
      x86_64-*-*-8.*)  CFLAGS="$CFLAGS -mp1 -O3 -restrict -unroll               -tpp7 -axWP   ";;
      x86_64-*-*-9.*)  CFLAGS="$CFLAGS -mp1 -O3 -restrict -unroll               -tpp7 -axWP   ";;
      x86_64-*-*-10.*) CFLAGS="$CFLAGS -mp1 -O0 -restrict -unroll                     -axWPT  ";;
      i*86-*-*-8.*)    CFLAGS="$CFLAGS -mp1 -O3 -restrict -unroll               -tpp6 -axKWNPB";;
      i*86-*-*-9.*)    CFLAGS="$CFLAGS -mp1 -O3 -restrict -unroll               -tpp6 -axKWNPB";;
      i*86-*-*-10.*)   CFLAGS="$CFLAGS -mp1 -O0 -restrict -unroll                     -axWPT  ";;
      ia64-*-*-8.*)    CFLAGS="$CFLAGS -mp1 -O2 -restrict -unroll               -tpp2 -mcpu=itanium2";;
      ia64-*-*-9.*)    CFLAGS="$CFLAGS -mp1 -O2 -restrict -unroll               -tpp2 -mcpu=itanium2";;
      ia64-*-*-10.*)   CFLAGS="$CFLAGS -mp1 -O2 -restrict -unroll                     -mcpu=itanium2";;
      i*86-*-*)        CFLAGS="$CFLAGS -mp1 -O3 -restrict -unroll -ipo -ipo_obj -tpp6 -axiMKW";;
      ia64-*-*)        CFLAGS="$CFLAGS -mp1 -O2 -restrict -unroll -ipo -ipo_obj -tpp2 -mcpu=itanium2"
                       dnl  With "-O3", ecc does not seem to produce stable/correct? binaries under Linux64
                       dnl  (Mserver produces some incorrect BATpropcheck warnings);
                       dnl  hence, we use only "-O2", here.
                       ;;
#      *irix*)         CFLAGS="$CFLAGS -O3 -Ofast=IP27 -OPT:alias=restrict -IPA"
      *irix*)          CFLAGS="$CFLAGS -O3 -OPT:div_split=ON:fast_complex=ON:fast_exp=ON:fast_nint=ON:Olimit=2147483647:roundoff=3 -TARG:processor=r10k -IPA"
                       LDFLAGS="$LDFLAGS -IPA"
                       ;;
      *-sun-solaris*)  CFLAGS="$CFLAGS -xO5"
                       CFLAGS_NO_OPT="-xO0"
                       ;;
      *aix*)           CFLAGS="$CFLAGS -O3"
                       NO_INLINE_CFLAGS="$NO_INLINE_CFLAGS -qnooptimize"
                       ;;
      esac   
    fi
  fi
fi
AC_SUBST(CFLAGS_NO_OPT)
AC_SUBST(NO_INLINE_CFLAGS)
AC_SUBST(GCC_BISON_CFLAGS)
AC_SUBST(ICC_BISON_CFLAGS)

dnl --enable-warning (only gcc & icc/ecc)
AC_ARG_ENABLE(warning,
	AC_HELP_STRING([--enable-warning],
		[enable extended compiler warnings [default=$dft_warning]]),
	enable_warning=$enableval,
	enable_warning=$dft_warning)
if test "x$enable_warning" = xyes; then
  dnl  Basically, we disable/overule X_CFLAGS, i.e., "-Werror" and some "-Wno-*".
  dnl  All warnings should be on by default (see above).
  case $GCC-$host_os in
  yes-*)
	dnl  GNU (gcc/g++)
	X_CFLAGS="-pedantic -Wno-long-long"
	;;
  -linux*)
	dnl  Intel ([ie]cc/[ie]cpc on Linux)
	X_CFLAGS=""
	;;
  esac
fi

dnl --enable-profile
need_profiling=no
AC_ARG_ENABLE(profile,
	AC_HELP_STRING([--enable-profile], [enable profiling [default=no]]),
	enable_prof=$enableval,
	enable_prof=no)
if test "x$enable_prof" = xyes; then
  if test "x$enable_optim" = xyes; then
    AC_MSG_ERROR([combining --enable-optimize and --enable-profile is not (yet?) possible.])
  else
    AC_DEFINE(PROFILE, 1, [Compiler flag])
    need_profiling=yes
    if test "x$GCC" = xyes; then
      CFLAGS="$CFLAGS -pg"
    fi
  fi
fi
AM_CONDITIONAL(PROFILING,test "x$need_profiling" = xyes)

dnl --enable-instrument
need_instrument=no
AC_ARG_ENABLE(instrument,
	AC_HELP_STRING([--enable-instrument],
		[enable instrument [default=no]]),
	enable_instrument=$enableval,
	enable_instrument=no)
if test "x$enable_instrument" = xyes; then
  if test "x$enable_optim" = xyes; then
    AC_MSG_ERROR([combining --enable-optimize and --enable-instrument is not (yet?) possible.])
  else
    AC_DEFINE(PROFILE, 1, [Compiler flag])
    need_instrument=yes
    if test "x$GCC" = xyes; then
      CFLAGS="$CFLAGS -finstrument-functions -g"
    fi
  fi
fi

dnl static or shared linking
SHARED_LIBS=''
[
if [ "$enable_static" = "yes" ]; then
	CFLAGS="$CFLAGS -DSTATIC"
	SHARED_LIBS='$(STATIC_LIBS) $(smallTOC_SHARED_LIBS) $(largeTOC_SHARED_LIBS)'
	case "$host_os" in
	aix*)	
		if test "x$GCC" = xyes; then
			LDFLAGS="$LDFLAGS -Xlinker"
		fi
		LDFLAGS="$LDFLAGS -bbigtoc"
		;;
	irix*)
		if test "x$GCC" != xyes; then
			SHARED_LIBS="$SHARED_LIBS -lm"
		fi
		;;
	esac
else
	case "$host_os" in
	aix*)	LDFLAGS="$LDFLAGS -Wl,-brtl";;
	esac
fi
]
AC_SUBST(SHARED_LIBS)
AM_CONDITIONAL(LINK_STATIC,test "x$enable_static" = xyes)

]) dnl AC_DEFUN AM_MONETDB_OPTIONS

AC_DEFUN([AM_MONETDB_LIBS],
[
dnl libpthread
have_pthread=auto
PTHREAD_LIBS=""
PTHREAD_INCS=""
AC_ARG_WITH(pthread,
	AC_HELP_STRING([--with-pthread=DIR],
		[pthread library is installed in DIR]), 
	have_pthread="$withval")
case "$have_pthread" in
yes|no|auto)
	;;
*)
	PTHREAD_LIBS="-L$withval/lib"
	PTHREAD_INCS="-I$withval/include"
	;;
esac
case $host_os in
*mingw*)
	PTHREAD_INCS="$PTHREAD_INCS -D_DLL"
	;;
esac
if test "x$have_pthread" != xno; then
	save_CPPFLAGS="$CPPFLAGS"
	CPPFLAGS="$CPPFLAGS $PTHREAD_INCS"
	AC_CHECK_HEADERS(pthread.h semaphore.h sched.h) 
	CPPFLAGS="$save_CPPFLAGS"

	save_LIBS="$LIBS"
	LIBS="$LIBS $PTHREAD_LIBS"
	AC_CHECK_LIB(pthreadGC2, sem_init,
		pthread=pthreadGC2 PTHREAD_LIBS="$PTHREAD_LIBS -lpthreadGC2",
		AC_CHECK_LIB(pthreadGC1, sem_init,
			pthread=pthreadGC1 PTHREAD_LIBS="$PTHREAD_LIBS -lpthreadGC1",
			AC_CHECK_LIB(pthreadGC, sem_init,
				pthread=pthreadGC PTHREAD_LIBS="$PTHREAD_LIBS -lpthreadGC",
				AC_CHECK_LIB(pthread, sem_init, 
					pthread=pthread PTHREAD_LIBS="$PTHREAD_LIBS -lpthread", 
					dnl sun
					AC_CHECK_LIB(pthread, sem_post,
						pthread=pthread PTHREAD_LIBS="$PTHREAD_LIBS -lpthread -lposix4",
						[ if test "x$have_pthread" != xauto; then AC_MSG_ERROR([pthread library not found]); fi; have_pthread=no ],
						"-lposix4")))))
	AC_CHECK_LIB($pthread, pthread_kill,
		AC_DEFINE(HAVE_PTHREAD_KILL, 1,
			[Define if you have the pthread_kill function]))
	AC_CHECK_LIB($pthread, pthread_sigmask,
		AC_DEFINE(HAVE_PTHREAD_SIGMASK, 1,
			[Define if you have the pthread_sigmask function]))
	AC_CHECK_LIB($pthread, pthread_kill_other_threads_np,
		AC_DEFINE(HAVE_PTHREAD_KILL_OTHER_THREADS_NP, 1,
			[Define if you have the pthread_kill_other_threads_np function]))
	AC_CHECK_LIB($pthread, pthread_setschedprio,
		AC_DEFINE(HAVE_PTHREAD_SETSCHEDPRIO, 1,
			[Define if you have the pthread_setschedprio function]))
	LIBS="$save_LIBS"

fi
if test "x$have_pthread" != xno; then
	AC_DEFINE(HAVE_LIBPTHREAD, 1, [Define if you have the pthread library])
	CPPFLAGS="$CPPFLAGS $PTHREAD_INCS"
else
	PTHREAD_LIBS=""
fi
AC_SUBST(PTHREAD_LIBS)

dnl libreadline
have_readline=auto
READLINE_LIBS=""
READLINE_INCS=""
AC_ARG_WITH(readline,
	AC_HELP_STRING([--with-readline=DIR],
		[readline library is installed in DIR]), 
	have_readline="$withval")
case "$have_readline" in
yes|no|auto)
	;;
*)
	READLINE_LIBS="-L$have_readline/lib"
	READLINE_INCS="-I$have_readline/include"
	;;
esac
save_LIBS="$LIBS"
LIBS="$LIBS $READLINE_LIBS"
if test "x$have_readline" != xno; then
	dnl use different functions in the cascade of AC_CHECK_LIB
	dnl calls since configure may cache the results
	AC_CHECK_HEADER(readline/readline.h,
		AC_CHECK_LIB(readline, readline,
			READLINE_LIBS="$READLINE_LIBS -lreadline",
			[ AC_CHECK_LIB(readline, rl_history_search_forward,
				READLINE_LIBS="$READLINE_LIBS -lreadline -ltermcap",
				[ AC_CHECK_LIB(readline, rl_reverse_search_history,
					READLINE_LIBS="$READLINE_LIBS -lreadline -lncurses",
					[ if test "x$have_readline" = xyes; then
						AC_MSG_ERROR([readline library not found])
					  fi; have_readline=no ],
					-lncurses)],
				-ltermcap)],
			),
		[ if test "x$have_readline" = xyes; then
			AC_MSG_ERROR([readline header file not found])
		  fi; have_readline=no ])
fi
if test "x$have_readline" != xno; then
	dnl provide an ACTION-IF-FOUND, or else all subsequent checks
	dnl that involve linking will fail!
	AC_CHECK_LIB(readline, rl_completion_matches,
		:,
		[ if test "x$have_readline" != xauto; then AC_MSG_ERROR([readline library does not contain rl_completion_matches]); fi; have_readline=no ],
	      $READLINE_LIBS)
fi
LIBS="$save_LIBS"
if test "x$have_readline" != xno; then
	AC_DEFINE(HAVE_LIBREADLINE, 1,
		[Define if you have the readline library])
else
	READLINE_LIBS=""
	READLINE_INCS=""
fi
AC_SUBST(READLINE_LIBS)
AC_SUBST(READLINE_INCS)

dnl OpenSSL
dnl change "auto" in the next line to "no" to disable OpenSSL by default
have_openssl=auto
OPENSSL_LIBS=""
OPENSSL_INCS=""
AC_ARG_WITH(openssl,
	AC_HELP_STRING([--with-openssl=DIR],
		[OpenSSL library is installed in DIR]), 
	have_openssl="$withval")
case "$have_openssl" in
yes|no|auto)
	;;
*)
	OPENSSL_LIBS="-L$withval/lib"
	OPENSSL_INCS="-I$withval/include"
	;;
esac
if test "x$have_openssl" != xno; then
	save_LIBS="$LIBS"
	LIBS="$LIBS $OPENSSL_LIBS"
	AC_CHECK_LIB(ssl, SSL_read,
		OPENSSL_LIBS="$OPENSSL_LIBS -lssl",
		[ if test "x$have_openssl" != xauto; then AC_MSG_ERROR([OpenSSL library not found]); fi; have_openssl=no ])
	dnl on some systems, -lcrypto needs to be passed as well
	AC_CHECK_LIB(crypto, ERR_get_error, OPENSSL_LIBS="$OPENSSL_LIBS -lcrypto")
	LIBS="$save_LIBS"
fi
if test "x$have_openssl" != xno; then
	AC_COMPILE_IFELSE(AC_LANG_PROGRAM([#include <openssl/ssl.h>],[]), , [
		save_CPPFLAGS="$CPPFLAGS"
		CPPFLAGS="$CPPFLAGS -DOPENSSL_NO_KRB5"
		AC_COMPILE_IFELSE(AC_LANG_PROGRAM([#include <openssl/ssl.h>],[]),
			AC_DEFINE(OPENSSL_NO_KRB5, 1, [Define if OpenSSL should not use Kerberos 5]),
			[ if test "x$have_openssl" != xauto; then AC_MSG_ERROR([OpenSSL library not usable]); fi; have_openssl=no ])
		CPPFLAGS="$save_CPPFLAGS"])
fi
if test "x$have_openssl" != xno; then
	AC_DEFINE(HAVE_OPENSSL, 1, [Define if you have the OpenSSL library])
else
	OPENSSL_LIBS=""
	OPENSSL_INCS=""
fi
AC_SUBST(OPENSSL_LIBS)
AC_SUBST(OPENSSL_INCS)

dnl cURL
have_curl=no
CURL_PATH="$PATH"
CURL_CONFIG=''
CURL_CFLAGS=''
CURL_LIBS=''
AC_ARG_WITH(curl,
	AC_HELP_STRING([--with-curl=DIR],
		[cURL library is installed in DIR]),
	have_curl="$withval")
case "$have_curl" in
yes|no|auto)
	;;
*)
	CURL_PATH="$withval/bin:$PATH"
	;;
esac
if test "x$have_curl" != xno; then
	AC_PATH_PROG(CURL_CONFIG,curl-config,,$CURL_PATH)
	if test "x$CURL_CONFIG" = x; then
		if test "x$have_curl" = xyes; then
			AC_MSG_ERROR([curl-config not found; use --with-curl=<path>])
		fi
		have_curl=no
	fi
fi
if test "x$have_curl" != xno; then
	CURL_CFLAGS="`$CURL_CONFIG --cflags`"
	CURL_LIBS="`$CURL_CONFIG --libs`"
	save_CPPFLAGS="$CPPFLAGS"
	CPPFLAGS="$CPPFLAGS $CURL_CFLAGS"
	AC_CHECK_HEADER(curl/curl.h, :, [if test "x$have_curl" != xauto; then AC_MSG_ERROR([curl/curl.h not found]); fi; have_curl=no])
	CPPFLAGS="$save_CPPFLAGS"
fi
if test "x$have_curl" != xno; then
	save_LIBS="$LIBS"
    	LIBS="$LIBS $CURL_LIBS"
    	AC_CHECK_LIB(curl, curl_easy_init, :, [if test "x$have_curl" != xauto; then AC_MSG_ERROR([-lcurl not found]); fi; have_curl=no])
    	LIBS="$save_LIBS"
fi
if test "x$have_curl" != xno; then
	AC_DEFINE(HAVE_CURL, 1, [Define if you have the cURL library])
fi
AC_SUBST(CURL_CFLAGS)
AC_SUBST(CURL_LIBS)

DL_LIBS=""
AC_CHECK_LIB(dl, dlopen, [ DL_LIBS="-ldl" ] )
AC_SUBST(DL_LIBS)

MALLOC_LIBS=""
AC_CHECK_LIB(malloc, malloc, [ MALLOC_LIBS="-lmalloc" ] )
AC_SUBST(MALLOC_LIBS)

save_LIBS="$LIBS"
LIBS="$LIBS $MALLOC_LIBS"
AC_CHECK_FUNCS(mallopt mallinfo)
LIBS="$save_LIBS"

MATH_LIBS=""
AC_CHECK_LIB(m, sqrt, [ MATH_LIBS="-lm" ] )
AC_SUBST(MATH_LIBS)

SOCKET_LIBS=""
have_setsockopt=no
case "$host_os" in
*mingw*)
	AC_CHECK_HEADERS([winsock2.h],[have_winsock2=yes],[have_winsock2=no])
	save_LIBS="$LIBS"
	LIBS="$LIBS -lws2_32"
	AC_MSG_CHECKING(for setsockopt in winsock2)
	AC_TRY_LINK([#ifdef HAVE_WINSOCK2_H
#include <winsock2.h>
#endif],[setsockopt(0,0,0,NULL,0);],[SOCKET_LIBS="-lws2_32"; have_setsockopt=yes;],[])
	AC_MSG_RESULT($have_setsockopt)
	LIBS="$save_LIBS"
	;;
*)
	AC_CHECK_FUNC(gethostbyname_r, [], [
	  AC_CHECK_LIB(nsl_r, gethostbyname_r, [ SOCKET_LIBS="-lnsl_r" ],
	    AC_CHECK_LIB(nsl, gethostbyname_r, [ SOCKET_LIBS="-lnsl"   ] ))])
	;;
esac


if test "x$have_setsockopt" = xno; then
	AC_CHECK_FUNC(setsockopt, [], 
	  AC_CHECK_LIB(socket, setsockopt, [ SOCKET_LIBS="-lsocket $SOCKET_LIBS"; have_setsockopt=yes; ]))
fi

dnl incase of windows we need to use try_link because windows uses the
dnl pascal style of function calls and naming scheme. Therefore the 
dnl function needs to be compiled with the correct header
AC_CHECK_TYPE(SOCKET, , AC_DEFINE(SOCKET,int,[type used for sockets]))
AC_CHECK_TYPE(socklen_t,
	AC_DEFINE(HAVE_SOCKLEN_T, 1, [Define to 1 if the system has the type `socklen_t'.]),
	AC_DEFINE(socklen_t,int,[type used by connect]),
	[#include <sys/types.h>
#include <sys/socket.h>])

case $host_os in
*mingw*)
	save_LIBS="$LIBS"
	LIBS="$LIBS $SOCKET_LIBS"
	AC_MSG_CHECKING(for closesocket)
	AC_TRY_LINK([#ifdef HAVE_WINSOCK2_H
#include <winsock2.h>
#endif],[closesocket((SOCKET)0);], [AC_MSG_RESULT(yes)], [AC_MSG_RESULT(no);AC_DEFINE(closesocket,close,[function to close a socket])])
	LIBS="$save_LIBS"
	;;
*)
	dnl don't check for closesocket on Cygwin: it'll be found but we don't want to use it
	AC_DEFINE(closesocket,close,[function to close a socket])
	;;
esac

AC_SUBST(SOCKET_LIBS)

dnl check for NetCDF io library (default /usr and /usr/local)
have_netcdf=$dft_netcdf
NETCDF_CFLAGS=""
NETCDF_LIBS=""
AC_ARG_WITH(netcdf,
	AC_HELP_STRING([--with-netcdf=DIR],
		[netcdf library is installed in DIR]),
	have_netcdf="$withval")
case "$have_netcdf" in
yes|no|auto)
	;;
*)
	NETCDF_CFLAGS="-I$withval/include"
	NETCDF_LIBS="-L$withval/lib"
	;;
esac
if test "x$have_netcdf" != xno; then
	save_CPPFLAGS="$CPPFLAGS"
	CPPFLAGS="$CPPFLAGS $NETCDF_CFLAGS"
	save_LIBS="$LIBS"
	LIBS="$LIBS $NETCDF_LIBS -lnetcdf"
	AC_LINK_IFELSE(AC_LANG_PROGRAM([#include <netcdf.h>], [(void) nc_open("",0,(int*)0);]),
		NETCDF_LIBS="$NETCDF_LIBS -lnetcdf",
		[ if test "x$have_netcdf" != xauto; then AC_MSG_ERROR([netcdf library not found]); fi; have_netcdf=no ])
	LIBS="$save_LIBS"
	CPPFLAGS="$save_CPPFLAGS"
fi
if test "x$have_netcdf" != xno; then
	AC_DEFINE(HAVE_LIBNETCDF, 1, [Define if you have the netcdf library])
else
	NETCDF_CFLAGS=""
	NETCDF_LIBS=""
fi
AC_SUBST(NETCDF_CFLAGS)
AC_SUBST(NETCDF_LIBS)
AM_CONDITIONAL(HAVE_NETCDF, test "x$have_netcdf" != xno)
NETCDF=$have_netcdf
AC_SUBST(NETCDF)

dnl check for z (de)compression library (default /usr and /usr/local)
have_z=auto
Z_CFLAGS=""
Z_LIBS=""
AC_ARG_WITH(z,
	AC_HELP_STRING([--with-z=DIR],
		[z library is installed in DIR]),
	have_z="$withval")
AC_MSG_CHECKING(for libz)
case "$have_z" in
yes|no|auto)
	;;
*)
	Z_CFLAGS="-I$withval/include"
	Z_LIBS="-L$withval/lib"
        AC_MSG_CHECKING(in $withval) 
	;;
esac
if test "x$have_z" != xno; then
	save_CPPFLAGS="$CPPFLAGS"
	CPPFLAGS="$CPPFLAGS $Z_CFLAGS"
	save_LIBS="$LIBS"
	LIBS="$LIBS $Z_LIBS -lz"
	AC_LINK_IFELSE(AC_LANG_PROGRAM([#include <zlib.h>], [(void) gzopen("","");]),
		Z_LIBS="$Z_LIBS -lz",
		[ if test "x$have_z" != xauto; then AC_MSG_ERROR([z library not found]); fi; have_z=no ])
	LIBS="$save_LIBS"
	CPPFLAGS="$save_CPPFLAGS"
fi
if test "x$have_z" != xno; then
	AC_DEFINE(HAVE_LIBZ, 1, [Define if you have the z library])
else
	Z_CFLAGS=""
	Z_LIBS=""
fi
AC_MSG_RESULT($have_z)
AC_SUBST(Z_CFLAGS)
AC_SUBST(Z_LIBS)

dnl check for bz2 (de)compression library (default /usr and /usr/local)
have_bz2=auto
BZ_CFLAGS=""
BZ_LIBS=""
AC_ARG_WITH(bz2,
	AC_HELP_STRING([--with-bz2=DIR],
		[bz2 library is installed in DIR]),
	have_bz2="$withval")
AC_MSG_CHECKING(for libbz2) 
case "$have_bz2" in
yes|no|auto)
	;;
*)
	BZ_CFLAGS="-I$withval/include"
	BZ_LIBS="-L$withval/lib"
        AC_MSG_CHECKING(in $withval) 
	;;
esac
if test "x$have_bz2" != xno; then
	save_CPPFLAGS="$CPPFLAGS"
	CPPFLAGS="$CPPFLAGS $BZ_CFLAGS"
	save_LIBS="$LIBS"
	LIBS="$LIBS $BZ_LIBS -lbz2"
	AC_LINK_IFELSE(AC_LANG_PROGRAM([#include <stdio.h>
#include <bzlib.h>], [(void)BZ2_bzopen("","");]),
		BZ_LIBS="$BZ_LIBS -lbz2",
		[ if test "x$have_bz2" != xauto; then AC_MSG_ERROR([bz2 library not found]); fi; have_bz2=no ])
	LIBS="$save_LIBS"
	CPPFLAGS="$save_CPPFLAGS"
fi
if test "x$have_bz2" != xno; then
	AC_DEFINE(HAVE_LIBBZ2, 1, [Define if you have the bz2 library])
else
	BZ_CFLAGS=""
	BZ_LIBS=""
fi
AC_MSG_RESULT($have_bz2)
AC_SUBST(BZ_CFLAGS)
AC_SUBST(BZ_LIBS)

dnl check for getopt in standard library
AC_CHECK_FUNCS(getopt_long , need_getopt=, need_getopt=getopt; need_getopt=getopt1)
if test x$need_getopt = xgetopt; then
  AC_LIBOBJ(getopt)
elif test x$need_getopt = xgetopt1; then
  AC_LIBOBJ(getopt1)
fi

dnl hwcounters
have_hwcounters=auto
HWCOUNTERS_LIBS=""
HWCOUNTERS_INCS=""
AC_ARG_WITH(hwcounters,
	AC_HELP_STRING([--with-hwcounters=DIR],
		[hwcounters library is installed in DIR]), 
	have_hwcounters="$withval")
case "$have_hwcounters" in
yes|no|auto)
	;;
*)
	HWCOUNTERS_LIBS="-L$withval/lib"
	HWCOUNTERS_INCS="-I$withval/include"
	;;
esac
if test "x$have_hwcounters" != xno; then
  case "$host_os-$host" in
    linux*-i?86*) HWCOUNTERS_INCS="$HWCOUNTERS_INCS -I/usr/src/linux-`uname -r | sed 's|smp$||'`/include"
  esac
  save_CPPFLAGS="$CPPFLAGS"
  CPPFLAGS="$CPPFLAGS $HWCOUNTERS_INCS"
  save_LIBS="$LIBS"
  LIBS="$LIBS $HWCOUNTERS_LIBS"
  have_hwcounters=no
  case "$host_os-$host" in
   linux*-i?86*|linux*-x86_64*)
	AC_CHECK_HEADERS( libperfctr.h ,
	 AC_CHECK_LIB( perfctr, vperfctr_open , 
	  [ HWCOUNTERS_LIBS="$HWCOUNTERS_LIBS -lperfctr" 
	    AC_DEFINE(HAVE_LIBPERFCTR, 1, [Define if you have the perfctr library])
	    have_hwcounters=yes
	  ]
         )
	)
	if test "x$have_hwcounters" != xyes; then
        	AC_CHECK_HEADERS( libpperf.h,
	 	 AC_CHECK_LIB( pperf, start_counters, 
	  	  [ HWCOUNTERS_LIBS="$HWCOUNTERS_LIBS -lpperf" 
	    	    AC_DEFINE(HAVE_LIBPPERF, 1, [Define if you have the pperf library])
	    	    have_hwcounters=yes
		  ]
		 )
		)
	fi
	;;
   linux*-ia64*)
	AC_CHECK_HEADERS( perfmon/pfmlib.h ,
	 AC_CHECK_LIB( pfm, pfm_initialize , 
	  [ HWCOUNTERS_LIBS="$HWCOUNTERS_LIBS -lpfm" 
	    AC_DEFINE(HAVE_LIBPFM, 1, [Define if you have the pfm library])
	    have_hwcounters=yes
	  ]
         )
	)
	;;
   solaris*)
	AC_CHECK_HEADERS( libcpc.h ,
	 AC_CHECK_TYPE( cpc_event_t, 
	  AC_CHECK_LIB( cpc, cpc_access , 
	   [ HWCOUNTERS_LIBS="$HWCOUNTERS_LIBS -lcpc" 
	     AC_DEFINE(HAVE_LIBCPC, 1, [Define if you have the cpc library])
	     have_hwcounters=yes
	   ]
	  )
	  , , [#include <libcpc.h>]
	 )
	)
	if test "x$have_hwcounters" != xyes; then
		AC_CHECK_HEADERS( perfmon.h ,
		 AC_CHECK_LIB( perfmon, clr_pic , 
		  [ HWCOUNTERS_LIBS="$HWCOUNTERS_LIBS -lperfmon" 
		    AC_DEFINE(HAVE_LIBPERFMON, 1, [Define if you have the perfmon library])
		    have_hwcounters=yes
		  ]
		 )
  		)
	fi
	;;
   irix*)
	AC_CHECK_LIB( perfex, start_counters , 
	 [ HWCOUNTERS_LIBS="$HWCOUNTERS_LIBS -lperfex" 
	   have_hwcounters=yes
	 ]
	)
 	;;
  esac
  LIBS="$save_LIBS"
  CPPFLAGS="$save_CPPFLAGS"

  if test "x$have_hwcounters" != xyes; then
    HWCOUNTERS_LIBS=""
    HWCOUNTERS_INCS=""
   else
    CFLAGS="$CFLAGS -DHWCOUNTERS -DHW_`uname -s` -DHW_`uname -m`"
  fi
fi
AC_SUBST(HWCOUNTERS_LIBS)
AC_SUBST(HWCOUNTERS_INCS)

dnl check for the performance counters library 
have_pcl=auto
PCL_CFLAGS=""
PCL_LIBS=""
AC_ARG_WITH(pcl,
	AC_HELP_STRING([--with-pcl=DIR],
		[pcl library is installed in DIR]),
	have_pcl="$withval")
if test "x$have_pcl" != xno; then
  if test "x$have_pcl" != xauto; then
    PCL_CFLAGS="-I$withval/include"
    PCL_LIBS="-L$withval/lib"
  fi

  save_CPPFLAGS="$CPPFLAGS"
  CPPFLAGS="$CPPFLAGS $PCL_CFLAGS"
  AC_CHECK_HEADER(pcl.h, have_pcl=yes, have_pcl=no)
  CPPFLAGS="$save_CPPFLAGS"

  if test "x$have_pcl" = xyes; then
  	save_LIBS="$LIBS"
  	LIBS="$LIBS $PCL_LIBS"
  	AC_CHECK_LIB(pcl, PCLinit, PCL_LIBS="$PCL_LIBS -lpcl"
        	AC_DEFINE(HAVE_LIBPCL, 1, [Define if you have the pcl library]) have_pcl=yes, 
 	if test "x$have_pcl" = xyes; then
  		save_LIBS="$LIBS"
  		LIBS="$LIBS $PCL_LIBS"
  		AC_CHECK_LIB(pcl, PCLexit, PCL_LIBS="$PCL_LIBS -lpcl -lperfctr"
        		AC_DEFINE(HAVE_LIBPCL, 1, [Define if you have the pcl library]) have_pcl=yes, have_pcl=no, "-lperfctr")
  		fi
	)
  	LIBS="$save_LIBS"
  fi

  if test "x$have_pcl" != xyes; then
    PCL_CFLAGS=""
    PCL_LIBS=""
  fi
fi
AC_SUBST(PCL_CFLAGS)
AC_SUBST(PCL_LIBS)

dnl check for the Perl-compatible regular expressions library 
have_pcre=auto
PCRE_CFLAGS=""
PCRE_LIBS=""
PCRE_CONFIG=""
PCRETEST=""
AC_ARG_WITH(pcre,
	AC_HELP_STRING([--with-pcre=DIR],
		[pcre library is installed in DIR]),
	have_pcre="$withval")
if test "x$have_pcre" != xno; then

    MPATH="$withval/bin:$PATH"
    AC_PATH_PROG(PCRE_CONFIG,pcre-config,,$MPATH)
    if test "x$PCRE_CONFIG" = x; then
    	AC_MSG_RESULT(pcre-config not found; please use --with-pcre=<path>)
    else
    	PCRE_CFLAGS="`$PCRE_CONFIG --cflags`"
    	PCRE_LIBS="`$PCRE_CONFIG --libs`"
    fi

    req_pcre_ver='4.5'
    AC_MSG_CHECKING(for pcre >= $req_pcre_ver)
    if test "x$PCRE_CONFIG" = x; then
    	have_pcre=no
    	AC_MSG_RESULT($have_pcre (without pcre-config to query the pcre version, we assume it's < $req_pcre_ver))
    else
    	pcre_ver="`$PCRE_CONFIG --version 2>/dev/null`"
    	if test MONETDB_VERSION_TO_NUMBER(echo $pcre_ver) -ge MONETDB_VERSION_TO_NUMBER(echo "$req_pcre_ver"); then
      		have_pcre=yes
      		AC_MSG_RESULT($have_pcre (found $pcre_ver))
    	else
      		have_pcre=no
      		AC_MSG_RESULT($have_pcre (found only $pcre_ver))
    	fi
    fi

    if test "x$have_pcre" = xyes; then
        AC_PATH_PROG(PCRETEST,pcretest,,$MPATH)
        AC_MSG_CHECKING(whether pcre comes with UTF-8 support)
        if test "x$PCRETEST" = x; then
            have_pcre=no
            AC_MSG_RESULT($have_pcre (could not find pcretest to check it))
        else
            pcre_utf8="`$PCRETEST -C 2>/dev/null | grep 'UTF-8 support' | sed -e 's|^ *||' -e 's| *$||'`"
            if test "x$pcre_utf8" != "xUTF-8 support"; then
                have_pcre=no
            fi
            AC_MSG_RESULT($have_pcre (pcretest says "$pcre_utf8"))
        fi
    fi

    if test "x$have_pcre" = xyes; then
    	save_CPPFLAGS="$CPPFLAGS"
    	CPPFLAGS="$CPPFLAGS $PCRE_CFLAGS"
    	AC_CHECK_HEADER(pcre.h, have_pcre=yes, have_pcre=no)
    	CPPFLAGS="$save_CPPFLAGS"
    fi

    if test "x$have_pcre" = xyes; then
    	save_LIBS="$LIBS"
    	LIBS="$LIBS $PCRE_LIBS"
    	AC_CHECK_LIB(pcre, pcre_compile, have_pcre=yes, have_pcre=no)
    	LIBS="$save_LIBS"
    fi

    if test "x$have_pcre" = xyes; then
    	AC_DEFINE(HAVE_LIBPCRE, 1, [Define if you have the pcre library])
    else
    	PCRE_CFLAGS=""
    	PCRE_LIBS=""
    fi
fi
AC_SUBST(PCRE_CFLAGS)
AC_SUBST(PCRE_LIBS)
AM_CONDITIONAL(HAVE_PCRE,test x$have_pcre != xno)

AC_CHECK_HEADERS(regex.h)

AC_CHECK_HEADERS(locale.h langinfo.h)
AC_CHECK_FUNCS(nl_langinfo setlocale)

dnl Check for iconv function: it could be in the -liconv library, and
dnl it could be called libiconv instead of iconv (Cygwin).  We also
dnl need the iconv_t type.
have_iconv=auto
ICONV_CFLAGS=""
ICONV_LIBS=""
AC_ARG_WITH(iconv,
	AC_HELP_STRING([--with-iconv=DIR],
		[iconv library is installed in DIR]),
	have_iconv="$withval")
case "$have_iconv" in
yes|no|auto)
	;;
*)
	ICONV_CFLAGS="-I$withval/include"
	ICONV_LIBS="-L$withval/lib"
	;;
esac
if test "x$have_iconv" != xno; then
	save_CPPFLAGS="$CPPFLAGS"
	CPPFLAGS="$CPPFLAGS $ICONV_CFLAGS"
	AC_CHECK_HEADERS(iconv.h)
	AC_CHECK_TYPE(iconv_t, , [ if test "x$have_iconv" != xauto; then AC_MSG_ERROR([iconv_t type not found]); fi; have_iconv=no ], [#if HAVE_ICONV_H
#include <iconv.h>
#endif])
	CPPFLAGS="$save_CPPFLAGS"
fi
have_libiconv=no
if test "x$have_iconv" != xno; then
	save_LIBS="$LIBS"
	LIBS="$LIBS $ICONV_LIBS"
	AC_CHECK_LIB(iconv, iconv, ICONV_LIBS="$ICONV_LIBS -liconv", [
		AC_CHECK_LIB(iconv, libiconv, have_libiconv=yes ICONV_LIBS="$ICONV_LIBS -liconv", [
			AC_CHECK_FUNC(iconv, , [
				AC_CHECK_FUNC(libiconv, have_libiconv=yes,
					[ if test "x$have_iconv" != xauto; then AC_MSG_ERROR([iconv library not found]); fi; have_iconv=no ])])])])
	LIBS="$save_LIBS"
fi
if test "x$have_iconv" != xno; then
	AC_DEFINE(HAVE_ICONV, 1, [Define if you have the iconv library])
	if test $have_libiconv = yes; then
		AC_DEFINE(iconv, libiconv, [Wrapper])
		AC_DEFINE(iconv_open, libiconv_open, [Wrapper])
		AC_DEFINE(iconv_close, libiconv_close, [Wrapper])
	fi
	AC_TRY_COMPILE([
#include <stdlib.h>
#if HAVE_ICONV_H
#include <iconv.h>
#endif
extern
#ifdef __cplusplus
"C"
#endif
#if defined(__STDC__) || defined(__cplusplus)
size_t iconv (iconv_t cd, char * *inbuf, size_t *inbytesleft, char * *outbuf, size_t *outbytesleft);
#else
size_t iconv();
#endif
], [], iconv_const="", iconv_const="const")
	AC_DEFINE_UNQUOTED(ICONV_CONST, $iconv_const, 
		[Define as const if the declaration of iconv() needs const for 2nd argument.])
else
	ICONV_CFLAGS=""
	ICONV_LIBS=""
fi
AC_SUBST(ICONV_CFLAGS)
AC_SUBST(ICONV_LIBS)

AC_CHECK_PROG(TEXI2HTML,texi2html,texi2html)
AC_CHECK_PROG(LATEX2HTML,latex2html,latex2html)
AC_CHECK_PROG(LATEX,latex,latex)
AC_CHECK_PROG(PDFLATEX,pdflatex,pdflatex)
AC_CHECK_PROG(DVIPS,dvips,dvips)
AC_CHECK_PROG(FIG2DEV,fig2dev,fig2dev)
FIG2DEV_EPS=eps
AC_MSG_CHECKING([$FIG2DEV postscript option])
[ if [ "$FIG2DEV" ]; then
        echo "" > $FIG2DEV -L$FIG2DEV_EPS 2>/dev/null
        if [ $? -ne 0 ]; then
                FIG2DEV_EPS=ps
        fi
fi ]
AC_MSG_RESULT($FIG2DEV_EPS)
AC_SUBST(FIG2DEV_EPS)
AM_CONDITIONAL(DOCTOOLS, test -n "$TEXI2HTML" -a -n "$LATEX2HTML" -a -n "$LATEX" -a -n "$PDFLATEX" -a -n "$FIG2DEV" -a -n "$DVIPS") 

INSTALL_BACKUP=""
AC_MSG_CHECKING([$INSTALL --backup option])
[ if [ "$INSTALL" ]; then
	inst=`echo $INSTALL | sed 's/ .*//'`
	if [ ! "`file $inst | grep 'shell script' 2>/dev/null`" ] ; then
	    echo "" > c 2>/dev/null
            $INSTALL --backup=nil c d 1>/dev/null 2>/dev/null
            if [ $? -eq 0 ]; then
                INSTALL_BACKUP="--backup=nil" 
            fi
            $INSTALL -C --backup=nil c e 1>/dev/null 2>/dev/null
            if [ $? -eq 0 ]; then
                INSTALL_BACKUP="-C --backup=nil" 
       	    fi
	fi 
	rm -f c d e 2>/dev/null
fi ]
AC_MSG_RESULT($INSTALL_BACKUP)
AC_SUBST(INSTALL_BACKUP)


PHP_INCS=""
PHP_EXTENSIONDIR=""
AC_ARG_WITH(php,
	AC_HELP_STRING([--with-php=<value>], [PHP support (yes/no/auto)]),
	have_php="$withval",
	have_php=auto)
AC_ARG_WITH(php-config, AC_HELP_STRING([--with-php-config=FILE], [Path to php-config script]),
	PHP_CONFIG="$withval",
	PHP_CONFIG=php-config)
case "$PHP_CONFIG" in
yes|auto) PHP_CONFIG=php-config;;
esac
if test "x$have_php" != xno; then
	if test "x$PHP_CONFIG" != xno; then
		AC_PATH_PROG(PHP_CONFIG, $PHP_CONFIG, no)
	fi
	if test $PHP_CONFIG = no; then
		if test "x$have_php" != xauto
		then
		    AC_MSG_ERROR([Cannot find php-config. Please use --with-php-config=PATH])
		else
		    AC_MSG_WARN([Cannot find php-config. Please use --with-php-config=PATH])
		fi
		have_php=no
	fi
fi
if test "x$have_php" != xno; then
	AC_MSG_CHECKING([for PHP])
	php_prefix="`$PHP_CONFIG --prefix`"
	if test -z "$php_prefix"; then
		have_php=no
	else
		PHP_INCS=" `$PHP_CONFIG --includes`"

		dnl check for the appropriate php 5 header files
		save_CPPFLAGS="$CPPFLAGS"
		CPPFLAGS="$CPPFLAGS $PHP_INCS"
		AC_CHECK_HEADERS([Zend/zend_exceptions.h], [], [have_php=no;], [
#define _GNU_SOURCE
#include <stdlib.h>
#include <php.h>
]) 
		CPPFLAGS="$save_CPPFLAGS"
	fi
		
	if test "x$have_php" != xno; then
		have_php=yes
		have_php_extensiondir=auto
		AC_ARG_WITH(php-extensiondir,
				AC_HELP_STRING([--with-php-extensiondir=DIR],
					[relative path for php extension directory (where php modules should be installed)]),
				have_php_extensiondir="$withval")
		case "$have_php_extensiondir" in
		yes|auto)
			if test $cross_compiling = xyes; then
				AC_MSG_ERROR([Must specify --with-php-extensiondir when cross compiling])
				have_php=no
			fi
			PHP_EXTENSIONDIR="`$PHP_CONFIG --extension-dir | sed -e s+$php_prefix/++g`";
			;;
		no)	;;
		*)	PHP_EXTENSIONDIR="$have_php_extensiondir";
			;;
		esac
		AC_MSG_RESULT($have_php: PHP_INCS="$PHP_INCS" PHP_EXTENSIONDIR="\$prefix/$PHP_EXTENSIONDIR")
	fi
else	
	AC_MSG_RESULT($have_php)
fi
AC_SUBST(PHP_INCS)
AC_SUBST(PHP_EXTENSIONDIR)
if test "$PHP_EXTENSIONDIR"; then
	XPHP_EXTENSIONDIR="`$translatepath "$PHP_EXTENSIONDIR"`"
else
	XPHP_EXTENSIONDIR=''
fi
AC_SUBST(XPHP_EXTENSIONDIR)
AM_CONDITIONAL(HAVE_PHP, test x"$have_php" != xno)

AC_SUBST(CFLAGS)

have_problem=no
if test "x$have_pthread" = xno; then
	AC_MSG_NOTICE("MonetDB requires libpthread (try --with-pthread)")
	have_problem=yes
fi

if test "x$have_problem" != xno; then
	AC_MSG_ERROR("A required package is missing")
fi

]) dnl AC_DEFUN AM_MONETDB_LIBS

AC_DEFUN([AM_MONETDB_UTILS],[

AC_ARG_WITH(buildtools,
    AC_HELP_STRING([--with-buildtools=DIR],
                   [MonetDB Buildtools are installed in DIR]),
    with_buildtools="$withval",
    with_buildtools="auto")

if test "x$with_buildtools" != xno
then

    if test "x$with_buildtools" = x -o "x$with_buildtools" = xauto
    then
        buildtools_path=$PATH
    else
        buildtools_path="$with_buildtools/bin"
    fi

    AC_PATH_PROG(BUILDTOOLS_CONFIG,buildtools-config,,$buildtools_path)

    if test "x$BUILDTOOLS_CONFIG" = x
    then

        if test "x$with_buildtools" != xauto
        then
            AC_MSG_ERROR([MonetDB Buildtools could not be found,
                          although you requested to use them.])
        else
            AC_MSG_WARN([MonetDB Buildtools could not be found.
                         You won't be able to compile $PACKAGE_NAME
                         from CVS sources.])
        fi

    else

        have_mx=`"$BUILDTOOLS_CONFIG" --bindir`/Mx$EXEEXT
        have_mel=`"$BUILDTOOLS_CONFIG" --bindir`/mel$EXEEXT

        BUILDTOOLS_CONFDIR=`"$BUILDTOOLS_CONFIG" --pkgdatadir`
        AC_SUBST(BUILDTOOLS_CONFDIR)
        rules_mk=$BUILDTOOLS_CONFDIR/rules.mk

        AC_CHECK_FILE($rules_mk,
            [have_buildtools=yes],
            [AC_MSG_WARN([$rules_mk could not be found.
                          You won't be able to compile $PACKAGE_NAME
                          from CVS sources.])])

    fi
fi

AM_CONDITIONAL(HAVE_BUILDTOOLS, test "x$have_buildtools" = xyes)

dnl Add a dummy define for HAVE_EXTRA_MK (that is used in am.py).
dnl It has to be overwritten by any project that uses an extra.mk file.
AM_CONDITIONAL(HAVE_EXTRA_MK, false)

if test -f "$srcdir"/vertoo.data; then
        dnl check for Mx if we find the not distributed vertoo.data 
        dnl having (this) file means we're compiling from CVS
        dnl and not from the distribution tar ball

	dnl check for Monet and some basic utilities
	AC_ARG_WITH(mx,
		AC_HELP_STRING([--with-mx=FILE], [Mx is installed as FILE]),
		have_mx="$withval",
		have_mx=auto)
	if test "x$have_mx" = xauto; then
		AC_PATH_PROGS(MX,[ Mx$EXEEXT Mx ],,$PATH)
		if test "x$MX" = x; then
			AC_ERROR([No Mx$EXEEXT found in PATH=$PATH])
		fi
	elif test "x$have_mx" = xno; then
		AC_MSG_ERROR([Mx is required])
	else
		MX="$withval"
	fi
	AC_SUBST(MX)
	AM_CONDITIONAL(NEED_MX, true)
else
	AM_CONDITIONAL(NEED_MX, false)
fi

case "$host_os" in
*mingw*)
	AM_CONDITIONAL(NOT_WIN32, false)
	AM_CONDITIONAL(NATIVE_WIN32, true)
	AC_DEFINE(NATIVE_WIN32, 1, [Define if you are compiling for Native Windows (MinGW or Visual Studio)])
	;;
*)
	AM_CONDITIONAL(NOT_WIN32, true)
	AM_CONDITIONAL(NATIVE_WIN32, false)
	;;
esac

]) dnl AC_DEFUN AM_MONETDB_UTILS

AC_DEFUN([AM_MONETDB_MEL],[

have_mel=""
if test -f "$srcdir"/vertoo.data; then
        dnl check for mel if we find the not distributed vertoo.data 
        dnl having (this) file means we're compiling from CVS
        dnl and not from the distribution tar ball

	MEL=""
	AC_ARG_WITH(mel,
		AC_HELP_STRING([--with-mel=FILE], [mel is installed as FILE]),
		have_mel="$withval",
		have_mel=auto)
	if test "x$have_mel" = xauto; then
		AC_PATH_PROGS(MEL,[ mel$EXEEXT mel ],,$PATH)
	elif test "x$have_mel" != xno; then
		MEL="$withval"
	fi
	if test x$MEL = x; then
		if [ -z "$1" ]; then 
			AC_MSG_ERROR([mel is required])
		fi
		have_mel=no
	else
		have_mel=yes
	fi
	AC_SUBST(MEL)
else	
	dnl fack have_mel as we don't require it for distribution tar balls
	have_mel=yes
fi

]) dnl AC_DEFUN AM_MONETDB_MEL
