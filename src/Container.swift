import CGTK

class Container: Widget {
	internal var n_Container: UnsafeMutablePointer<GtkContainer>

	init(n_Container: UnsafeMutablePointer<GtkContainer>) {
		self.n_Container = n_Container
		super.init(n_Widget: unsafeBitCast(n_Container, UnsafeMutablePointer<GtkWidget>.self))
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