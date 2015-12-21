//
// Created by Alexander Zalutskiy on 21.12.15.
// Copyright (c) 2015 Metalhead. All rights reserved.
//

import CGTK

class Dialog: Window {

	internal var n_Dialog: UnsafeMutablePointer<GtkDialog>

	internal init(n_Dialog: UnsafeMutablePointer<GtkDialog>) {
		self.n_Dialog = n_Dialog
		super.init(n_Window: unsafeBitCast(self.n_Dialog, UnsafeMutablePointer<GtkWindow>.self))
	}

	convenience init() {
		self.init(n_Dialog: unsafeBitCast(gtk_dialog_new(), UnsafeMutablePointer<GtkDialog>.self))
	}

	convenience init(title: String, parent: Window, flags: Int, buttons: [(String, Int32)]?) {
		self.init(n_Dialog: unsafeBitCast(gtk_dialog_new_with_buttons(title, parent.n_Window, UInt32(flags), nil),
				UnsafeMutablePointer<GtkDialog>.self))

		for button in buttons? {
			addButtonWithText(button.0, response: button.1)
		}
	}

	func addButtonWithText(text: String, response: Int32) {
		gtk_dialog_add_button(n_Dialog, text, response)
	}

	func run() -> Int {
		return Int(gtk_dialog_run(n_Dialog))
	}

}
