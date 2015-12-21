import CGTK

class Widget {
	var n_Widget: UnsafeMutablePointer<GtkWidget>

	internal init(n_Widget: UnsafeMutablePointer<GtkWidget>) {
		self.n_Widget = n_Widget
	}

	internal init?(o_Widget: UnsafeMutablePointer<GtkWidget>) {
		if o_Widget != nil {
			self.n_Widget = o_Widget
		} else {
			return nil
		}
	}

	func showAll() {
		gtk_widget_show_all(n_Widget)
	}

	func destroy() {
		gtk_widget_destroy(n_Widget)
	}

}
