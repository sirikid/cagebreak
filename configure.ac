AC_INIT([cagebreak], [2.1.3-autotools])

AC_PREREQ([0.24])

AM_INIT_AUTOMAKE([gnu -Wall -Wno-portability])
AM_SILENT_RULES([yes])

AC_PROG_CC

PKG_PROG_PKG_CONFIG
PKG_CHECK_MODULES([cagebreak], [
cairo
fontconfig
libevdev
libinput
libudev
pango
pangocairo
wayland-client
wayland-cursor
wayland-protocols >= 1.4
wayland-server
wlroots >= 0.16.1 wlroots < 0.17.0
xkbcommon
])

AC_ARG_WITH([xwayland], AS_HELP_STRING([--without-xwayland], [Ignore presence of XWayland and disable it]))
AS_IF([test "x$with_xwayland" != "xno"],
  [PKG_CHECK_MODULES([xwayland], [xwayland],
    [AC_DEFINE([CG_HAS_XWAYLAND], [1], [...])],
    [AC_DEFINE([CG_HAS_XWAYLAND], [0], [...])])],
  [AC_DEFINE([CG_HAS_XWAYLAND], [0], [...])])
AM_CONDITIONAL([CG_HAS_XWAYLAND], [test "x$with_xwayland" != "xno"])

PKG_CHECK_VAR([WAYLAND_PROTOCOLS_DIR], [wayland-protocols >= 1.4], [pkgdatadir])
AC_MSG_CHECKING([wayland protocols directory])
AS_IF([test "x$WAYLAND_PROTOCOLS_DIR" = "x"],
  [AC_MSG_FAILURE([Unable to find wayland protocols directory.])],
  [echo "$WAYLAND_PROTOCOLS_DIR"])

AC_CHECK_LIB([m], [round])

AC_DEFINE([CG_HAS_FANALYZE], [0], [TODO: Really check for -fanalyze])
AC_DEFINE([MAX_NESTING_LEVEL], [50], [...])
AC_DEFINE([WLR_USE_UNSTABLE], [1], [...])

AC_CONFIG_HEADER([config.h:config.h.in])
AC_CONFIG_FILES([Makefile])

AC_OUTPUT
