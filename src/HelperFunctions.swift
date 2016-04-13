//
// Created by Alexander Zalutskiy on 21.12.15.
// Copyright (c) 2015 Metalhead. All rights reserved.
//

import CGTK
import gobjectswift

internal func g_signal_connect (instance: gpointer, _ detailed_signal: String, _ c_handler: UnsafePointer<Void>, _ data: UnsafeMutablePointer<Void>) {
	g_signal_connect_data ((instance), (detailed_signal), unsafeBitCast(c_handler, to: GCallback.self), (data), nil, GConnectFlags(0))
}

internal let G_TYPE_BOOLEAN = ((GType) ((5) << G_TYPE_FUNDAMENTAL_SHIFT))
internal let G_TYPE_INT = ((GType) ((6) << G_TYPE_FUNDAMENTAL_SHIFT))

private func g_value_for_type(_ type: GType) -> GValue {
	var val = GValue()

	g_value_init(&val, type)

	return val
}

internal func g_parameter_bool(name: String, value: Bool) -> GParameter {
	var val = g_value_for_type(G_TYPE_BOOLEAN)

	g_value_set_boolean(&val, value ? 1 : 0)

	return GParameter(name: name, value: val)
}

internal func g_parameter_int32(name: String, value: Int) -> GParameter {
	var val = g_value_for_type(G_TYPE_INT)

	g_value_set_int(&val, Int32(value))

	return GParameter(name: name, value: val)
}

private func _G_TYPE_CIT(_ ip: UnsafeMutablePointer<GTypeInstance>?, gt: GType) -> Bool {
		let __inst = ip
		let __t = gt
		var __r: Bool = false
		if __inst != nil && __inst!.pointee.g_class != nil && __inst!.pointee.g_class.pointee.g_type == __t {
			__r = true
		} else {
			__r = g_type_check_instance_is_a(__inst, __t) != 0
		}
		return __r
}

private func G_TYPE_CHECK_INSTANCE_TYPE(_ ip: UnsafeMutablePointer<GTypeInstance>, _ gt: GType) -> Bool {
	return _G_TYPE_CIT(ip, gt: gt)
}

internal extension Container {
	func buildWidgetTree() {

		let containerList = gtk_container_get_children(n_Container)
		let n_Children = Array<UnsafeMutablePointer<GtkWidget>>(gList: containerList)
		for n_Widget in n_Children {
			let widget = Container.correctWidgetForWidget(Widget(n_Widget: n_Widget))
			outsideGtkAddWidget(widget)
		}
	}

	class func correctWidgetForWidget(_ obj: Widget) -> Widget {
		func stringFromObject(obj: Object) -> String {
			return String(cString: g_type_name(obj.gTypeFromInstance()))
		}

		switch stringFromObject(obj: obj) {
		case "GtkBin":
			let bin = Bin(n_Bin: unsafeBitCast(obj.n_Widget, to: UnsafeMutablePointer<GtkBin>.self))
			bin.buildWidgetTree()
			return bin
		case "GtkBox":
			let box = Box(n_Box: unsafeBitCast(obj.n_Widget, to: UnsafeMutablePointer<GtkBox>.self))
			box.buildWidgetTree()
			return box
		case "GtkButton":
			let button = Button(n_Button: unsafeBitCast(obj.n_Widget, to: UnsafeMutablePointer<GtkButton>.self))
			button.buildWidgetTree()
			return button
		case "GtkButtonBox":
			let buttonBox = ButtonBox(n_ButtonBox: unsafeBitCast(obj.n_Widget, to: UnsafeMutablePointer<GtkButtonBox>.self))
			buttonBox.buildWidgetTree()
			return buttonBox
		case "GtkContainer":
			let container = Container(n_Container: unsafeBitCast(obj.n_Widget, to: UnsafeMutablePointer<GtkContainer>.self))
			container.buildWidgetTree()
			return container
		case "GtkDialog":
			let dialog = Dialog(n_Dialog: unsafeBitCast(obj.n_Widget, to: UnsafeMutablePointer<GtkDialog>.self))
			dialog.buildWidgetTree()
			return dialog
		case "GtkLabel":
			let label = Label(n_Label: unsafeBitCast(obj.n_Widget, to: UnsafeMutablePointer<GtkLabel>.self))
			return label
		case "GtkMessageDialog":
			let messageDialog = MessageDialog(n_MessageDialog: unsafeBitCast(obj.n_Widget, to: UnsafeMutablePointer<GtkMessageDialog>.self))
			messageDialog.buildWidgetTree()
			return messageDialog
		case "GtkMisc":
			let misc = Misc(n_Misc: unsafeBitCast(obj.n_Widget, to: UnsafeMutablePointer<GtkMisc>.self))
			return misc
		case "GtkVBox":
			let vBox = VBox(n_VBox: unsafeBitCast(obj.n_Widget, to: UnsafeMutablePointer<GtkVBox>.self))
			vBox.buildWidgetTree()
			return vBox
		case "GtkWidget":
			let widget = Widget(n_Widget: unsafeBitCast(obj.n_Widget, to: UnsafeMutablePointer<GtkWidget>.self))
			return widget
		case "GtkWindow":
			let window = Window(n_Window: unsafeBitCast(obj.n_Widget, to: UnsafeMutablePointer<GtkWindow>.self))
			window.buildWidgetTree()
			return window
		default:
			return obj
		}

	}
}