import CGTK
import gobjectswift

public typealias ButtonClickedCallback = (Button) -> Void

public class Button: Container {
	internal var n_Button: UnsafeMutablePointer<GtkButton>

	internal init(n_Button: UnsafeMutablePointer<GtkButton>) {
		self.n_Button = n_Button
		super.init(n_Container: unsafeBitCast(self.n_Button, to: UnsafeMutablePointer<GtkContainer>.self))
	}

	public convenience init(label: String) {
		self.init(n_Button: unsafeBitCast(gtk_button_new_with_label(label), to: UnsafeMutablePointer<GtkButton>.self))
	}

	public typealias ButtonClickedNative = @convention(c)(UnsafeMutablePointer<GtkButton>, gpointer) -> Void

	public lazy var clickedSignal: Signal<ButtonClickedCallback, Button, ButtonClickedNative>
			= Signal(obj: self, signal: "clicked", c_handler: {
				(_, user_data) in
				let data = unsafeBitCast(user_data, to: SignalData<Button, ButtonClickedCallback>.self)

				let button = data.obj
				let action = data.function

				action(button)
			})
}

// extension Button: Equatable { }

public func ==(lhs: Button, rhs: Button) -> Bool {
	return lhs.n_Button == rhs.n_Button
}