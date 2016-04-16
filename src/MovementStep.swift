//
//  MovementStep.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 16.04.16.
//
//

import CGTK

public enum MovementStep: RawRepresentable {
	/// Move forward or back by graphemes
	case LogicalPositions
	/// Move left or right by graphemes
	case VisualPositions
	/// Move forward or back by words
	case Words
	/// Move up or down lines (wrapped lines)
	case DisplayLines
	/// Move to either end of a line
	case DisplayLineEnds
	/// Move up or down paragraphs (newline-ended lines)
	case Paragraphs
	/// Move to either end of a paragraph
	case ParagraphEnds
	/// Move by pages
	case Pages
	/// Move to ends of the buffer
	case BufferEnds
	/// Move horizontally by pages
	case HorizontalPages
	
	public typealias RawValue = GtkMovementStep
	
	public var rawValue: RawValue {
		switch self {
		case .LogicalPositions:
			return GTK_MOVEMENT_LOGICAL_POSITIONS
		case .VisualPositions:
			return GTK_MOVEMENT_VISUAL_POSITIONS
		case .Words:
			return GTK_MOVEMENT_WORDS
		case .DisplayLines:
			return GTK_MOVEMENT_DISPLAY_LINES
		case .DisplayLineEnds:
			return GTK_MOVEMENT_DISPLAY_LINE_ENDS
		case .Paragraphs:
			return GTK_MOVEMENT_PARAGRAPHS
		case .ParagraphEnds:
			return GTK_MOVEMENT_PARAGRAPH_ENDS
		case .Pages:
			return GTK_MOVEMENT_PAGES
		case .BufferEnds:
			return GTK_MOVEMENT_BUFFER_ENDS
		case .HorizontalPages:
			return GTK_MOVEMENT_HORIZONTAL_PAGES
		}
	}
	
	public init?(rawValue: RawValue) {
		switch rawValue {
		case GTK_MOVEMENT_LOGICAL_POSITIONS:
			self = .LogicalPositions
		case GTK_MOVEMENT_VISUAL_POSITIONS:
			self = .VisualPositions
		case GTK_MOVEMENT_WORDS:
			self = .Words
		case GTK_MOVEMENT_DISPLAY_LINES:
			self = .DisplayLines
		case GTK_MOVEMENT_DISPLAY_LINE_ENDS:
			self = .DisplayLineEnds
		case GTK_MOVEMENT_PARAGRAPHS:
			self = .Paragraphs
		case GTK_MOVEMENT_PARAGRAPH_ENDS:
			self = .ParagraphEnds
		case GTK_MOVEMENT_PAGES:
			self = .Pages
		case GTK_MOVEMENT_BUFFER_ENDS:
			self = .BufferEnds
		case GTK_MOVEMENT_HORIZONTAL_PAGES:
			self = .HorizontalPages
		default:
			return nil
		}
	}
	
}
