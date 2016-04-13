#!/usr/bin/env bash

sudo ln -sf /usr/include/gtk-3.0/gtk /usr/include/gtk
sudo ln -sf /usr/include/gtk-3.0/gdk /usr/include/gdk

sudo ln -sf /usr/include/glib-2.0/glib /usr/include/glib
sudo ln -sf /usr/include/glib-2.0/gio /usr/include/gio
sudo ln -sf /usr/include/glib-2.0/gobject /usr/include/gobject

sudo ln -sf /usr/include/pango-1.0/pango /usr/include/pango

sudo ln -sf /usr/include/gdk-pixbuf-2.0/gdk-pixbuf /usr/include/gdk-pixbuf

sudo ln -sf /usr/include/atk-1.0/atk /usr/include/atk

sudo ln -f /usr/include/glib-2.0/glib.h /usr/include/glib.h
sudo ln -f /usr/include/glib-2.0/glib-object.h /usr/include/glib-object.h
sudo ln -f /usr/include/glib-2.0/gmodule.h /usr/include/gmodule.h

sudo ln -f /usr/include/cairo/cairo.h /usr/include/cairo.h
sudo ln -f /usr/include/cairo/cairo-version.h /usr/include/cairo-version.h
sudo ln -f /usr/include/cairo/cairo-features.h /usr/include/cairo-features.h
sudo ln -f /usr/include/cairo/cairo-deprecated.h /usr/include/cairo-deprecated.h

sudo ln -f /usr/lib/x86_64-linux-gnu/glib-2.0/include/glibconfig.h /usr/include/glibconfig.h