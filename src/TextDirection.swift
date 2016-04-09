import CGTK

enum TextDirection : RawRepresentable {
	case None, LeftToRight, RightToLeft

	typealias RawValue = GtkTextDirection

	var rawValue: RawValue {
		switch self {
		case .None:
			return GTK_TEXT_DIR_NONE
		case .LeftToRight:
			return GTK_TEXT_DIR_LTR
		case .RightToLeft:
			return GTK_TEXT_DIR_RTL
		}
	}

	init?(rawValue: RawValue) {
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