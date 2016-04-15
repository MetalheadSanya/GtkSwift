//
//  PositionType.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 15.04.16.
//
//

import CGTK

/// Describes which edge of a widget a certain feature is positioned at, e.g. 
/// the tabs of a Notebook, the handle of a HandleBox or the label of a Scale.
public enum PositionType: RawRepresentable {
	case Left, Right, Top, Bottom
	
	public typealias RawValue = GtkPositionType
	
	public var rawValue: RawValue {
		switch self {
		case .Left:
			return GTK_POS_LEFT
		case .Right:
			return GTK_POS_RIGHT
		case .Top:
			return GTK_POS_TOP
		case .Bottom:
			return GTK_POS_BOTTOM
		}
	}
	
	public init?(rawValue: RawValue) {
		switch rawValue {
		case GTK_POS_LEFT:
			self = .Left
		case GTK_POS_RIGHT:
			self = .Right
		case GTK_POS_TOP:
			self = .Top
		case GTK_POS_BOTTOM:
			self = .Bottom
		default:
			return nil
		}
	}
}