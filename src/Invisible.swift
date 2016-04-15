//
//  Invisible.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 13.04.16.
//
//

import CGTK

public class Invisible: Widget {
	internal var n_Invisible: UnsafeMutablePointer<GtkInvisible>
	
	internal init(n_Invisible: UnsafeMutablePointer<GtkInvisible>) {
		self.n_Invisible = n_Invisible
		super.init(n_Widget: UnsafeMutablePointer<GtkWidget>(n_Invisible))
	}
	
	public convenience init() {
		self.init(n_Invisible: UnsafeMutablePointer<GtkInvisible>(gtk_invisible_new()))
	}
	
	// TODO: gtk_invisible_new_for_screen, gtk_invisible_set_screen, gtk_invisible_get_screen
}