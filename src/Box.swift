//
// Created by Alexander Zalutskiy on 21.12.15.
// Copyright (c) 2015 Metalhead. All rights reserved.
//

import CGTK

class Box: Container {
	internal var n_Box: UnsafeMutablePointer<GtkBox>

	internal init(n_Box: UnsafeMutablePointer<GtkBox>) {
		self.n_Box = n_Box
		super.init(n_Container: unsafeBitCast(self.n_Box, to: UnsafeMutablePointer<GtkContainer>.self))
	}
}
