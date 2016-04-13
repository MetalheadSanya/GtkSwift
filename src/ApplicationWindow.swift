import CGTK

class ApplicationWindow: Window {
	internal var n_ApplicationWindow: UnsafeMutablePointer<GtkApplicationWindow>

	init(application: Application) {
		n_ApplicationWindow = unsafeBitCast(gtk_application_window_new(application.n_App), to: UnsafeMutablePointer<GtkApplicationWindow>.self)
		super.init(n_Window: unsafeBitCast(n_ApplicationWindow, to: UnsafeMutablePointer<GtkWindow>.self))

		application._addWindowToApplicationStack(self)
	}

	var showManuBar: Bool {
		get {
			return gtk_application_window_get_show_menubar(n_ApplicationWindow) != 0
		}
		set(value) {
			gtk_application_window_set_show_menubar(n_ApplicationWindow, value ? 1 : 0)
		}
	}

	var id: UInt {
		return UInt(gtk_application_window_get_id(n_ApplicationWindow))
	}

	// TODO: var helpOverlay, need ShortcutsWindow
}
