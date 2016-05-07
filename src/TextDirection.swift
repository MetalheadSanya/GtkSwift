import CGTK

public enum TextDirection : RawRepresentable {
	case None, LeftToRight, RightToLeft

	public typealias RawValue = GtkTextDirection

	public var rawValue: RawValue {
		switch self {
		case .None:
			return GTK_TEXT_DIR_NONE
		case .LeftToRight:
			return GTK_TEXT_DIR_LTR
		case .RightToLeft:
			return GTK_TEXT_DIR_RTL
		}
	}

	public init?(rawValue: RawValue) {
		switch rawValue {
		case GTK_TEXT_DIR_NONE:
			self = TextDirection.None
		case GTK_TEXT_DIR_LTR:
			self = TextDirection.LeftToRight
		case GTK_TEXT_DIR_RTL:
			self = TextDirection.RightToLeft
		default:
			return nil
		}
	}
}