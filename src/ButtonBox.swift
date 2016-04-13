import CGTK

class ButtonBox: Container {
	internal var n_ButtonBox: UnsafeMutablePointer<GtkButtonBox>

	init(orientation: Orientation) {
		n_ButtonBox = unsafeBitCast(gtk_button_box_new(orientation.rawValue), to: UnsafeMutablePointer<GtkButtonBox>.self)
		super.init(n_Container: unsafeBitCast(n_ButtonBox, to: UnsafeMutablePointer<GtkContainer>.self))
	}

	internal init(n_ButtonBox: UnsafeMutablePointer<GtkButtonBox>) {
		self.n_ButtonBox = n_ButtonBox
		super.init(n_Container: unsafeBitCast(self.n_ButtonBox, to: UnsafeMutablePointer<GtkContainer>.self))
	}
}