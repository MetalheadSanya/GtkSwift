import CGTK

public enum Orientation: RawRepresentable {
	case Horizontal, Vertical

	public typealias RawValue = GtkOrientation

	public var rawValue: RawValue {
		switch self {
		case .Horizontal:
			return GTK_ORIENTATION_HORIZONTAL
		case .Vertical:
			return GTK_ORIENTATION_VERTICAL
		}
	}

	public init(rawValue: RawValue) {
		self = (rawValue == GTK_ORIENTATION_HORIZONTAL) ? .Horizontal : .Vertical
	}
}