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

		ButtonNotificationCenter.sharedInstance.registerForClicked(self, fromNativeButton: n_Button)

		g_signal_connect (n_Button, "clicked", unsafeBitCast(clicked, UnsafePointer<Void>.self), nil)
	}

	private let clicked: @convention(c) (button: UnsafeMutablePointer<GtkButton>,
                               user_data: gpointer) -> Void = {
		ButtonNotificationCenter.sharedInstance.clickedFromButton($0, userData: $1)
	}


	var clickedCallbacks = [ButtonClickedCallback]()

	override func destroy() {
		print("This is a button")
		super.destroy()
	}

}



// extension Button: Equatable { }

func ==(lhs: Button, rhs: Button) -> Bool {
	return lhs.n_Button == rhs.n_Button
}

private class ButtonNotificationCenter {
	static let sharedInstance = ButtonNotificationCenter()

	private var registers = [(button: Button, gtkButton: UnsafeMutablePointer<GtkButton>)]()

	func registerForClicked(obj: Button, fromNativeButton button: UnsafeMutablePointer<GtkButton>) {
		registers.append((obj, button))
	}

	func unregisterForClicked(obj: Button) {
		registers = registers.filter { $0.button == obj }
	}

	func clickedFromButton(button: UnsafeMutablePointer<GtkButton>, userData: gpointer) {
		let forPerform = registers.filter { $0.gtkButton == button }

		for (obj, _) in forPerform {
			let _ = obj.clickedCallbacks.map { $0(obj, userData) }
		}
	}
}