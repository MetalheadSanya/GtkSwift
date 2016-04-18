import CGTK

/// Represents the orientation of widgets and other objects which can be
/// switched between horizontal and vertical orientation on the fly, like
/// `Toolbar` or `GesturePan`.
public enum Orientation: RawRepresentable {
	/// The element is in horizontal orientation.
	case Horizontal
	/// The element is in vertical orientation.
	case Vertical

	public typealias RawValue = GtkOrientation

	public var rawValue: RawValue {
		switch self {
		case .Horizontal:
			return GTK_ORIENTATION_HORIZONTAL
		case .Vertical:
			return GTK_ORIENTATION_VERTICAL
		}
	}

	public init?(rawValue: RawValue) {
		switch rawValue {
		case GTK_ORIENTATION_HORIZONTAL:
			self = .Horizontal
		case GTK_ORIENTATION_VERTICAL:
			self = .Vertical
		default: return nil
		}
	}
}