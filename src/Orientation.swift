import CGTK

enum Orientation: RawRepresentable {
	case Horizontal, Vertical

	typealias RawValue = GtkOrientation

	var rawValue: RawValue {
		switch self {
		case .Horizontal:
			return GTK_ORIENTATION_HORIZONTAL
		case .Vertical:
			return GTK_ORIENTATION_VERTICAL
		}
	}

	init(rawValue: RawValue) {
		self = (rawValue == GTK_ORIENTATION_HORIZONTAL) ? .Horizontal : .Vertical
	}
}