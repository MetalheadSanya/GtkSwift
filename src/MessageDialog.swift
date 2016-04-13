//
// Created by Alexander Zalutskiy on 21.12.15.
// Copyright (c) 2015 Metalhead. All rights reserved.
//

import CGTK

enum ButtonsType: Int {
	case None, Ok, Close, Cancel, YesNo, OkCancel
}

enum MessageType: Int {
	case Info, Warning, Question, Error, Other
}

class MessageDialog: Dialog {
	internal var n_MessageDialog: UnsafeMutablePointer<GtkMessageDialog>

	override class var n_Type: UInt {
		return gtk_message_dialog_get_type()
	}

	internal init(n_MessageDialog: UnsafeMutablePointer<GtkMessageDialog>) {
		self.n_MessageDialog = n_MessageDialog
		super.init(n_Dialog: unsafeBitCast(n_MessageDialog, to: UnsafeMutablePointer<GtkDialog>.self))
	}

	convenience init(window: Window, flags: [DialogFlag], type: MessageType, buttonsType: ButtonsType, message: String?) {
		var parameters = [
				g_parameter_bool(name: "use-header-bar", value: false),
				g_parameter_int32(name: "message-type", value: type.rawValue),
				g_parameter_int32(name: "buttons", value: buttonsType.rawValue),
		]

		let arrayOfParameters = UnsafeMutablePointer<GParameter>(allocatingCapacity: 3)
		arrayOfParameters.pointee = parameters[0]
		arrayOfParameters.advanced(by: 1).pointee = parameters[1]
		arrayOfParameters.advanced(by: 2).pointee = parameters[2]

		self.init(n_MessageDialog: unsafeBitCast(g_object_newv((MessageDialog.n_Type),
				UInt32(parameters.count), arrayOfParameters), to: UnsafeMutablePointer<GtkMessageDialog>.self))

		arrayOfParameters.deallocateCapacity(3)

		buildWidgetTree()

		for widget in getMessageArea().getChildren() {
			if let label = widget as? Label {
				label.text = message
				break
			}
		}

		transientFor = window

		if let _ = flags.index(of: .Modal) {
			self.modal = true
		}

		if let _ = flags.index(of: .DestroyWithParent) {
			self.destroyWithParent = true
		}
	}

	func setMarkup(_ murkupString: String) {
		gtk_message_dialog_set_markup(n_MessageDialog, murkupString)
	}

	//TODO: gtk_message_dialog_format_secondary_text
	//TODO: gtk_message_dialog_format_secondary_markup

	func getMessageArea() -> VBox {
		return VBox(n_VBox: unsafeBitCast(gtk_message_dialog_get_message_area(n_MessageDialog),
				to: UnsafeMutablePointer<GtkVBox>.self))
	}
}