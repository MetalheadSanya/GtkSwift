import CGTK

public class ApplicationWindow: Window {
	internal var n_ApplicationWindow: UnsafeMutablePointer<GtkApplicationWindow>
	
	internal init(n_ApplicationWindow: UnsafeMutablePointer<GtkApplicationWindow>) {
		self.n_ApplicationWindow = n_ApplicationWindow
		super.init(n_Window: UnsafeMutablePointer<GtkWindow>(n_ApplicationWindow))
	}

	public convenience init(application: Application) {
		self.init(n_ApplicationWindow: UnsafeMutablePointer<GtkApplicationWindow>(gtk_application_window_new(application.n_App)))

		application._addWindowToApplicationStack(self)
	}

	public var showManuBar: Bool {
		get {
			return gtk_application_window_get_show_menubar(n_ApplicationWindow) != 0
		}
		set(value) {
			gtk_application_window_set_show_menubar(n_ApplicationWindow, value ? 1 : 0)
		}
	}

	public var id: UInt {
		return UInt(gtk_application_window_get_id(n_ApplicationWindow))
	}

	// TODO: var helpOverlay, need ShortcutsWindow
}
