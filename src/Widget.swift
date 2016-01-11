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

	var scaleFactor: Int {
		get {
			return Int(gtk_widget_get_scale_factor(n_Widget))
		}
	}

	func activate() -> Bool {
		return gtk_widget_activate(n_Widget) != 0
	}

	var isFocus: Bool {
		return gtk_widget_is_focus(n_Widget) != 0
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

	var parent: Widget? {
		didSet {
			if let parent = parent {
				gtk_widget_set_parent(n_Widget, parent.n_Widget)
			}
		}
	}

  // todo: Fix
	// var parentWindow: Window? {
	// 	didSet {
	// 		if let parentWindow = parentWindow {
	// 			gtk_widget_set_parent_window(n_Widget, parentWindow.n_Window)
	// 		}
	// 	}
	// }

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

	var direction: TextDirection {
		get {
			let direction = gtk_widget_get_direction(n_Widget)
			switch direction {
			case GTK_TEXT_DIR_LTR:
				return .LeftToRight
			case GTK_TEXT_DIR_RTL:
				return .RightToLeft
			default: 
				return .None
			}
		}
		set(value) {
			let direction = (value == .None) ? GTK_TEXT_DIR_NONE :
					(value == .LeftToRight) ? GTK_TEXT_DIR_LTR : GTK_TEXT_DIR_RTL
			gtk_widget_set_direction(n_Widget, direction)
		}
	}

	class var defaultDirection: TextDirection {
		get {
			let direction = gtk_widget_get_default_direction()
			switch direction {
			case GTK_TEXT_DIR_LTR:
				return .LeftToRight
			case GTK_TEXT_DIR_RTL:
				return .RightToLeft
			default: 
				return .None
			}
		}
		set(value) {
			let direction = (value == .None) ? GTK_TEXT_DIR_NONE :
					(value == .LeftToRight) ? GTK_TEXT_DIR_LTR : GTK_TEXT_DIR_RTL
			gtk_widget_set_default_direction(direction)
		}
	}
}

extension Widget: Equatable { }

func ==(lhs: Widget, rhs: Widget) -> Bool {
	return lhs.n_Widget == rhs.n_Widget
}

enum TextDirection {
	case None, LeftToRight, RightToLeft
}