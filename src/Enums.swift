import CGTK

enum Orientation {
	case Horizontal, Vertical

	internal var n_Orientation: GtkOrientation {
		switch self {
		case .Horizontal:
			return GTK_ORIENTATION_HORIZONTAL
		case .Vertical:
			return GTK_ORIENTATION_VERTICAL
		}
	}
}