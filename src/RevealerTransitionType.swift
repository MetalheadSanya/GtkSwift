//
//  RevealerTransitionType.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 15.04.16.
//
//

import CGTK

public enum RevealerTransitionType: RawRepresentable {
	case None, Crossfade, SlideRight, SlideLeft, SlideUp, SlideDown
	
	public typealias RawValue = GtkRevealerTransitionType
	
	public var rawValue: RawValue {
		switch self {
		case .None:
			return GTK_REVEALER_TRANSITION_TYPE_NONE
		case .Crossfade:
			return GTK_REVEALER_TRANSITION_TYPE_CROSSFADE
		case .SlideRight:
			return GTK_REVEALER_TRANSITION_TYPE_SLIDE_RIGHT
		case .SlideLeft:
			return GTK_REVEALER_TRANSITION_TYPE_SLIDE_LEFT
		case .SlideUp:
			return GTK_REVEALER_TRANSITION_TYPE_SLIDE_UP
		case .SlideDown:
			return GTK_REVEALER_TRANSITION_TYPE_SLIDE_DOWN
		}
	}
	
	public init?(rawValue: RawValue) {
		switch rawValue {
		case GTK_REVEALER_TRANSITION_TYPE_NONE:
			self = .None
		case GTK_REVEALER_TRANSITION_TYPE_CROSSFADE:
			self = .Crossfade
		case GTK_REVEALER_TRANSITION_TYPE_SLIDE_RIGHT:
			self = .SlideRight
		case GTK_REVEALER_TRANSITION_TYPE_SLIDE_LEFT:
			self = .SlideLeft
		case GTK_REVEALER_TRANSITION_TYPE_SLIDE_UP:
			self = .SlideUp
		case GTK_REVEALER_TRANSITION_TYPE_SLIDE_DOWN:
			self = .SlideDown
		default:
			return nil
		}
	}

}
