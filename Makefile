option = $(if $(or $(findstring 1,$(1)),$(findstring yes,$(1)),$(findstring true,$(1))),$(2),$(3))

pkgs = cairo fontconfig libdrm pango pangocairo pixman-1 wayland-client wayland-cursor wayland-server wlroots xkbcommon

CFLAGS = -Wundef -Wno-unused-parameter -I. $(shell pkg-config --cflags $(pkgs))
CPPFLAGS = -DWLR_USE_UNSTABLE -DCG_VERSION='"1.7.2"' -DCG_HAS_XWAYLAND=$(call option,$(xwayland),1,0) -DCG_HAS_FANALYZE=$(call option,$(fanalyze),1,0)
LDFLAGS = $(shell pkg-config --libs-only-L $(pkgs))
LDLIBS = -lm $(shell pkg-config --libs-only-l $(pkgs))

.PHONY: all clean

all: cagebreak

clean:
	$(RM) cagebreak *.o *-protocol.h

cagebreak: cagebreak.o idle_inhibit_v1.o ipc_server.o keybinding.o message.o output.o pango.o parse.o render.o seat.o server.o util.o view.o workspace.o xdg_shell.o $(call option,$(xwayland),xwayland.o)

cagebreak.o: xdg-shell-protocol.h

wl-proto-dir = $(shell pkg-config --variable=pkgdatadir wayland-protocols)

%-protocol.h: $(wl-proto-dir)/*/*/%.xml
	wayland-scanner server-header $< $@
