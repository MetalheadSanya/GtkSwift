import CGTK

class Container: Widget {
	internal var n_Container: UnsafeMutablePointer<GtkContainer>

	init(n_Container: UnsafeMutablePointer<GtkContainer>) {
		self.n_Container = n_Container
		super.init(n_Widget: unsafeBitCast(n_Container, UnsafeMutablePointer<GtkWidget>.self))
	}

	var borderWidth: Int {
		get {
			return Int(gtk_container_get_border_width(n_Container))
		}
		set(value) {
			gtk_container_set_border_width(n_Container, UInt32(value))
		}
	}
}

extension Container {
	func add(widget: Widget) {
		gtk_container_add(n_Container, widget.n_Widget)
	}

	func remove(widget: Widget) {
		gtk_container_remove(n_Container, widget.n_Widget)
	}
}