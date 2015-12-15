import CGTK

class Widget {
	var n_Widget: UnsafeMutablePointer<GtkWidget>

	internal init(n_Widget: UnsafeMutablePointer<GtkWidget>) {
		self.n_Widget = n_Widget
	}

	func showAll() {
		gtk_widget_show_all(n_Widget)
	}

	func destroy() {
		gtk_widget_destroy(n_Widget)
	}

}
