import CGTK

class ButtonBox: Container {
	internal var n_ButtonBox: UnsafeMutablePointer<GtkButtonBox> = nil

	init(orientation: Orientation) {
		n_ButtonBox = unsafeBitCast(gtk_button_box_new(orientation.rawValue), UnsafeMutablePointer<GtkButtonBox>.self)
		super.init(n_Container: unsafeBitCast(n_ButtonBox, UnsafeMutablePointer<GtkContainer>.self))
	}
}