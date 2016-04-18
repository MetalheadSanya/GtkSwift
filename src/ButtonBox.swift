import CGTK

public class ButtonBox: Box {
	/// Used to dictate the style that a `ButtonBox` uses to layout the buttons it
	/// contains.
	public enum Style: RawRepresentable {
		/// Buttons are evenly spread across the box.
		case Spread
		/// Buttons are placed at the edges of the box.
		case Edge
		/// Buttons are grouped towards the start of the box, (on the left for a
		/// `HBox`, or the top for a `VBox`).
		case Start
		/// Buttons are grouped towards the end of the box, (on the right for a
		/// `HBox`, or the bottom for a `VBox`).
		case End
		/// Buttons are centered in the box. 
		///
		/// - Version: Since 2.12.
		case Center
		/// Buttons expand to fill the box. This entails giving buttons a `linked`
		/// appearance, making button sizes homogeneous, and setting spacing to 0
		/// (same as `homogeneous` and `spacing` property). 
		///
		/// - Version: Since 3.12.
		case Expand
		
		public typealias RawValue = GtkButtonBoxStyle
		
		public var rawValue: RawValue {
			switch self {
			case .Spread:
				return GTK_BUTTONBOX_SPREAD
			case .Edge:
				return GTK_BUTTONBOX_EDGE
			case .Start:
				return GTK_BUTTONBOX_START
			case .End:
				return GTK_BUTTONBOX_END
			case .Center:
				return GTK_BUTTONBOX_CENTER
			case .Expand:
				return GTK_BUTTONBOX_EXPAND
			}
		}
		
		public init?(rawValue: RawValue) {
			switch rawValue {
			case GTK_BUTTONBOX_SPREAD:
				self = .Spread
			case GTK_BUTTONBOX_EDGE:
				self = .Edge
			case GTK_BUTTONBOX_START:
				self = .Start
			case GTK_BUTTONBOX_END:
				self = .End
			case GTK_BUTTONBOX_CENTER:
				self = .Center
			case GTK_BUTTONBOX_EXPAND:
				self = .Expand
			default: return nil
			}
		}
	}
	
	internal var n_ButtonBox: UnsafeMutablePointer<GtkButtonBox>

	internal init(n_ButtonBox: UnsafeMutablePointer<GtkButtonBox>) {
		self.n_ButtonBox = n_ButtonBox
		super.init(n_Box: UnsafeMutablePointer<GtkBox>(n_ButtonBox))
	}

	/// Creates a new `ButtonBox`.
	public convenience init(orientation: Orientation) {
		self.init(n_ButtonBox: UnsafeMutablePointer<GtkButtonBox>(
			gtk_button_box_new(orientation.rawValue)))
	}
	
	/// The method being used to arrange the buttons in a button box.
	public var layout: Style {
		set {
			gtk_button_box_set_layout(n_ButtonBox, newValue.rawValue)
		}
		get {
			return Style(rawValue: gtk_button_box_get_layout(n_ButtonBox))!
		}
	}
	
	/// Returns whether `child` should appear in a secondary group of children.
	///
	/// - Parameter child: a child of box
	///
	/// - Returns: whether `child` should appear in a secondary group of children.
	public func getChildSecondary(_ child: Widget) -> Bool {
		return gtk_button_box_get_child_secondary(n_ButtonBox, child.n_Widget) != 0
	}
	
	/// Returns whether the `child` is exempted from homogenous sizing.
	///
	/// - Parameter child: a child of widget
	///
	/// - Returns: `true` if the `child` is not subject to homogenous sizing
	public func getChildNonHomogeneous(_ child: Widget) -> Bool {
		return gtk_button_box_get_child_non_homogeneous(n_ButtonBox,
		                                                child.n_Widget) != 0
	}
	
	/// Sets whether `child` should appear in a secondary group of children. A
	/// typical use of a secondary child is the help button in a dialog.
	///
	/// This group appears after the other children if the style is
	/// `.Start`, `.Spread` or `.Edge`, and before the other children if the style
	/// is `.End`. For horizontal button boxes, the definition of before/after
	/// depends on direction of the widget (see `derection` property). If the
	/// style is `.Start` or `.End`, then the secondary children are aligned at
	/// the other end of the button box from the main children. For the other
	/// styles, they appear immediately next to the main children.
	///
	/// - Parameter child: a child of widget
	/// - Parameter secondary: if `true`, the `child` appears in a secondary group
	///    of the button box.
	public func setChild(_ child: Widget, isSecondary secondary: Bool) {
		gtk_button_box_set_child_non_homogeneous(n_ButtonBox, child.n_Widget,
		                                         secondary ? 1 : 0)
	}
	
	/// Sets whether the child is exempted from homogeous sizing.
	///
	/// - Parameter child: a child of widget
	/// - Parameter nonHomogeneous: the new value
	public func setChild(_ child: Widget, isNonHomogeneous nonHomogeneous: Bool) {
		gtk_button_box_set_child_non_homogeneous(n_ButtonBox, child.n_Widget,
		                                         nonHomogeneous ? 1 : 0)
	}

}