//
// Created by Alexander Zalutskiy on 21.12.15.
// Copyright (c) 2015 Metalhead. All rights reserved.
//

import CGTK

class Label: Misc {

	internal var n_Label: UnsafeMutablePointer<GtkLabel>

	override class var n_Type: UInt {
		return gtk_label_get_type()
	}

	init(n_Label: UnsafeMutablePointer<GtkLabel>) {
		self.n_Label = n_Label
		super.init(n_Misc: unsafeBitCast(self.n_Label, UnsafeMutablePointer<GtkMisc>.self))
	}

	var text: String? {
		set(value) {
			if let value = value {
				gtk_label_set_text(n_Label, value)
			} else {
				gtk_label_set_text(n_Label, nil)
			}
		}
		get {
			let str = gtk_label_get_text(n_Label)
			if str != nil {
				return String.fromCString(str)
			} else {
				return nil
			}
		}
	}

}
