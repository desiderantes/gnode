## Process this file with automake to produce Makefile.in

## Created by Anjuta
NULL =

uidir = $(pkgdatadir)/ui
ui_DATA = gnode.ui \
	gnode.gresource.xml


AM_CPPFLAGS = \
	-DPACKAGE_LOCALE_DIR=\""$(localedir)"\" \
	-DPACKAGE_SRC_DIR=\""$(srcdir)"\" \
	-DPACKAGE_DATA_DIR=\""$(pkgdatadir)"\" \
	$(GNODE_CFLAGS)

AM_CFLAGS =\
	 -Wall\
	 -g

bin_PROGRAMS = gnode

BUILT_SOURCES = gnode-resources.c

VALA_SOURCES = \
	gnode.vala \
	node.vala \
	main.vala \
	link.vala \
	graph.vala\
	auxiliar_graph.vala\
	$(NULL)

gnode_SOURCES = \
	$(VALA_SOURCES)			\
	config.vapi			\
	$(BUILT_SOURCES)		\
	$(NULL)

gnode_VALAFLAGS =  --target-glib=2.38 --gresources gnode.gresource.xml --pkg gdk-pixbuf-2.0 --pkg gdk-3.0 --pkg cairo --pkg gtk+-3.0 --pkg gmodule-2.0 --pkg gee-0.8

gnode-resources.c: gnode.gresource.xml $(shell glib-compile-resources --generate-dependencies --sourcedir=$(srcdir) $(srcdir)/gnode.gresource.xml)
	$(AM_V_GEN) glib-compile-resources --target=$@ --sourcedir=$(srcdir) --generate-source $<

gnode_LDFLAGS = -lm

gnode_LDADD = $(GNODE_LIBS)


if PLATFORM_WIN32
gnode_LDFLAGS += -Wl,--export-all-symbols
else
gnode_LDFLAGS += -Wl,--export-dynamic
endif

if NATIVE_WIN32
gnode_LDFLAGS += -mwindows
endif


EXTRA_DIST = $(ui_DATA)

# Remove ui directory on uninstall
uninstall-local:
	-rm -r $(uidir)
	-rm -r $(pkgdatadir)
