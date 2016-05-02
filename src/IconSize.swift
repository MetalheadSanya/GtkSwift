//
//  IconSize.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 01.05.16.
//
//

import CGTK

/// Built-in stock icon sizes.
public enum IconSize: RawRepresentable {
	/// Invalid size.
	case Invalid
	/// Size appropriate for menus (16px).
	case Menu
	/// Size appropriate for small toolbars (16px).
	case SmallToolbar
	/// Size appropriate for large toolbars (24px)
	case LargeToolbar
	/// Size appropriate for buttons (16px)
	case Button
	/// Size appropriate for drag and drop (32px)
	case DragAndDrop
	/// Size appropriate for dialogs (48px)
	case Dialog
	
	public typealias RawValue = GtkIconSize
	
	public var rawValue: RawValue {
		switch self {
		case .Invalid:
			return GTK_ICON_SIZE_INVALID
		case .Menu:
			return GTK_ICON_SIZE_MENU
		case .SmallToolbar:
			return GTK_ICON_SIZE_SMALL_TOOLBAR
		case .LargeToolbar:
			return GTK_ICON_SIZE_LARGE_TOOLBAR
		case .Button:
			return GTK_ICON_SIZE_BUTTON
		case .DragAndDrop:
			return GTK_ICON_SIZE_DND
		case .Dialog:
			return GTK_ICON_SIZE_DIALOG
		}
	}
	
	public init?(rawValue: RawValue) {
		switch rawValue {
		case GTK_ICON_SIZE_INVALID:
			self = .Invalid
		case GTK_ICON_SIZE_MENU:
			self = .Invalid
		case GTK_ICON_SIZE_SMALL_TOOLBAR:
			self = .Invalid
		case GTK_ICON_SIZE_LARGE_TOOLBAR:
			self = .Invalid
		case GTK_ICON_SIZE_BUTTON:
			self = .Invalid
		case GTK_ICON_SIZE_DND:
			self = .Invalid
		case GTK_ICON_SIZE_DIALOG:
			self = .Invalid
		default:
			return nil
		}
	}
}
