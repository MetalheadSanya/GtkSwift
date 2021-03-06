import CGTK
import gobjectswift

public typealias WidgetAccelClosuresChangedCallback = (Widget) -> Void
// TODO: some for “button-press-event”, “button-release-event”, need gdk-swift
// TODO: some for “can-activate-accel”, need understand this
// TODO: some for “child-notify”, need understand this
public typealias WidgetCompositedChangedCallback = (Widget) -> Void
// TODO: some for “configure-event”, “damage-event”, “delete-event”, need gdk-swift
public typealias WidgetDestroyCallback = (Widget) -> Void
// TODO: some for “destroy-event”, need gdk-swift
public typealias WidgetDirectionChangedCallback = (Widget, TextDirection) -> Void
/* TODO: some for “drag-begin”, “drag-data-delete”, “drag-data-get”, “drag-data-received”, “drag-drop”, “drag-end”,
         “drag-failed”, “drag-leave”, “drag-motion”, need gdk-swift */
// TODO: some for “draw”, need cario-swift
// TODO: some for “enter-notify-event”, “event”, “event-after”, need gdk-swift
public typealias WidgetFocusCallback = (Widget, DirectionType) -> Bool
// TODO: some for “focus-in-event”, “focus-out-event”, “grab-broken-event”, need gdk-swift
public typealias WidgetGrabFocusCallback = (Widget) -> Void
public typealias WidgetGrabNotifyCallback = (Widget, Bool) -> Void
public typealias WidgetHideCallback = (Widget) -> Void
// TODO: need some ideas about 'The “hierarchy-changed” signal'
// TODO: some for “key-press-event”, “key-release-event”, need gdk-swift
public typealias WidgetKeyboardNavigationFailedCallback = (Widget, DirectionType) -> Bool
// TODO: some for “leave-notify-event”, need gdk-swift
public typealias WidgetMapCallback = (Widget) -> Void
// TODO: some for "map-event", need gdk-swift
public typealias WidgetMnemonicActivateCallback = (Widget, Bool) -> Bool
// TODO: some for “motion-notify-event”, need gdk-swift
public typealias WidgetMoveFocusCallback = (Widget, DirectionType) -> Bool
public typealias WidgetPopupMenuCallback = (Widget) -> Bool


public class Widget: Object {

	class var n_Type: UInt {
		return 0
	}

	var n_Widget: UnsafeMutablePointer<GtkWidget>

	internal init(n_Widget: UnsafeMutablePointer<GtkWidget>) {
		self.n_Widget = n_Widget
		super.init(n_Object: unsafeBitCast(n_Widget, to: UnsafeMutablePointer<GObject>.self))
	}

	internal init?(o_Widget: UnsafeMutablePointer<GtkWidget>?) {
		guard o_Widget != nil else {
			return nil
		}
		self.n_Widget = o_Widget!
		super.init(n_Object: unsafeBitCast(o_Widget!, to: UnsafeMutablePointer<GObject>.self))

	}
	
	public typealias WidgetAccelClosuresChangedNative = @convention(c)(UnsafeMutablePointer<GtkWidget>, gpointer) -> Void
	
	public lazy var accelClosuresChangedSignal: Signal<WidgetAccelClosuresChangedCallback, Widget, WidgetAccelClosuresChangedNative>
			= Signal(obj: self, signal: "accel-closures-changed", c_handler: {
				(_, user_data) in
				let data = unsafeBitCast(user_data, to: SignalData<Widget, WidgetAccelClosuresChangedCallback>.self)

				let widget = data.obj
				let action = data.function

				action(widget)
			})

	public typealias WidgetCompositesChangedNative = @convention(c)(UnsafeMutablePointer<GtkWidget>, gpointer) -> Void

	public lazy var compositesChangedSignal: Signal<WidgetCompositedChangedCallback, Widget, WidgetCompositesChangedNative>
			= Signal(obj: self, signal: "composited-changed", c_handler: {
				(_, user_data) in
				let data = unsafeBitCast(user_data, to: SignalData<Widget, WidgetAccelClosuresChangedCallback>.self)

				let widget = data.obj
				let action = data.function

				action(widget)
			})
			
	public typealias WidgetDestroyNative = @convention(c)(UnsafeMutablePointer<GtkWidget>, gpointer) -> Void

	public lazy var destoySignal: Signal<WidgetDestroyCallback, Widget, WidgetDestroyNative> = Signal(obj: self, signal: "destroy",
			c_handler: {
				(_, user_data) in
				let data = unsafeBitCast(user_data, to: SignalData<Widget, WidgetDestroyCallback>.self)

				let widget = data.obj
				let action = data.function

				action(widget)
			})
			
	public typealias WidgetDirectionChangedNative = @convention(c)(UnsafeMutablePointer<GtkWidget>, GtkTextDirection, gpointer) -> Void

	public lazy var directionChangedSignal: Signal<WidgetDirectionChangedCallback, Widget, WidgetDirectionChangedNative>
			= Signal(obj: self, signal: "direction-changed", c_handler: {
				(_, c_text_direction, user_data) in
				let data = unsafeBitCast(user_data, to: SignalData<Widget, WidgetDirectionChangedCallback>.self)

				let widget = data.obj
				let action = data.function

				action(widget, TextDirection(rawValue: c_text_direction)!)
			})
			
	public typealias WidgetFocusNative = @convention(c)(UnsafeMutablePointer<GtkWidget>, GtkDirectionType, gpointer) -> Bool
	
	public lazy var focusSignal: Signal<WidgetFocusCallback, Widget, WidgetFocusNative>
			= Signal(obj: self, signal: "focus", c_handler: {
				(_, c_direction_type, user_data) in
				let data = unsafeBitCast(user_data, to: SignalData<Widget, WidgetFocusCallback>.self)

				let widget = data.obj
				let action = data.function

				// TODO: replace on optional
				return action(widget, DirectionType(rawValue: c_direction_type))
			})
	
	public typealias WidgetGrabFocusNative = @convention(c)(UnsafeMutablePointer<GtkWidget>, gpointer) -> Void
	
	public lazy var grabFocusSignal: Signal<WidgetGrabFocusCallback, Widget, WidgetGrabFocusNative> = Signal(obj: self, signal: "grab-focus",
			c_handler: {
				(_, user_data) in
				let data = unsafeBitCast(user_data, to: SignalData<Widget, WidgetGrabFocusCallback>.self)

				let widget = data.obj
				let action = data.function

				action(widget)
			})
	
	public typealias WidgetGrabNotifyNative = @convention(c)(UnsafeMutablePointer<GtkWidget>, Int32, gpointer) -> Void
	
	public lazy var grabNotifySignal: Signal<WidgetGrabNotifyCallback, Widget, WidgetGrabNotifyNative>
			= Signal(obj: self, signal: "grab-notify", c_handler: {
				(_, c_was_grabbed, user_data) in
				let data = unsafeBitCast(user_data, to: SignalData<Widget, WidgetGrabNotifyCallback>.self)

				let widget = data.obj
				let action = data.function

				// TODO: replace on optional
				action(widget, c_was_grabbed != 0)
			})
			
	public typealias WidgetHideNative = @convention(c)(UnsafeMutablePointer<GtkWidget>, gpointer) -> Void
	
	public lazy var hideSignal: Signal<WidgetHideCallback, Widget, WidgetHideNative> = Signal(obj: self, signal: "hide",
			c_handler: {
				(_, user_data) in
				let data = unsafeBitCast(user_data, to: SignalData<Widget, WidgetHideCallback>.self)

				let widget = data.obj
				let action = data.function

				action(widget)
			})
			
	public typealias WidgetKeyboardNavigationFailedNative = @convention(c)(UnsafeMutablePointer<GtkWidget>, GtkDirectionType, gpointer) -> Bool

	public lazy var keyboardNavigationFailedSignal: Signal<WidgetKeyboardNavigationFailedCallback, Widget, WidgetKeyboardNavigationFailedNative>
			= Signal(obj: self, signal: "keynav-failed", c_handler: {
				(_, c_direction_type, user_data) in
				let data = unsafeBitCast(user_data, to: SignalData<Widget, WidgetKeyboardNavigationFailedCallback>.self)

				let widget = data.obj
				let action = data.function

				// TODO: replace on optional
				return action(widget, DirectionType(rawValue: c_direction_type))
			})
			
	public typealias WidgetMapNative = @convention(c)(UnsafeMutablePointer<GtkWidget>, gpointer) -> Void

	public lazy var mapSignal: Signal<WidgetMapCallback, Widget, WidgetMapNative> = Signal(obj: self, signal: "map",
			c_handler: {
				(_, user_data) in
				let data = unsafeBitCast(user_data, to: SignalData<Widget, WidgetHideCallback>.self)

				let widget = data.obj
				let action = data.function

				action(widget)
			})
			
	public typealias WidgetMnemonicActivateNative = @convention(c)(UnsafeMutablePointer<GtkWidget>, Int32, gpointer) -> Int32
	
	public lazy var mnemonicActivateSignal: Signal<WidgetMnemonicActivateCallback, Widget, WidgetMnemonicActivateNative>
			= Signal(obj: self, signal: "mnemonic-activate", c_handler: {
				(_, arg1, user_data) -> Int32 in
				let data = unsafeBitCast(user_data, to: SignalData<Widget, WidgetMnemonicActivateCallback>.self)

				let widget = data.obj
				let action = data.function

				return action(widget, arg1 != 0) ? 1 : 0
			})
			
	public typealias WidgetMoveFocusNative = @convention(c)(UnsafeMutablePointer<GtkWidget>, GtkDirectionType, gpointer) -> Int32
	
	public lazy var moveFocusSignal: Signal<WidgetMoveFocusCallback, Widget, WidgetMoveFocusNative>
			= Signal(obj: self, signal: "move-focus", c_handler: {
				(_, c_direction_type, user_data) in
				let data = unsafeBitCast(user_data, to: SignalData<Widget, WidgetMoveFocusCallback>.self)

				let widget = data.obj
				let action = data.function

				// TODO: replace on optional
				return action(widget, DirectionType(rawValue: c_direction_type)) ? 1 : 0
			})
	
	public typealias WidgetPopupMenuNative = @convention(c)(UnsafeMutablePointer<GtkWidget>, gpointer) -> Int32
	
	public lazy var popupMenuSignal: Signal<WidgetPopupMenuCallback, Widget, WidgetPopupMenuNative>
			= Signal(obj: self, signal: "popup-menu", c_handler: {
					(_, user_data) -> Int32 in
					let data = unsafeBitCast(user_data, to: SignalData<Widget, WidgetPopupMenuCallback>.self)

					let widget = data.obj
					let action = data.function

					return action(widget) ? 1 : 0
				})

	public func destroy() {
		gtk_widget_destroy(n_Widget)
	}

	// TODO: some for gtk_widget_in_destruction(), gtk_widget_destroyed()

	public func show() {
		gtk_widget_show(n_Widget)
	}

	public func showNow() {
		gtk_widget_show_now(n_Widget)
	}

	public func hide() {
		gtk_widget_hide(n_Widget)
	}

	public func showAll() {
		gtk_widget_show_all(n_Widget)
	}

	///This function is only for use in widget implementations. Causes a widget to be mapped if it isn’t already.
	public func map() {
		gtk_widget_map(n_Widget)
	}

	///This function is only for use in widget implementations. Causes a widget to be unmapped if it isn’t already.
	public func unmap() {
		gtk_widget_map(n_Widget)
	}

	public func realize() {
		gtk_widget_realize(n_Widget)
	}

	public func unrealize() {
		gtk_widget_realize(n_Widget)
	}

	// TODO: use cario-swift
	// func draw(cr: UnsafeMutablePointer<cario_t>) {
	// 	gtk_widget_draw(n_Widget, cr)
	// }

	/// Equivalent to calling gtk_widget_queue_draw_area() for the entire area of a widget.
	public func queueDraw() {
		gtk_widget_queue_draw(n_Widget)
	}

	/// This function is only for use in widget implementations. Flags a widget to have its size renegotiated;
	/// should be called when a widget for some reason has a new size request. For example, when you change the text in a
	/// GtkLabel, GtkLabel queues a resize to ensure there’s enough space for the new text.
	public func queueResize() {
		gtk_widget_queue_resize(n_Widget)
	}

	/// This function works like gtk_widget_queue_resize(), except that the widget is not invalidated.
	public func queueResizeNoRedraw() {
		gtk_widget_queue_resize_no_redraw(n_Widget)
	}

	// TODO: use gdk-swift
	// func getFrameClock() -> UnsafeMutablePointer<GdkFrameClock> {
	// 	return gtk_widget_get_frame_clock(n_Widget)
	// }

	public var scaleFactor: Int {
		return Int(gtk_widget_get_scale_factor(n_Widget))
	}

	// TODO: some for gtk_widget_get_frame_clock(), gtk_widget_get_frame_clock()

	// TODO: some for gtk_widget_size_allocate(), gtk_widget_size_allocate_with_baseline(), need GtkAllocation

	public func sizeAllocate(_ rect: Rectangle) {
		gtk_widget_size_allocate(n_Widget, rect.gdkRectangle)
	}

	public func sizeAllocateWithBaseline(rect: Rectangle, baseline: Int) {

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

	public func activate() -> Bool {
		return gtk_widget_activate(n_Widget) != 0
	}

	// TODO: use gdk-swift 
	// func intersect(area: UnsafeMutablePointer<GdkRectangle>, inout var intersection: UnsafeMutablePointer<GdkRectangle>) -> Bool {
	// 	 return gtk_widget_intersect(n_Widget, area, intersection) != 0
	// }

	public var isFocus: Bool {
		return gtk_widget_is_focus(n_Widget) != 0
	}

	public func grabFocus() {
		gtk_widget_grab_focus(n_Widget)
	}

	public func grabDefault() {
		gtk_widget_grab_default(n_Widget)
	}

	public var name: String {
		get {
			return String(gtk_widget_get_name(n_Widget))
		}
		set {
			gtk_widget_set_name(n_Widget, newValue)
		}
	}

	public var sensitive: Bool {
		get {
			return gtk_widget_get_sensitive(n_Widget) != 0
		}
		set {
			gtk_widget_set_sensitive(n_Widget, newValue ? 1 : 0)
		}
	}

	/**
	This function is useful only when implementing subclasses of Container.
	Sets the container as the parent of widget, and takes care of some details such as updating the state and style of
	the child to reflect its new location.
	Remove parent can be called by implementations of the remove method on Container, to dissociate a child from
	the container.
	*/
	public var parent: Widget? {
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

	/* TODO: some for gtk_widget_set_device_events(), gtk_widget_det_device_events(), gtk_widget_add_device_events(),
	         need gdk-swift */

	// TODO: some for gtk_widget_set_device_enabled(), gtk_widget_get_device_enabled(), user gdk-swift

	public func getToplevel() -> Widget? {
		var widget = self

		while widget.parent != nil {
			widget = widget.parent!
		}

		return widget
	}

	public func getAncestor<T:Widget>() -> T? {
		var widget = self

		while !(widget is T) {
			guard let parent = widget.parent else {
				return nil
			}
			widget = parent
		}

		return widget as? T
	}

	// TODO: some for gtk_widget_get_visual(), gtk_widget_set_visual(), user gdk-swift

	public func isAncestorFor(_ ancestor: Widget) -> Bool {
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

	public func hideOnDelete() -> Bool {
		return gtk_widget_hide_on_delete(n_Widget) != 0
	}

	public var direction: TextDirection {
		get {
			let direction = gtk_widget_get_direction(n_Widget)
			return TextDirection(rawValue: direction)!
		}
		set {
			gtk_widget_set_direction(n_Widget, newValue.rawValue)
		}
	}

	public class var defaultDirection: TextDirection {
		get {
			let direction = gtk_widget_get_default_direction()
			return TextDirection(rawValue: direction)!
		}
		set(value) {
			gtk_widget_set_default_direction(value.rawValue)
		}
	}

	// TODO: some for gtk_widget_shape_combine_region(), gtk_widget_input_shape_combine_region(), need cario-swift

	/* TODO: some for gtk_widget_create_pango_context(), gtk_widget_get_pango_context(), gtk_widget_create_pango_layout(),
	         need pango-swift */

	// TODO: some for gtk_widget_queue_draw_area(), need Rectangle struct

	// TODO: some for gtk_widget_queue_draw_region(), need cario-swift

	public var appPrintable: Bool {
		get {
			return gtk_widget_get_app_paintable(n_Widget) != 0
		}
		set {
			gtk_widget_set_app_paintable(n_Widget, newValue ? 1 : 0)
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

	/* TODO: some for gtk_widget_class_install_style_property(), gtk_widget_class_install_style_property_parser(),
	         gtk_widget_class_find_style_property(), gtk_widget_class_list_style_properties(),
	         after new idea about properties */

	// TODO: some for gtk_widget_send_expose(), gtk_widget_send_focus_change(), use gdk-swift

	/* TODO: some for gtk_widget_style_get(), gtk_widget_style_get_property(), gtk_widget_style_get_valist(),
	         after new idea about properties and styles */

	/* TODO: some for gtk_widget_class_set_accessible_type(), gtk_widget_class_set_accessible_role(),
	   gtk_widget_get_accessible(), use atk-swift */

	public func childFocus(direcrion: DirectionType) -> Bool {
		return gtk_widget_child_focus(n_Widget, direcrion.rawValue) != 0
	}

	// TODO: some for gtk_widget_child_notify(), gtk_widget_freeze_child_notify(), need signals

	public var childVisible: Bool {
		get {
			return gtk_widget_get_child_visible(n_Widget) != 0
		}
		set {
			gtk_widget_set_child_visible(n_Widget, newValue ? 1 : 0)
		}
	}

	// TODO: some for gtk_widget_get_settings(), need GtkSettings class

	// TODO: some for gtk_widget_get_clipboard(), use gdk-swift

	// TODO: some for gtk_widget_get_display(), use gdk-swift

	// TODO: some for gtk_widget_get_screen(), gtk_widget_has_screen(), use gdk-swift

	public var sizeRequest: Size {
		get {
			let width = UnsafeMutablePointer<Int32>(nil)
			let height = UnsafeMutablePointer<Int32>(nil)

			gtk_widget_get_size_request(n_Widget, width, height)

			return Size(width: Int(width!.pointee), height: Int(height!.pointee))
		}
		set {
			gtk_widget_set_size_request(n_Widget, Int32(newValue.width),
			                            Int32(newValue.height))
		}
	}

	// TODO: some for gtk_widget_thaw_child_notify(), need signals

	public var noShowAll: Bool {
		get {
			return gtk_widget_get_no_show_all(n_Widget) != 0
		}
		set {
			gtk_widget_set_no_show_all(n_Widget, newValue ? 1 : 0)
		}
	}

	/* TODO: some for gtk_widget_list_mnemonic_labels(), gtk_widget_add_mnemonic_label(),
	         gtk_widget_remove_mnemonic_label(), need understand this */

	public var composited: Bool {
		get {
			return gtk_widget_is_composited(n_Widget) != 0
		}
	}

	public func errorBell() {
		gtk_widget_error_bell(n_Widget)
	}

	public func keynavFailed(_ direction: DirectionType) -> Bool {
		return gtk_widget_keynav_failed(n_Widget, direction.rawValue) != 0
	}

	public var tooltipMarkup: String {
		get {
			return String(gtk_widget_get_tooltip_markup(n_Widget))
		}
		set {
			gtk_widget_set_tooltip_markup(n_Widget, newValue)
		}
	}

	public var tooltipText: String {
		get {
			return String(gtk_widget_get_tooltip_text(n_Widget))
		}
		set {
			gtk_widget_set_tooltip_text(n_Widget, newValue)
		}
	}

	// TODO: some for gtk_widget_get_tooltip_window(), gtk_widget_set_tooltip_window(), need get defailt tooltip_window

	public var hasTooltip: Bool {
		get {
			return gtk_widget_get_has_tooltip(n_Widget) != 0
		}
		set {
			gtk_widget_set_has_tooltip(n_Widget, newValue ? 1 : 0)
		}
	}

	public func triggerTooltipQuery() {
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

	public func registerWindow(_ window: Window) {
		gtk_widget_register_window(n_Widget, OpaquePointer(window.n_Window))
	}

	public func unregisterWindow(_ window: Window) {
		gtk_widget_unregister_window(n_Widget, OpaquePointer(window.n_Window))
	}

	// TODO: some for gtk_cairo_should_draw_window(), gtk_cairo_transform_to_window(), use cario-swift

	public var allocatedWidth: Int {
		return Int(gtk_widget_get_allocated_width(n_Widget))
	}

	public var allocatedHeight: Int {
		return Int(gtk_widget_get_allocated_height(n_Widget))
	}

	// TODO: some for gtk_widget_get_allocation(), gtk_widget_set_allocation(), need GtkAllocation class

	public var allocatedBaseline: Int {
		return Int(gtk_widget_get_allocated_baseline(n_Widget))
	}

	// TODO: some for gtk_widget_get_clip(), gtk_widget_set_clip(), need GtkAllocation class

	public var canDefault: Bool {
		get {
			return gtk_widget_get_can_default(n_Widget) != 0
		}
		set {
			gtk_widget_set_can_default(n_Widget, newValue ? 1 : 0)
		}
	}

	public var canFocus: Bool {
		get {
			return gtk_widget_get_can_focus(n_Widget) != 0
		}
		set {
			gtk_widget_set_can_focus(n_Widget, newValue ? 1 : 0)
		}
	}

	public var hasWindow: Bool {
		get {
			return gtk_widget_get_has_window(n_Widget) != 0
		}
		set {
			gtk_widget_set_has_window(n_Widget, newValue ? 1 : 0)
		}
	}

	public var isSensitive: Bool {
		return gtk_widget_is_sensitive(n_Widget) != 0
	}

	public var visible: Bool {
		get {
			return gtk_widget_get_visible(n_Widget) != 0
		}
		set {
			gtk_widget_set_visible(n_Widget, newValue ? 1 : 0)
		}
	}

	public var isVisible: Bool {
		return gtk_widget_is_visible(n_Widget) != 0
	}

	/* TODO: some for gtk_widget_set_state_flags(), gtk_widget_unset_state_flags(), gtk_widget_get_state_flags(),
	         need GtkStateFlags enum */

	public var hasDefault: Bool {
		return gtk_widget_has_default(n_Widget) != 0
	}

	public var hasFocus: Bool {
		return gtk_widget_has_focus(n_Widget) != 0
	}

	public var hasVisibleFocus: Bool {
		return gtk_widget_has_visible_focus(n_Widget) != 0
	}

	public var hasGrab: Bool {
		return gtk_widget_has_grab(n_Widget) != 0
	}

	public var isDrawable: Bool {
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

	public var supportMultidevice: Bool {
		get {
			return gtk_widget_get_support_multidevice(n_Widget) != 0
		}
		set {
			gtk_widget_set_support_multidevice(n_Widget, newValue ? 1 : 0)
		}
	}

	public var realized: Bool {
		get {
			return gtk_widget_get_realized(n_Widget) != 0
		}
		set {
			gtk_widget_set_realized(n_Widget, newValue ? 1 : 0)
		}
	}

	public var mapped: Bool {
		get {
			return gtk_widget_get_mapped(n_Widget) != 0
		}
		set {
			gtk_widget_set_mapped(n_Widget, newValue ? 1 : 0)
		}
	}

	// TODO: some for gtk_widget_device_is_shadowed(), gtk_widget_get_modifier_mask(), use gdk-swift

	// TODO: some for gtk_widget_insert_action_group(), use gio-swift

	public var opacity: Double {
		get {
			return gtk_widget_get_opacity(n_Widget)
		}
		set {
			gtk_widget_set_opacity(n_Widget, newValue)
		}
	}

	// TODO: some for gtk_widget_list_action_prefixes()

	// TODO: some for gtk_widget_get_action_group(), use gio-swift

	// TODO: some for gtk_widget_get_path(), need GtkWidgetPath class

	// TODO: some for gtk_widget_get_style_context(), need GtkStyleContext class

	public func resetStyle() {
		gtk_widget_reset_style(n_Widget)
	}

	// TODO: some for gtk_requisition_new(), gtk_requisition_copy(), gtk_requisition_free(), need GtkRequisition class

	public func getPreferredHeight() -> (minimum:Int, natural:Int) {
		let minimum = UnsafeMutablePointer<Int32>(nil)
		let natural = UnsafeMutablePointer<Int32>(nil)

		gtk_widget_get_preferred_height(n_Widget, minimum, natural)

		return (minimum: Int(minimum!.pointee), natural: Int(natural!.pointee))
	}

	public func getPreferredWidth() -> (minimum:Int, natural:Int) {
		let minimum = UnsafeMutablePointer<Int32>(nil)
		let natural = UnsafeMutablePointer<Int32>(nil)

		gtk_widget_get_preferred_width(n_Widget, minimum, natural)

		return (minimum: Int(minimum!.pointee), natural: Int(natural!.pointee))
	}

	public func getPreferredHeightForWidth(_ width: Int) -> (minimum:Int, natural:Int) {
		let minimum = UnsafeMutablePointer<Int32>(nil)
		let natural = UnsafeMutablePointer<Int32>(nil)

		gtk_widget_get_preferred_height_for_width(n_Widget, Int32(width), minimum, natural)

		return (minimum: Int(minimum!.pointee), natural: Int(natural!.pointee))
	}

	public func getPreferredWidthForHeight(_ height: Int) -> (minimum:Int, natural:Int) {
		let minimum = UnsafeMutablePointer<Int32>(nil)
		let natural = UnsafeMutablePointer<Int32>(nil)

		gtk_widget_get_preferred_width_for_height(n_Widget, Int32(height), minimum, natural)

		return (minimum: Int(minimum!.pointee), natural: Int(natural!.pointee))
	}

	public func getPreferredHeightAndBaselineForWidth(_ width: Int) -> (height:(minimum:Int, natural:Int),
	                                                           baseline:(minimum:Int, natural:Int)) {
		let minimumHeight = UnsafeMutablePointer<Int32>(nil)
		let naturalHeight = UnsafeMutablePointer<Int32>(nil)

		let minimumBaseline = UnsafeMutablePointer<Int32>(nil)
		let naturalBaseline = UnsafeMutablePointer<Int32>(nil)


		gtk_widget_get_preferred_height_and_baseline_for_width(n_Widget, Int32(width), minimumHeight, naturalHeight,
				minimumBaseline, naturalBaseline)

		return (height: (minimum: Int(minimumHeight!.pointee), natural: Int(naturalHeight!.pointee)),
				baseline: (minimum: Int(minimumBaseline!.pointee), natural: Int(naturalBaseline!.pointee)))
	}

	// TODO: some for gtk_widget_get_request_mode(), need GtkSizeRequestMode class

	// TODO: some for gtk_widget_get_preferred_size(), need GtkRequisition class

	// TODO: some for gtk_distribute_natural_allocation(), need GtkRequestedSize class

	/* TODO: some for gtk_widget_get_halign(), gtk_widget_set_halign(), gtk_widget_get_valign(),
					 gtk_widget_get_valign_with_baseline(), gtk_widget_set_valign(), need GtkAlign class */

	public var marginStart: Int {
		get {
			return Int(gtk_widget_get_margin_start(n_Widget))
		}
		set {
			gtk_widget_set_margin_start(n_Widget, gint(newValue))
		}
	}

	public var marginEnd: Int {
		get {
			return Int(gtk_widget_get_margin_end(n_Widget))
		}
		set {
			gtk_widget_set_margin_end(n_Widget, gint(newValue))
		}
	}

	public var marginTop: Int {
		get {
			return Int(gtk_widget_get_margin_top(n_Widget))
		}
		set {
			gtk_widget_set_margin_top(n_Widget, gint(newValue))
		}
	}

	public var marginBottom: Int {
		get {
			return Int(gtk_widget_get_margin_bottom(n_Widget))
		}
		set {
			gtk_widget_set_margin_bottom(n_Widget, gint(newValue))
		}
	}

	public var hexpand: Bool {
		get {
			return gtk_widget_get_hexpand(n_Widget) != 0
		}
		set {
			gtk_widget_set_hexpand(n_Widget, newValue ? 1 : 0)
		}
	}

	public var hexpandSet: Bool {
		get {
			return gtk_widget_get_hexpand_set(n_Widget) != 0
		}
		set {
			gtk_widget_set_hexpand_set(n_Widget, newValue ? 1 : 0)
		}
	}

	public var vexpand: Bool {
		get {
			return gtk_widget_get_vexpand(n_Widget) != 0
		}
		set {
			gtk_widget_set_vexpand(n_Widget, newValue ? 1 : 0)
		}
	}

	public var vexpandSet: Bool {
		get {
			return gtk_widget_get_vexpand_set(n_Widget) != 0
		}
		set {
			gtk_widget_set_vexpand_set(n_Widget, newValue ? 1 : 0)
		}
	}

	public func queueComputeExpand() {
		gtk_widget_queue_compute_expand(n_Widget)
	}

	public func computeExpand(orientation: Orientation) -> Bool {
		return gtk_widget_compute_expand(n_Widget, orientation.rawValue) != 0
	}
}

extension Widget: Equatable { }

public func ==(lhs: Widget, rhs: Widget) -> Bool {
	return lhs.n_Widget == rhs.n_Widget
}