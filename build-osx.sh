#!/usr/bin/env bash

swift build -Xlinker -L/usr/local/lib -Xcc -I/usr/local/include/cairo -Xcc -I/usr/local/include/gtk-3.0 -Xcc -I/usr/local/include/glib-2.0/ -Xcc -I/usr/local/include/pango-1.0 -Xcc -I/usr/local/include/gdk-pixbuf-2.0 -Xcc -I/usr/local/include/atk-1.0 -Xcc -I/usr/local/lib/glib-2.0/include