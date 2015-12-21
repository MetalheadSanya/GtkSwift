//
// Created by Alexander Zalutskiy on 21.12.15.
// Copyright (c) 2015 Metalhead. All rights reserved.
//

import CGTK

enum DialogFlags: Int {
	case Modal = 0b00000001
	case DestroyWithParent = 0b00000010
  case UseHeaderBar = 0b00000100
}

typealias DialogButton = (text: String, response: Int)

class Dialog: Window {

	internal var n_Dialog: UnsafeMutablePointer<GtkDialog>

	internal init(n_Dialog: UnsafeMutablePointer<GtkDialog>) {
		self.n_Dialog = n_Dialog
		super.init(n_Window: unsafeBitCast(self.n_Dialog, UnsafeMutablePointer<GtkWindow>.self))
	}

	convenience init() {
		self.init(n_Dialog: unsafeBitCast(gtk_dialog_new(), UnsafeMutablePointer<GtkDialog>.self))
	}

	convenience init(title: String?, parent: Window, flags: Int, buttons: [DialogButton]?) {
		let dialog = g_object_newv(gtk_dialog_get_type(), 0, nil)

		self.init(n_Dialog: unsafeBitCast(dialog, UnsafeMutablePointer<GtkDialog>.self))

		if let title = title {
			self.title = title
		}

		if let buttons = buttons {
			addButtons(buttons)
		}
	}

	func run() -> Int {
		return Int(gtk_dialog_run(n_Dialog))
	}

	func response(response: Int) {
		gtk_dialog_response(n_Dialog, Int32(response))
	}

	func addButtonWithText(text: String, response: Int) -> Button {
		return Button(n_Button: unsafeBitCast(gtk_dialog_add_button(n_Dialog, text, Int32(response)),
				UnsafeMutablePointer<GtkButton>.self))
	}

	func addButtons(buttons: [DialogButton]) {
		for button in buttons {
			_ = addButtonWithText(button.text, response: button.response)
		}
	}

	func addActionWidget(widget: Widget, response: Int) {
		gtk_dialog_add_action_widget(n_Dialog, widget.n_Widget, Int32(response))
	}

	func setDefaultResponse(response: Int) {
		gtk_dialog_set_default_response(n_Dialog, Int32(response))
	}

	func setResponseSensitive(response: Int, sensitive: Bool) {
		gtk_dialog_set_response_sensitive(n_Dialog, Int32(response), sensitive ? 1 : 0)
	}

	func getResponseForWidget(widget: Widget) -> Int {
		return Int(gtk_dialog_get_response_for_widget(n_Dialog, widget.n_Widget))
	}

	func getWidgetWorResponse(response: Int) -> Widget {
		return Widget(o_Widget: gtk_dialog_get_widget_for_response(n_Dialog, Int32(response)))
	}

	func getContentArea() -> Box {
		return Box(n_Box: unsafeBitCast(gtk_dialog_get_content_area(n_Dialog), UnsafeMutablePointer<GtkBox>.self))
	}

//	func getHeaderBar() -> Widget? {
//		if let headerBarPointer = gtk_dialog_get_header_bar(n_Dialog) {
//			return Widget(n_Widget: headerBarPointer)
//		} else {
//			return nil
//		}
//	}

}
