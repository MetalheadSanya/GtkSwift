import CGTK

class ApplicationWindow: Window {
	internal var n_ApplicationWindow: UnsafeMutablePointer<GtkApplicationWindow>

	init(application: Application) {
		n_ApplicationWindow = unsafeBitCast(gtk_application_window_new(application.n_App), UnsafeMutablePointer<GtkApplicationWindow>.self)
		super.init(n_Window: unsafeBitCast(n_ApplicationWindow, UnsafeMutablePointer<GtkWindow>.self))
	}
}
