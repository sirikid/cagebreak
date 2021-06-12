pkgs = cairo fontconfig libdrm pango pangocairo pixman-1 wayland-client
pkgs += wayland-cursor wayland-server wlroots xkbcommon

CFLAGS = -Wundef -Wno-unused-parameter -I. $(shell pkg-config --cflags $(pkgs))
CPPFLAGS = -DWLR_USE_UNSTABLE -DCG_VERSION='"1.7.2"'
CPPFLAGS += -DCG_HAS_XWAYLAND=$(if $(xwayland),1,0)
CPPFLAGS += -DCG_HAS_FANALYZE=$(if $(fanalyze),1,0)
LDFLAGS = $(shell pkg-config --libs-only-L $(pkgs))
LDLIBS = -lm $(shell pkg-config --libs-only-l $(pkgs))

.PHONY: all clean

all: cagebreak

clean:
	$(RM) cagebreak *.o *-protocol.h

cagebreak: cagebreak.o idle_inhibit_v1.o ipc_server.o keybinding.o message.o
cagebreak: output.o pango.o parse.o render.o seat.o server.o util.o view.o
cagebreak: workspace.o xdg_shell.o $(if $(xwayland),xwayland.o,)

cagebreak.o: xdg-shell-protocol.h

wl-proto-dir = $(shell pkg-config --variable=pkgdatadir wayland-protocols)

%-protocol.h: $(wl-proto-dir)/*/*/%.xml
	wayland-scanner server-header $< $@
