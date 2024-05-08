AC_INIT([libusrp],
	m4_esyscmd([./git-version-gen .tarball-version]),
	[openbsc@lists.osmocom.org])

AM_INIT_AUTOMAKE([foreign subdir-objects silent-rules])
AM_SILENT_RULES([yes])

AC_CONFIG_MACRO_DIRS([m4])

CFLAGS="$CFLAGS -std=gnu11"

dnl include release helper
RELMAKE='-include osmo-release.mk'
AC_SUBST([RELMAKE])

AC_PROG_CXX

LT_INIT([pic-only disable-static])

PKG_CHECK_MODULES([USB], [libusb-1.0])

AX_BOOST_BASE([1.37], [true], [AC_MSG_ERROR([boost is required, bailing out])])

AX_BOOST_THREAD
CXXFLAGS="$CXXFLAGS $BOOST_CXXFLAGS"       dnl often picks up a -pthread or something similar
CFLAGS="$CFLAGS $BOOST_CXXFLAGS"           dnl often picks up a -pthread or something similar

dnl
dnl all the rest of these call AC_SUBST(BOOST_<foo>_LIB) and define HAVE_BOOST_<foo>
dnl
AX_BOOST_DATE_TIME
AX_BOOST_FILESYSTEM
dnl AX_BOOST_IOSTREAMS
AX_BOOST_PROGRAM_OPTIONS
dnl AX_BOOST_REGEX
dnl AX_BOOST_SERIALIZATION
dnl AX_BOOST_SIGNALS
AX_BOOST_SYSTEM
dnl AX_BOOST_TEST_EXEC_MONITOR
dnl AX_BOOST_UNIT_TEST_FRAMEWORK
dnl AX_BOOST_WSERIALIZATION

# Allow user to choose whether to generate SWIG/Python
# Default is enabled
AC_ARG_ENABLE([python],
  [AS_HELP_STRING([--enable-python],
    [generate SWIG/Python components (default is yes)])],
  [case "${enableval}" in
     yes) enable_python=yes ;;
     no) enable_python=no ;;
     *) AC_MSG_ERROR([bad value ${enableval} for --enable-python]) ;;
   esac],
  [enable_python=no]
)

# Allow user to choose whether to generate SWIG/Guile
# Default is disabled
AC_ARG_ENABLE([guile],
  [AS_HELP_STRING([--enable-guile],
    [generate SWIG/Guile components (default is no)])],
  [case "${enableval}" in
     yes) enable_guile=yes ;;
     no) enable_guile=no ;;
     *) AC_MSG_ERROR([bad value ${enableval} for --enable-guile]) ;;
   esac],
  [enable_guile=no]
)

AM_PATH_PYTHON

AM_CONDITIONAL([PYTHON], [test x$enable_python = xyes])
AM_CONDITIONAL([GUILE], [test x$enable_guile = xyes])

AC_ARG_ENABLE(doxygen,
	[AS_HELP_STRING(
		[--disable-doxygen],
		[Disable generation of documentation using doxygen],
	)],
	[doxygen=$enableval], [doxygen="yes"])
AC_PATH_PROG(DOXYGEN,doxygen,false)
AM_CONDITIONAL(HAVE_DOXYGEN, test $DOXYGEN != false && test "x$doxygen" = "xyes")

AC_CHECK_PROG([XMLTO],[xmlto],[yes],[])
AM_CONDITIONAL([HAS_XMLTO], [test x$XMLTO = xyes])

USRP_SDCC([3.2.0],[],[passed=no;AC_MSG_ERROR([Unable to find firmware compiler SDCC 3.x.])])

AC_CONFIG_FILES([
  Makefile
  usrp.pc
  usrp.iss
  doc/Doxyfile
  doc/Makefile
  doc/other/Makefile
  host/Makefile
  host/include/Makefile
  host/include/usrp/Makefile
  host/include/usrp/libusb_types.h
  host/misc/Makefile
  host/lib/Makefile
  host/lib/std_paths.h
  host/swig/Makefile
  host/apps/Makefile
  firmware/Makefile
  firmware/include/Makefile
  firmware/lib/Makefile
  firmware/src/Makefile
  firmware/src/common/Makefile
  firmware/src/usrp2/Makefile
  fpga/Makefile
  fpga/rbf/Makefile
  fpga/rbf/rev2/Makefile
  fpga/rbf/rev4/Makefile
])
AC_OUTPUT
