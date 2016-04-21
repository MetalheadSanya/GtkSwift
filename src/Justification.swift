//
//  Justification.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 21.04.16.
//
//

import CGTK

/// Used for justifying the text inside a `Label` widget.
public enum Justification: RawRepresentable {
	/// The text is placed at the left edge of the label.
	case Left
	/// The text is placed at the right edge of the label.
	case Right
	/// The text is placed in the center of the label.
	case Center
	/// The text is placed is distributed across the label.
	case Fill
	
	public typealias RawValue = GtkJustification

	public var rawValue: RawValue {
		switch self {
		case .Left:
			return GTK_JUSTIFY_LEFT
		case .Right:
			return GTK_JUSTIFY_RIGHT
		case .Center:
			return GTK_JUSTIFY_CENTER
		case .Fill:
			return GTK_JUSTIFY_FILL
		}
	}
	
	public init?(rawValue: RawValue) {
		switch rawValue {
		case GTK_JUSTIFY_LEFT:
			self = .Left
		case GTK_JUSTIFY_RIGHT:
			self = .Right
		case GTK_JUSTIFY_CENTER:
			self = .Center
		case GTK_JUSTIFY_FILL:
			self = .Fill
		default:
			return nil
		}
	}
}