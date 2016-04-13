//
// Created by Alexander Zalutskiy on 21.12.15.
// Copyright (c) 2015 Metalhead. All rights reserved.
//

import CGTK
import gobjectswift

enum DialogFlag: Int {
	case Modal = 0b00000001
	case DestroyWithParent = 0b00000010
  case UseHeaderBar = 0b00000100
}

typealias DialogCloseCallback = (Dialog) -> Void
typealias DialogResponseCallback = (Dialog, Int) -> Void

typealias DialogButton = (text: String, response: Int)

class Dialog: Window {

	internal var n_Dialog: UnsafeMutablePointer<GtkDialog>

	override class var n_Type: UInt {
		return gtk_dialog_get_type()
	}

	internal init(n_Dialog: UnsafeMutablePointer<GtkDialog>) {
		self.n_Dialog = n_Dialog
		super.init(n_Window: unsafeBitCast(self.n_Dialog, to: UnsafeMutablePointer<GtkWindow>.self))
	}

	convenience init() {
		self.init(n_Dialog: unsafeBitCast(gtk_dialog_new(), to: UnsafeMutablePointer<GtkDialog>.self))
	}

	convenience init(title: String?, parent: Window?, flags: [DialogFlag], buttons: [DialogButton]?) {
		var parameter = g_parameter_bool(name: "use-header-bar", value: flags.index(of: .UseHeaderBar) != nil)

		let dialog = g_object_newv(Dialog.n_Type, 1, &parameter)

		self.init(n_Dialog: unsafeBitCast(dialog, to: UnsafeMutablePointer<GtkDialog>.self))

		self.title = title

		if let parent = parent {
			self.transientFor = parent
		}

		if let _ = flags.index(of: .Modal) {
			self.modal = true
		}

		if let _ = flags.index(of: .DestroyWithParent) {
			self.destroyWithParent = true
		}

		if let buttons = buttons {
			addButtons(buttons)
		}
	}

	func run() -> Int {
		return Int(gtk_dialog_run(n_Dialog))
	}

	func response(_ response: Int) {
		gtk_dialog_response(n_Dialog, Int32(response))
	}

	func addButtonWithText(_ text: String, response: Int) -> Button {
		return Button(n_Button: unsafeBitCast(gtk_dialog_add_button(n_Dialog, text, Int32(response)),
				to: UnsafeMutablePointer<GtkButton>.self))
	}

	func addButtons(_ buttons: [DialogButton]) {
		for button in buttons {
			_ = addButtonWithText(button.text, response: button.response)
		}
	}

	func addActionWidget(_ widget: Widget, response: Int) {
		gtk_dialog_add_action_widget(n_Dialog, widget.n_Widget, Int32(response))
	}

	func setDefaultResponse(_ response: Int) {
		gtk_dialog_set_default_response(n_Dialog, Int32(response))
	}

	func setResponseSensitive(_ response: Int, sensitive: Bool) {
		gtk_dialog_set_response_sensitive(n_Dialog, Int32(response), sensitive ? 1 : 0)
	}

	func getResponseForWidget(_ widget: Widget) -> Int {
		return Int(gtk_dialog_get_response_for_widget(n_Dialog, widget.n_Widget))
	}

	func getWidgetWorResponse(_ response: Int) -> Widget? {
		return Widget(o_Widget: gtk_dialog_get_widget_for_response(n_Dialog, Int32(response)))
	}

	func getContentArea() -> Box {
		return Box(n_Box: unsafeBitCast(gtk_dialog_get_content_area(n_Dialog), to: UnsafeMutablePointer<GtkBox>.self))
	}

//	func getHeaderBar() -> Widget? {
//		if let headerBarPointer = gtk_dialog_get_header_bar(n_Dialog) {
//			return Widget(n_Widget: headerBarPointer)
//		} else {
//			return nil
//		}
//	}

	typealias DialogCloseNative = @convention(c)(UnsafeMutablePointer<GtkDialog>, gpointer) -> Void

	lazy var clodeSignal: Signal<DialogCloseCallback, Dialog, DialogCloseNative>
			= Signal(obj: self, signal: "close", c_handler: {
				(_, user_data) in
				let data = unsafeBitCast(user_data, to: SignalData<Dialog, DialogCloseCallback>.self)

				let dialog = data.obj
				let action = data.function

				action(dialog)
			})

	typealias DialogResponseNative = @convention(c)(UnsafeMutablePointer<GtkDialog>, gint, gpointer) -> Void

	/// Emitted when a Window is added to application through Application.addWindow(_:).
	lazy var windowAddedSignal: Signal<DialogResponseCallback, Dialog, DialogResponseNative>
			= Signal(obj: self, signal: "response", c_handler: {
				(_, n_response, user_data) in
				let data = unsafeBitCast(user_data, to: SignalData<Dialog, DialogResponseCallback>.self)

				let dialog = data.obj
				let response = Int(n_response)
				let action = data.function

				action(dialog, response)
			})
}