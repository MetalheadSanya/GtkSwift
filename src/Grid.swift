//
// Created by Alexander Zalutskiy on 21.12.15.
// Copyright (c) 2015 Metalhead. All rights reserved.
//

import CGTK

class Grid: Container {
	internal var n_Grid: UnsafeMutablePointer<GtkGrid>

	internal init(n_Grid: UnsafeMutablePointer<GtkGrid>) {
		self.n_Grid = n_Grid
		super.init(n_Container: unsafeBitCast(self.n_Grid, to: UnsafeMutablePointer<GtkContainer>.self))
	}

	convenience init() {
		self.init(n_Grid: unsafeBitCast(gtk_grid_new(), to: UnsafeMutablePointer<GtkGrid>.self))
	}

	func attachWidget(_ widget: Widget, left: Int, top: Int, width: Int, height: Int) {
		gtk_grid_attach(n_Grid, widget.n_Widget, Int32(left), Int32(top), Int32(width), Int32(height))
	}
}
