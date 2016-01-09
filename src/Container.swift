import CGTK

class Container: Widget {

	internal var n_Container: UnsafeMutablePointer<GtkContainer>

	override class var n_Type: UInt {
		return gtk_container_get_type()
	}

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
	func addWidget(widget: Widget) {
		gtk_container_add(n_Container, widget.n_Widget)
	}

	func remove(widget: Widget) {
		gtk_container_remove(n_Container, widget.n_Widget)
	}

	func getChildren() -> [Widget] {
		let preArray = Array<UnsafeMutablePointer<GtkWidget>>(gList: gtk_container_get_children(n_Container))

		return preArray.map { Widget.buildRightWidget($0) }
	}
}