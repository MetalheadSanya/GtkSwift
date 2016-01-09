//
// Created by Alexander Zalutskiy on 21.12.15.
// Copyright (c) 2015 Metalhead. All rights reserved.
//

import CGTK

internal func g_signal_connect (instance: gpointer, _ detailed_signal: String, _ c_handler: UnsafePointer<Void>, _ data: UnsafeMutablePointer<Void>) {
	g_signal_connect_data ((instance), (detailed_signal), unsafeBitCast(c_handler, GCallback.self), (data), nil, GConnectFlags(0))
}

internal let G_TYPE_BOOLEAN = ((GType) ((5) << G_TYPE_FUNDAMENTAL_SHIFT))
internal let G_TYPE_INT = ((GType) ((6) << G_TYPE_FUNDAMENTAL_SHIFT))

private func g_value_for_type(type: GType) -> GValue {
	var val = GValue()

	g_value_init(&val, type)

	return val
}

internal func g_parameter_bool(name name: String, value: Bool) -> GParameter {
	var val = g_value_for_type(G_TYPE_BOOLEAN)

	g_value_set_boolean(&val, value ? 1 : 0)

	return GParameter(name: name, value: val)
}

internal func g_parameter_int32(name name: String, value: Int) -> GParameter {
	var val = g_value_for_type(G_TYPE_INT)

	g_value_set_int(&val, Int32(value))

	return GParameter(name: name, value: val)
}

private func _G_TYPE_CIT(ip: UnsafeMutablePointer<GTypeInstance>, gt: GType) -> Bool {
		let __inst = ip
		let __t = gt
		var __r: Bool = false
		if __inst != nil && __inst.memory.g_class != nil && __inst.memory.g_class.memory.g_type == __t {
			__r = true
		} else {
			__r = g_type_check_instance_is_a(__inst, __t) != 0
		}
		return __r
}

private func G_TYPE_CHECK_INSTANCE_TYPE(ip: UnsafeMutablePointer<GTypeInstance>, _ gt: GType) -> Bool {
	return _G_TYPE_CIT(ip, gt: gt)
}

internal extension Widget {
	class func buildRightWidget(n_Widget: UnsafeMutablePointer<GtkWidget>) -> Widget {

		let poiner = unsafeBitCast(n_Widget, UnsafeMutablePointer<GTypeInstance>.self)

		// Dialogs
		if G_TYPE_CHECK_INSTANCE_TYPE(poiner, MessageDialog.n_Type) {
			return MessageDialog(n_MessageDialog: unsafeBitCast(n_Widget, UnsafeMutablePointer<GtkMessageDialog>.self))
		}
		else if G_TYPE_CHECK_INSTANCE_TYPE(poiner, Dialog.n_Type) {
			return Dialog(n_Dialog: unsafeBitCast(n_Widget, UnsafeMutablePointer<GtkDialog>.self))
		}
		else if G_TYPE_CHECK_INSTANCE_TYPE(poiner, Dialog.n_Type) {
			return Dialog(n_Dialog: unsafeBitCast(n_Widget, UnsafeMutablePointer<GtkDialog>.self))
		}
		// Misc
		else if G_TYPE_CHECK_INSTANCE_TYPE(poiner, Label.n_Type) {
			return Label(n_Label: unsafeBitCast(n_Widget, UnsafeMutablePointer<GtkLabel>.self))
		}
		return Widget(n_Widget: n_Widget)
	}
}