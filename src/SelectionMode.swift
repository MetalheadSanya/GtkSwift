//
//  SelectionMode.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 15.04.16.
//
//

import CGTK

/// Used to control what selections users are allowed to make.
public enum SelectionMode: RawRepresentable {
	/// No selection is possible.
	case None
	/// Zero or one element may be selected.
	case Single
	/// Exactly one element is selected. In some circumstances, such as initially 
	/// or during a search operation, it’s possible for no element to be selected 
	/// with `.Browse`. What is really enforced is that the user can’t deselect a 
	/// currently selected element except by selecting another element.
	case Browse
	/// Any number of elements may be selected. The Ctrl key may be used to 
	/// enlarge the selection, and Shift key to select between the focus and the 
	/// child pointed to. Some widgets may also allow Click-drag to select a range 
	/// of elements.
	case Multiple
	
	public typealias RawValue = GtkSelectionMode
	
	public var rawValue: RawValue {
		switch self {
		case .None:
			return GTK_SELECTION_NONE
		case .Single:
			return GTK_SELECTION_SINGLE
		case .Browse:
			return GTK_SELECTION_BROWSE
		case .Multiple:
			return GTK_SELECTION_MULTIPLE
		}
	}
	
	public init?(rawValue: RawValue) {
		switch rawValue {
		case GTK_SELECTION_NONE:
			self = .None
		case GTK_SELECTION_SINGLE:
			self = .Single
		case GTK_SELECTION_BROWSE:
			self = .Browse
		case GTK_SELECTION_MULTIPLE:
			self = .Multiple
		default:
			return nil
		}
	}
}
