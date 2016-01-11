import CGTK

enum DirectionType: RawRepresentable {
	case TabForward, TabBackward, Up, Down, Left, Right

	typealias RawValue = GtkDirectionType

	var rawValue: RawValue {
		switch self {
		case .TabForward:
			return GTK_DIR_TAB_FORWARD
		case .TabBackward:
			return GTK_DIR_TAB_BACKWARD
		case .Up:
			return GTK_DIR_UP
		case .Down:
			return GTK_DIR_DOWN
		case .Left:
			return GTK_DIR_LEFT
		case .Right: 
			return GTK_DIR_RIGHT
		}
	}

	init(rawValue: RawValue) {
		self = (rawValue == GTK_DIR_TAB_FORWARD) ? .TabForward : 
		    (rawValue == GTK_DIR_TAB_BACKWARD) ? .TabBackward :
		    (rawValue == GTK_DIR_UP) ? .Up :
		    (rawValue == GTK_DIR_DOWN) ? .Down :
		    (rawValue == GTK_DIR_RIGHT) ? .Left : .Right
	}
}