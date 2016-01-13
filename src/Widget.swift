import CGTK

typealias CDestroyFunc = (UnsafeMutablePointer<GtkWidget>) -> Void

private class WidgetNotificationCenter {
	static let sharedInstance = WidgetNotificationCenter()

	private let destroy_widget: @convention(c) (widget: UnsafeMutablePointer<GtkWidget>) -> Void = {
		WidgetNotificationCenter.sharedInstance.destroy($0)
	}

	private var registers = [(widget: Widget, gtkWidget: UnsafeMutablePointer<GtkWidget>)]()

	func register(obj: Widget, fromNativeWidget widget: UnsafeMutablePointer<GtkWidget>) {
		registers.append((obj, widget))
	}

	func unregisterForClicked(obj: Widget) {
		registers = registers.filter { $0.widget != obj }
	}

	func destroy(widget: UnsafeMutablePointer<GtkWidget>) {
		let forPerform = registers.filter { $0.gtkWidget == widget }

		for (obj, _) in forPerform {
			obj.destroy()
		}
	}
}

class Widget {

	class var n_Type: UInt {
		return 0
	}

	var n_Widget: UnsafeMutablePointer<GtkWidget>

	internal init(n_Widget: UnsafeMutablePointer<GtkWidget>) {
		self.n_Widget = n_Widget
		overrideGtkHandler()
	}

	internal init?(o_Widget: UnsafeMutablePointer<GtkWidget>) {
		guard o_Widget != nil else { return nil }
		self.n_Widget = o_Widget
		overrideGtkHandler()
	}

	private static var gtk_widget_destroy_real: CDestroyFunc!

	private func getGtkWidgetClass() -> UnsafeMutablePointer<GtkWidgetClass> {
		return unsafeBitCast(unsafeBitCast(n_Widget, UnsafeMutablePointer<GTypeInstance>.self).memory.g_class,
				UnsafeMutablePointer<GtkWidgetClass>.self)
	}

	private func overrideGtkHandler() {
		let gtkClass = getGtkWidgetClass()

		if Widget.gtk_widget_destroy_real == nil {
			Widget.gtk_widget_destroy_real = gtkClass.memory.destroy
		}

		gtkClass.memory.destroy = WidgetNotificationCenter.sharedInstance.destroy_widget

		WidgetNotificationCenter.sharedInstance.register(self, fromNativeWidget: n_Widget)
	}

	func destroy() {
		print("destroy overriding success")
		Widget.gtk_widget_destroy_real(n_Widget)
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

	func sizeAllocate(rect: Rectangle) {
		gtk_widget_size_allocate(n_Widget, rect.gdkRectangle)
	}

	func sizeAllocateWithBaseline(rect: Rectangle, baseline: Int) {

	}

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

	var sensitive: Bool {
		get {
			return gtk_widget_get_sensitive(n_Widget) != 0
		}
		set(value) {
			gtk_widget_set_sensitive(n_Widget, value ? 1 : 0)
		}
	}

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

	var appPrintable: Bool {
		get {
			return gtk_widget_get_app_paintable(n_Widget) != 0
		}
		set(value) {
			gtk_widget_set_app_paintable(n_Widget, value ? 1 : 0)
		}
	}

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

	func keynavFailed(direction: DirectionType) -> Bool {
		return gtk_widget_keynav_failed(n_Widget, direction.rawValue) != 0
	}

	var tooltipMarkup: String {
		get {
			return String(gtk_widget_get_tooltip_markup(n_Widget))
		}
		set(value) {
			gtk_widget_set_tooltip_markup(n_Widget, value)
		}
	}

	var tooltipText: String {
		get {
			return String(gtk_widget_get_tooltip_text(n_Widget))
		}
		set(value) {
			gtk_widget_set_tooltip_text(n_Widget, value)
		}
	}

	// TODO: some for gtk_widget_get_tooltip_window(), gtk_widget_set_tooltip_window(), need get defailt tooltip_window

	var hasTooltip: Bool {
		get {
			return gtk_widget_get_has_tooltip(n_Widget) != 0
		}
		set(value) {
			gtk_widget_set_has_tooltip(n_Widget, value ? 1 : 0)
		}
	}

	func triggerTooltipQuery() {
		gtk_widget_trigger_tooltip_query(n_Widget)
	}

	// TODO: use gdk-swift
	// var window: Window? {
	// 	didSet {
	// 		let pointer: COpaquePointer
	// 		if let window = window {
	// 			pointer = COpaquePointer(window.n_Window)
	// 		} else {
	// 			pointer = COpaquePointer()
	// 		}
	// 		gtk_widget_set_window(n_Widget, pointer)
	// 	}
	// }

	func registerWindow(window: Window) {
		gtk_widget_register_window(n_Widget, COpaquePointer(window.n_Window))
	}

	func unregisterWindow(window: Window) {
		gtk_widget_unregister_window(n_Widget, COpaquePointer(window.n_Window))
	}

	// TODO: some for gtk_cairo_should_draw_window(), gtk_cairo_transform_to_window(), use cario-swift

	var allocatedWidth: Int {
		return Int(gtk_widget_get_allocated_width(n_Widget))
	}

	var allocatedHeight: Int {
		return Int(gtk_widget_get_allocated_height(n_Widget))
	}

	// TODO: some for gtk_widget_get_allocation(), gtk_widget_set_allocation(), need GtkAllocation class

	var allocatedBaseline: Int {
		return Int(gtk_widget_get_allocated_baseline(n_Widget))
	}

	// TODO: some for gtk_widget_get_clip(), gtk_widget_set_clip(), need GtkAllocation class

  var canDefault: Bool {
  	get {
  		return gtk_widget_get_can_default(n_Widget) != 0
  	}
  	set(value) {
  		gtk_widget_set_can_default(n_Widget, value ? 1 : 0)
  	}
  }

  var canFocus: Bool {
  	get {
  		return gtk_widget_get_can_focus(n_Widget) != 0
  	}
  	set(value) {
  		gtk_widget_set_can_focus(n_Widget, value ? 1 : 0)
  	}
  }

  var hasWindow: Bool {
  	get {
  		return gtk_widget_get_has_window(n_Widget) != 0
  	}
  	set(value) {
  		gtk_widget_set_has_window(n_Widget, value ? 1 : 0)
  	}
  }

  var isSensitive: Bool {
  	return gtk_widget_is_sensitive(n_Widget) != 0
  }

  var visible: Bool {
  	get {
  		return gtk_widget_get_visible(n_Widget) != 0
  	}
  	set(value) {
  		gtk_widget_set_visible(n_Widget, value ? 1 : 0)
  	}
  }

  var isVisible: Bool {
  	return gtk_widget_is_visible(n_Widget) != 0
  }

  // TODO: some for gtk_widget_set_state_flags(), gtk_widget_unset_state_flags(), gtk_widget_get_state_flags(), need GtkStateFlags enum

  var hasDefault: Bool {
  	return gtk_widget_has_default(n_Widget) != 0
  }

  var hasFocus: Bool {
  	return gtk_widget_has_focus(n_Widget) != 0
  }

  var hasVisibleFocus: Bool {
  	return gtk_widget_has_visible_focus(n_Widget) != 0
  }

  var hasGrab: Bool {
  	return gtk_widget_has_grab(n_Widget) != 0
  }

  var isDrawable: Bool {
  	return gtk_widget_is_drawable(n_Widget) != 0
  }

  var isToplevel: Bool {
  	return gtk_widget_is_toplevel(n_Widget) != 0
  }

  var receivesDefault: Bool {
  	get {
  		return gtk_widget_get_receives_default(n_Widget) != 0
  	}
  	set(value) {
  		gtk_widget_set_receives_default(n_Widget, value ? 1 : 0)
  	}
  }

  var supportMultidevice: Bool {
  	get {
  		return gtk_widget_get_support_multidevice(n_Widget) != 0
  	}
  	set(value) {
  		gtk_widget_set_support_multidevice(n_Widget, value ? 1 : 0)
  	}
  }

  var realized: Bool {
  	get {
  		return gtk_widget_get_realized(n_Widget) != 0
  	}
  	set(value) {
  		gtk_widget_set_realized(n_Widget, value ? 1 : 0)
  	}
  }

  var mapped: Bool {
  	get {
  		return gtk_widget_get_mapped(n_Widget) != 0
  	}
  	set(value) {
  		gtk_widget_set_mapped(n_Widget, value ? 1 : 0)
  	}
  }

  // TODO: some for gtk_widget_device_is_shadowed(), gtk_widget_get_modifier_mask(), use gdk-swift

  // TODO: some for gtk_widget_insert_action_group(), use gio-swift

  var opacity: Double {
  	get {
  		return gtk_widget_get_opacity(n_Widget)
  	}
  	set(value) {
  		gtk_widget_set_opacity(n_Widget, value)
  	}
  }

  // TODO: some for gtk_widget_list_action_prefixes()

  // TODO: some for gtk_widget_get_action_group(), use gio-swift

  // TODO: some for gtk_widget_get_path(), need GtkWidgetPath class 
  	
  // TODO: some for gtk_widget_get_style_context(), need GtkStyleContext class

  func resetStyle() {
  	gtk_widget_reset_style(n_Widget)
  }

  // TODO: some for gtk_requisition_new(), gtk_requisition_copy(), gtk_requisition_free(), need GtkRequisition class

  func getPreferredHeight() -> (minimum: Int, natural: Int) {
  	let minimum: UnsafeMutablePointer<Int32> = nil
		let natural: UnsafeMutablePointer<Int32> = nil

		gtk_widget_get_preferred_height(n_Widget, minimum, natural)

		return (minimum: Int(minimum.memory), natural: Int(natural.memory))
  }

  func getPreferredWidth() -> (minimum: Int, natural: Int) {
  	let minimum: UnsafeMutablePointer<Int32> = nil
		let natural: UnsafeMutablePointer<Int32> = nil

		gtk_widget_get_preferred_width(n_Widget, minimum, natural)

		return (minimum: Int(minimum.memory), natural: Int(natural.memory))
  }

  func getPreferredHeightForWidth(width: Int) -> (minimum: Int, natural: Int) {
  	let minimum: UnsafeMutablePointer<Int32> = nil
		let natural: UnsafeMutablePointer<Int32> = nil

		gtk_widget_get_preferred_height_for_width(n_Widget, Int32(width), minimum, natural)

		return (minimum: Int(minimum.memory), natural: Int(natural.memory))
  }

  func getPreferredWidthForHeight(height: Int) -> (minimum: Int, natural: Int) {
  	let minimum: UnsafeMutablePointer<Int32> = nil
		let natural: UnsafeMutablePointer<Int32> = nil

		gtk_widget_get_preferred_width_for_height(n_Widget, Int32(height), minimum, natural)

		return (minimum: Int(minimum.memory), natural: Int(natural.memory))
  }

  func getPreferredHeightAndBaselineForWidth(width: Int) -> (height: (minimum: Int, natural: Int), baseline: (minimum: Int, natural: Int)) {
  	let minimumHeight: UnsafeMutablePointer<Int32> = nil
		let naturalHeight: UnsafeMutablePointer<Int32> = nil

		let minimumBaseline: UnsafeMutablePointer<Int32> = nil
		let naturalBaseline: UnsafeMutablePointer<Int32> = nil


		gtk_widget_get_preferred_height_and_baseline_for_width(n_Widget, Int32(width), minimumHeight, naturalHeight, minimumBaseline, naturalBaseline)

		return (height: (minimum: Int(minimumHeight.memory), natural: Int(naturalHeight.memory)), 
			baseline: (minimum: Int(minimumBaseline.memory), natural: Int(naturalBaseline.memory)))
  }

  // TODO: some for gtk_widget_get_request_mode(), need GtkSizeRequestMode class

  // TODO: some for gtk_widget_get_preferred_size(), need GtkRequisition class

  // TODO: some for gtk_distribute_natural_allocation(), need GtkRequestedSize class

  // TODO: some for gtk_widget_get_halign(), gtk_widget_set_halign(), gtk_widget_get_valign(), gtk_widget_get_valign_with_baseline(), gtk_widget_set_valign(), need GtkAlign class

  var marginStart: Int {
  	get {
  		return Int(gtk_widget_get_margin_start(n_Widget))
  	}
  	set(value) {
  		gtk_widget_set_margin_start(n_Widget, Int32(value))
  	}
  }

  var marginEnd: Int {
  	get {
  		return Int(gtk_widget_get_margin_end(n_Widget))
  	}
  	set(value) {
  		gtk_widget_set_margin_end(n_Widget, Int32(value))
  	}
  }

  var marginTop: Int {
  	get {
  		return Int(gtk_widget_get_margin_top(n_Widget))
  	}
  	set(value) {
  		gtk_widget_set_margin_top(n_Widget, Int32(value))
  	}
  }

  var marginBottom: Int {
  	get {
  		return Int(gtk_widget_get_margin_bottom(n_Widget))
  	}
  	set(value) {
  		gtk_widget_set_margin_bottom(n_Widget, Int32(value))
  	}
  }

  var hexpand: Bool {
  	get {
  		return gtk_widget_get_hexpand(n_Widget) != 0
  	}
  	set(value) {
  		gtk_widget_set_hexpand(n_Widget, value ? 1 : 0)
  	}
  }

  var hexpandSet: Bool {
  	get {
  		return gtk_widget_get_hexpand_set(n_Widget) != 0
  	}
  	set(value) {
  		gtk_widget_set_hexpand_set(n_Widget, value ? 1 : 0)
  	}
  }

  var vexpand: Bool {
  	get {
  		return gtk_widget_get_vexpand(n_Widget) != 0
  	}
  	set(value) {
  		gtk_widget_set_vexpand(n_Widget, value ? 1 : 0)
  	}
  }

  var vexpandSet: Bool {
  	get {
  		return gtk_widget_get_vexpand_set(n_Widget) != 0
  	}
  	set(value) {
  		gtk_widget_set_vexpand_set(n_Widget, value ? 1 : 0)
  	}
  }

  func queueComputeExpand() {
  	gtk_widget_queue_compute_expand(n_Widget)
  }

  func computeExpand(orientation: Orientation) -> Bool {
  	return gtk_widget_compute_expand(n_Widget, orientation.rawValue) != 0
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