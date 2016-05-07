//
// Created by Alexander Zalutskiy on 21.12.15.
// Copyright (c) 2015 Metalhead. All rights reserved.
//

import CGTK

public class Misc: Widget {

	internal var n_Misc: UnsafeMutablePointer<GtkMisc>

	override class var n_Type: UInt {
		return gtk_misc_get_type()
	}

	internal init(n_Misc: UnsafeMutablePointer<GtkMisc>) {
		self.n_Misc = n_Misc
		super.init(n_Widget: unsafeBitCast(self.n_Misc, to: UnsafeMutablePointer<GtkWidget>.self))
	}
}