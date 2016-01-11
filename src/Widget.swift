import CGTK

class Widget {

	class var n_Type: UInt {
		return 0
	}

	var n_Widget: UnsafeMutablePointer<GtkWidget>

	internal init(n_Widget: UnsafeMutablePointer<GtkWidget>) {
		self.n_Widget = n_Widget
	}

	internal init?(o_Widget: UnsafeMutablePointer<GtkWidget>) {
		guard o_Widget != nil else { return nil }
		self.n_Widget = o_Widget
	}

	func destroy() {
		gtk_widget_destroy(n_Widget)
	}

	// TODO: some for gtk_widget_in_destruction(), gtk_widget_destroyed()

	func show() {
		gtk_widget_show(n_Widget)
	}

	func showNow() {
		gtk_widget_show_now(n_Widget)
	}

	func hide() {
		gtk_widget_hide(n_Widget)
	}

	func showAll() {
		gtk_widget_show_all(n_Widget)
	}

	///This function is only for use in widget implementations. Causes a widget to be mapped if it isn’t already.
	func map() {
		gtk_widget_map(n_Widget)
	}

	///This function is only for use in widget implementations. Causes a widget to be unmapped if it isn’t already.
	func unmap() {
		gtk_widget_map(n_Widget)
	}

	func realize() {
		gtk_widget_realize(n_Widget)
	}

	func unrealize() {
		gtk_widget_realize(n_Widget)
	}

	// TODO: use cario-swift
	// func draw(cr: UnsafeMutablePointer<cario_t>) {
	// 	gtk_widget_draw(n_Widget, cr)
	// }

	/// Equivalent to calling gtk_widget_queue_draw_area() for the entire area of a widget.
	func queueDraw() {
		gtk_widget_queue_draw(n_Widget)
	}

	/// This function is only for use in widget implementations. Flags a widget to have its size renegotiated; should be called when a widget for some reason has a new size request. For example, when you change the text in a GtkLabel, GtkLabel queues a resize to ensure there’s enough space for the new text.
	func queueResize() {
		gtk_widget_queue_resize(n_Widget)
	}

	/// This function works like gtk_widget_queue_resize(), except that the widget is not invalidated.
	func queueResizeNoRedraw() {
		gtk_widget_queue_resize_no_redraw(n_Widget)
	}

	// TODO: use gdk-swift
	// func getFrameClock() -> UnsafeMutablePointer<GdkFrameClock> {
	// 	return gtk_widget_get_frame_clock(n_Widget)
	// }

	var scaleFactor: Int {
		get {
			return Int(gtk_widget_get_scale_factor(n_Widget))
		}
	}

	// TODO: some for gtk_widget_get_frame_clock(), gtk_widget_get_frame_clock()

	// TODO: some for gtk_widget_size_allocate(), gtk_widget_size_allocate_with_baseline(), need GtkAllocation

	// TODO: some for gtk_widget_add_accelerator(), need GtkAccelGroup, GtkModifierType GtkAccelFlags

	// TODO: some for gtk_widget_remove_accelerator(), need GtkAccelGroup, GtkModifierType

	// TODO: some for gtk_widget_set_accel_path(), need GtkAccelGroup

	// TODO: some for gtk_widget_list_accel_closures()

	// TODO: some for gtk_widget_can_activate_accel()

	// TODO: use gdk-swift 
	// func event(event: UnsafeMutablePointer<GdkEvent>) -> Bool {
	// 	 return gtk_widget_event(n_Widget, event) != 0	
	// }

	func activate() -> Bool {
		return gtk_widget_activate(n_Widget) != 0
	}

	// TODO: use gdk-swift 
	// func intersect(area: UnsafeMutablePointer<GdkRectangle>, inout var intersection: UnsafeMutablePointer<GdkRectangle>) -> Bool {
	// 	 return gtk_widget_intersect(n_Widget, area, intersection) != 0
	// }

	var isFocus: Bool {
		return gtk_widget_is_focus(n_Widget) != 0
	}

	func grabFocus() {
		gtk_widget_grab_focus(n_Widget)
	}

	func grabDefault() {
		gtk_widget_grab_default(n_Widget)
	}

	var name: String {
		get {
			return String(gtk_widget_get_name(n_Widget))
		}
		set(value) {
			gtk_widget_set_name(n_Widget, value)
		}
	}

	// var sensitive: Bool {
	// 	set(value) {
	// 		gtk_widget_set_sensitive(n_Widget, value ? 1 : 0)
	// 	}
	// }

	/**
	This function is useful only when implementing subclasses of Container.
	Sets the container as the parent of widget, and takes care of some details such as updating the state and style of the child to reflect its new location.
	Remove parent can be called by implementations of the remove method on Container, to dissociate a child from the container.
	*/
	var parent: Widget? {
		didSet {
			if let parent = parent {
				gtk_widget_set_parent(n_Widget, parent.n_Widget)
			} else {
				gtk_widget_unparent(n_Widget)
			}
		}
	}

  // TODO: Fix
	// var parentWindow: Window? {
	// 	didSet {
	// 		if let parentWindow = parentWindow {
	// 			gtk_widget_set_parent_window(n_Widget, parentWindow.n_Window)
	// 		}
	// 	}
	// }

	// TODO: use gdk-swift
	// var eventsMask: Int {
	// 	set(value) {
	// 		gtk_widget_set_events(n_Window, value)
	// 	}
	// 	get {
	// 		return Int(gtk_widget_get_events(n_Widget))
	// 	}

	// TODO: some for gtk_widget_add_events(), use gdk-swift

	// TODO: some for gtk_widget_set_device_events(), gtk_widget_det_device_events(), gtk_widget_add_device_events() use gdk-swift

	// TODO: some for gtk_widget_set_device_enabled(), gtk_widget_get_device_enabled(), user gdk-swift

	func getToplevel() -> Widget? {
		var widget = self

		while widget.parent != nil {
			widget = widget.parent!
		}

		return widget
	}

	func getAncestor<T: Widget>() -> T? {
		var widget = self

		while !(widget is T) {
			guard let parent = widget.parent else { return nil }
			widget = parent
		}

		return widget as? T
	}

	// TODO: some for gtk_widget_get_visual(), gtk_widget_set_visual(), user gdk-swift

	func isAncestorFor(ancestor: Widget) -> Bool {
		var widget = self

		while widget.parent != nil {
			if widget.parent! == ancestor {
				return true
			}
			widget = widget.parent!
		} 

		return false
	}

	// TODO: some for gtk_widget_translate_coordinates(), need Point class

	func hideOnDelete() -> Bool {
		return gtk_widget_hide_on_delete(n_Widget) != 0
	}

	var direction: TextDirection {
		get {
			let direction = gtk_widget_get_direction(n_Widget)
			return TextDirection(rawValue: direction)
		}
		set(value) {
			gtk_widget_set_direction(n_Widget, direction.rawValue)
		}
	}

	class var defaultDirection: TextDirection {
		get {
			let direction = gtk_widget_get_default_direction()
			return TextDirection(rawValue: direction)
		}
		set(value) {
			gtk_widget_set_default_direction(value.rawValue)
		}
	}

	// TODO: some for gtk_widget_shape_combine_region(), gtk_widget_input_shape_combine_region(), need cario-swift

	// TODO: some for gtk_widget_create_pango_context(), gtk_widget_get_pango_context(), gtk_widget_create_pango_layout(), need pango-swift

	// TODO: some for gtk_widget_queue_draw_area(), need Rectangle struct

	// TODO: some for gtk_widget_queue_draw_region(), need cario-swift

	// var appPrintable: Bool {
	// 	set(value) {
	// 		gtk_widget_set_app_paintable(n_Widget, value ? 1 : 0)
	// 	}
	// }

	// var redrawOnAllocate: Bool {
	// 	set(value) {
	// 		gtk_widget_set_redraw_on_allocate(n_Widget, value ? 1 : 0)
	// 	}
	// }

	// var mnemonicActivate: Bool {
	// 	set(value) {
	// 		gtk_widget_mnemonic_activate(n_Widget, value ? 1 : 0)
	// 	}
	// }

	// TODO: some for gtk_widget_class_install_style_property(), gtk_widget_class_install_style_property_parser(), gtk_widget_class_find_style_property(), gtk_widget_class_list_style_properties(), after new idea about properties

	// TODO: some for gtk_widget_send_expose(), gtk_widget_send_focus_change(), use gdk-swift

	// TODO: some for gtk_widget_style_get(), gtk_widget_style_get_property(), gtk_widget_style_get_valist(), after new idea about properties and styles

	// TODO: some for gtk_widget_class_set_accessible_type(), gtk_widget_class_set_accessible_role(), gtk_widget_get_accessible(), use atk-swift

	func childFocus(direcrion: DirectionType) -> Bool {
		return gtk_widget_child_focus(n_Widget, direcrion.rawValue) != 0
	}

	// TODO: some for gtk_widget_child_notify(), gtk_widget_freeze_child_notify(), need signals

	var childVisible: Bool {
		get {
			return gtk_widget_get_child_visible(n_Widget) != 0
		}
		set(value) {
			gtk_widget_set_child_visible(n_Widget, childVisible ? 1 : 0)
		}
	}

	// TODO: some for gtk_widget_get_settings(), need GtkSettings class

	// TODO: some for gtk_widget_get_clipboard(), use gdk-swift

	// TODO: some for gtk_widget_get_display(), use gdk-swift

	// TODO: some for gtk_widget_get_screen(), gtk_widget_has_screen(), use gdk-swift

	var sizeRequest: Size {
		get {
			let width: UnsafeMutablePointer<Int32> = nil
			let height: UnsafeMutablePointer<Int32> = nil

			gtk_widget_get_size_request(n_Widget, width, height)

			return Size(width: Int(width.memory), height: Int(height.memory))
		}
		set(value) {
			gtk_widget_set_size_request(n_Widget, Int32(value.width), Int32(value.height))
		}
	}

	// TODO: some for gtk_widget_thaw_child_notify(), need signals

	var noShowAll: Bool {
		get {
			return gtk_widget_get_no_show_all(n_Widget) != 0
		}
		set(value) {
			gtk_widget_set_no_show_all(n_Widget, noShowAll ? 1 : 0)
		}
	}

	// TODO: some for gtk_widget_list_mnemonic_labels(), gtk_widget_add_mnemonic_label(), gtk_widget_remove_mnemonic_label(), need understand this

	var composited: Bool {
		get {
			return gtk_widget_is_composited(n_Widget) != 0
		}
	}

	func errorBell() {
		gtk_widget_error_bell(n_Widget)
	}


}

extension Widget: Equatable { }

func ==(lhs: Widget, rhs: Widget) -> Bool {
	return lhs.n_Widget == rhs.n_Widget
}

enum TextDirection: RawRepresentable {
	case None, LeftToRight, RightToLeft

	typealias RawValue = GtkTextDirection

	var rawValue: RawValue {
		switch self {
		case .None:
			return GTK_TEXT_DIR_NONE
		case .LeftToRight:
			return GTK_TEXT_DIR_LTR
		case .RightToLeft:
			return GTK_TEXT_DIR_RTL
		}
	}

	init(rawValue: RawValue) {
		self = (rawValue == GTK_TEXT_DIR_LTR) ? .LeftToRight : 
		    (rawValue == GTK_TEXT_DIR_RTL) ? .RightToLeft : .None
	}
}