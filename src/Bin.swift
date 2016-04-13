import CGTK

class Bin: Container {
	internal var n_Bin: UnsafeMutablePointer<GtkBin>

	internal var _child: Widget?

	internal init(n_Bin: UnsafeMutablePointer<GtkBin>) {
		self.n_Bin = n_Bin
		super.init(n_Container: unsafeBitCast(n_Bin, to: UnsafeMutablePointer<GtkContainer>.self))
	}

	override func childType() -> AnyObject.Type? {
		if _child == nil {
			return nil
		} else {
			return _child!.dynamicType
		}
	}

	override func addWidget(_ widget: Widget) {
		guard _child == nil else {
			print("Attempting to add a widget with type \(widget.dynamicType) to a \(self.dynamicType), but as a GtkBin subclass a \(self.dynamicType) can only contain one widget at a time; it already contains a widget of type \(_child!.dynamicType)")
			return
		}

		super.addWidget(widget)

		widget.parent = self
		_child = widget
	}

	override func removeWidget(_ widget: Widget) {
		guard _child == widget else { return }

		super.removeWidget(widget)

		widget.parent = nil
		_child = nil
	}

	var childWidget: Widget? {
		return _child
	}

	override func forAll(_ f: (Widget) -> Void) {
		guard let child = _child else { return }
		f(child)
	}
}