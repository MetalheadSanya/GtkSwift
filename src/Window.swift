import CGTK

public class Window: Bin {

	internal var n_Window: UnsafeMutablePointer<GtkWindow>

	override class var n_Type: UInt {
		return gtk_window_get_type()
	}

	internal init(n_Window: UnsafeMutablePointer<GtkWindow>) {
		self.n_Window = n_Window
		super.init(n_Bin: unsafeBitCast(n_Window, to: UnsafeMutablePointer<GtkBin>.self))
	}

	internal init?(o_Window: UnsafeMutablePointer<GtkWindow>?) {
		if o_Window != nil {
			self.n_Window = o_Window!
			super.init(n_Bin: unsafeBitCast(n_Window, to: UnsafeMutablePointer <GtkBin>.self))
		} else {
			return nil
		}
	}

	convenience init(type: WindowType) {
		self.init(n_Window: unsafeBitCast(gtk_window_new(type.n_Type), to: UnsafeMutablePointer<GtkWindow>.self))
	}

	public var title: String? {
		get {
			return String(cString: gtk_window_get_title(n_Window))
		}
		set {
			gtk_window_set_title(n_Window, newValue)
		}
	}

	public var defaultSize: Size {
		get {
			var width: gint = 0
			var height: gint = 0

			gtk_window_get_default_size(n_Window, &width, &height)

			return Size(width: Int(width), height: Int(height))
		}
		set {
			gtk_window_set_default_size(n_Window, gint(newValue.width), gint(newValue.height))
		}
	}

	public var resizable: Bool {
		get {
			return gtk_window_get_resizable(n_Window) != 0
		}
		set {
			gtk_window_set_resizable(n_Window, newValue ? 1 : 0)
		}
	}

	public var transientFor: Window? {
		get {
			return Window(o_Window: gtk_window_get_transient_for(n_Window))
		}
		set {
			gtk_window_set_transient_for(n_Window, newValue?.n_Window)
		}
	}

	public var modal: Bool {
		get {
			return gtk_window_get_modal(n_Window) != 0
		}
		set {
			gtk_window_set_modal(n_Window, newValue ? 1 : 0)
		}
	}

	public var destroyWithParent: Bool {
		get {
			return gtk_window_get_destroy_with_parent(n_Window) != 0
		}
		set {
			gtk_window_set_destroy_with_parent(n_Window, newValue ? 1 : 0)
		}
	}

	public func fullscreen() {
		gtk_window_fullscreen(n_Window)
	}

	public func unfullscreen() {
		gtk_window_unfullscreen(n_Window)
	}
}

// extension Window: Equatable { }

func ==(lhs: Window, rhs: Window) -> Bool {
	return lhs.n_Window == rhs.n_Window
}

public enum WindowType: Int {
	case TopLevel
	case Popup

	internal var n_Type: GtkWindowType {
		switch self {
			case .TopLevel:
				return GTK_WINDOW_TOPLEVEL
			case .Popup:
				return GTK_WINDOW_POPUP
		}
	}
}