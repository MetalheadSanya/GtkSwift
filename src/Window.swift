import CGTK

class Window: Container {
	internal var n_Window: UnsafeMutablePointer<GtkWindow>

	internal init(n_Window: UnsafeMutablePointer<GtkWindow>) {
		self.n_Window = n_Window
		super.init(n_Container: unsafeBitCast(n_Window, UnsafeMutablePointer<GtkContainer>.self))
	}

	convenience init(type: WindowType) {
		self.init(n_Window: unsafeBitCast(gtk_window_new(type.n_Type), UnsafeMutablePointer<GtkWindow>.self))
	}

	var title: String? {
		get {
			return String.fromCString(gtk_window_get_title(n_Window))
		}
		set(value) {
			gtk_window_set_title(n_Window, value!)
		}
	}

	var defaultSize: Size {
		get {
			let width: UnsafeMutablePointer<Int32> = nil
			let height: UnsafeMutablePointer<Int32> = nil

			gtk_window_get_default_size(n_Window, width, height)

			return Size(width: Int(width.memory), height: Int(height.memory))
		}
		set(value) {
			gtk_window_set_default_size(n_Window, Int32(value.width), Int32(value.height))
		}
	}

	var resizable: Bool {
		get {
			return gtk_window_get_resizable(n_Window) != 0
		}

		set(value) {
			gtk_window_set_resizable(n_Window, value ? 1 : 0)
		}
	}
}

extension Window: Equatable { }

func ==(lhs: Window, rhs: Window) -> Bool {
	return lhs.n_Window == rhs.n_Window
}

enum WindowType: Int {
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
