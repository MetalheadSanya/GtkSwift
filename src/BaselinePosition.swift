//
//  BaselinePosition.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 15.04.16.
//
//

import CGTK

/// Whenever a container has some form of natural row it may align children in 
///	that row along a common typographical baseline. If the amount of verical 
/// space in the row is taller than the total requested height of the 
/// baseline-aligned children then it can use a BaselinePosition to select where
/// to put the baseline inside the extra availible space.
public enum BaselinePosition: RawRepresentable {
	case Top, Center, Bottom
	
	public typealias RawValue = GtkBaselinePosition
	
	public var rawValue: RawValue {
		switch self {
		case .Top:
			return GTK_BASELINE_POSITION_TOP
		case .Center:
			return GTK_BASELINE_POSITION_CENTER
		case .Bottom:
			return GTK_BASELINE_POSITION_BOTTOM
		}
	}
	
	public init?(rawValue: RawValue) {
		switch rawValue {
		case GTK_BASELINE_POSITION_TOP:
			self = .Top
		case GTK_BASELINE_POSITION_CENTER:
			self = .Center
		case GTK_BASELINE_POSITION_BOTTOM:
			self = .Bottom
		default:
			return nil
		}
	}
}
