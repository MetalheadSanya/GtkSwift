import CGTK

typealias ButtonClickedCallback = (Button, gpointer) -> Void

class Button: Container {
	internal var n_Button: UnsafeMutablePointer<GtkButton> = nil

	internal init(n_Button: UnsafeMutablePointer<GtkButton>) {
		self.n_Button = n_Button
		super.init(n_Container: unsafeBitCast(self.n_Button, UnsafeMutablePointer<GtkContainer>.self))
	}

	convenience init(label: String) {
		self.init(n_Button: unsafeBitCast(gtk_button_new_with_label(label), UnsafeMutablePointer<GtkButton>.self))

		ButtonNotificationCenter.sharedInstance.register(self, fromNativeButton: n_Button)
	}

	var clickedCallbacks = [ButtonClickedCallback]()
}



// extension Button: Equatable { }

func ==(lhs: Button, rhs: Button) -> Bool {
	return lhs.n_Button == rhs.n_Button
}

private class ButtonNotificationCenter {
	static let sharedInstance = ButtonNotificationCenter()

	private var registers = [(button: Button, gtkButton: UnsafeMutablePointer<GtkButton>)]()

	func register(obj: Button, fromNativeButton button: UnsafeMutablePointer<GtkButton>) {
		registers.append((obj, button))

		g_signal_connect (obj.n_Button, "clicked", unsafeBitCast(clicked, UnsafePointer<Void>.self), nil)
	}

	func unregister(obj: Button) {
		registers = registers.filter { $0.button == obj }
	}

	private let clicked: @convention(c) (button: UnsafeMutablePointer<GtkButton>,
	                                     user_data: gpointer) -> Void = {
		ButtonNotificationCenter.sharedInstance.clickedFromButton($0, userData: $1)
	}

	func clickedFromButton(button: UnsafeMutablePointer<GtkButton>, userData: gpointer) {
		let forPerform = registers.filter { $0.gtkButton == button }

		for (obj, _) in forPerform {
			_ = obj.clickedCallbacks.map { $0(obj, userData) }
		}
	}
}