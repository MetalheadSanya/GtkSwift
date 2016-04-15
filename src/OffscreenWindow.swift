//
//  OffscreenWindow.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 13.04.16.
//
//

import CGTK

public class OffscreenWindow: Window {
	internal var n_OffscreenWindow: UnsafeMutablePointer<GtkOffscreenWindow>
	
	internal init(n_OffscreenWindow: UnsafeMutablePointer<GtkOffscreenWindow>) {
		self.n_OffscreenWindow = n_OffscreenWindow
		super.init(n_Window: UnsafeMutablePointer<GtkWindow>(n_OffscreenWindow))
	}
	
	public convenience init() {
		self.init(n_OffscreenWindow: UnsafeMutablePointer<GtkOffscreenWindow>(gtk_offscreen_window_new()))
	}
	
	// TODO: gtk_offscreen_window_get_surface, gtk_offscreen_window_get_pixbuf
}
