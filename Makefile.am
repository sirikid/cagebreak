subdirs = . man

bin_PROGRAMS = cagebreak

cagebreak_SOURCES = cagebreak.c idle_inhibit_v1.c input_manager.c ipc_server.c keybinding.c libinput.c message.c output.c pango.c parse.c seat.c server.c util.c view.c workspace.c xdg_shell.c
cagebreak_CFLAGS += -DWLR_USE_UNSTABLE -Werror=implicit-function-declaration -Wundef -Wno-unused-parameter
cagebreak_LDADD = $(cagebreak_LIBS)

if CG_HAS_XWAYLAND
cagebreak_SOURCES += xwayland.c
cagebreak_CFLAGS += $(xwayland_CFLAGS)
cagebreak_LDADD += $(xwayland_LIBS)
endif

%-protocol.h: $(WAYLAND_PROTOCOLS_DIR)/*/*/%.xml
	wayland-scanner server-header $< $@
