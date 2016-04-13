//
// Created by Alexander Zalutskiy on 21.12.15.
// Copyright (c) 2015 Metalhead. All rights reserved.
//

import CGTK

class VBox: Box {
	internal var n_VBox: UnsafeMutablePointer<GtkVBox>

	internal init(n_VBox: UnsafeMutablePointer<GtkVBox>) {
		self.n_VBox = n_VBox
		super.init(n_Box: unsafeBitCast(n_VBox, to: UnsafeMutablePointer<GtkBox>.self))
	}
}
