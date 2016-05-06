//
//  DeleteType.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 06.05.16.
//
//

import CGTK

/// - SeeAlso: `::delete-from-cursor`.
public enum DeleteType: RawRepresentable {
	/// Delete characters.
	case Characters
	/// Delete only the portion of the word to the left/right of cursor if we’re
	/// in the middle of a word.
	case WordEnds
	/// Delete words.
	case Words
	/// Delete display-lines. Display-lines refers to the visible lines, with
	/// respect to to the current line breaks. As opposed to paragraphs, which are
	/// defined by line breaks in the input.
	case DisplayLines
	/// Delete only the portion of the display-line to the left/right of cursor.
	case DisplayLineEnds
	/// Delete to the end of the paragraph. Like C-k in Emacs (or its reverse).
	case ParagraphEnds
	/// Delete entire line. Like C-k in pico.
	case Paragraphs
	/// Delete only whitespace. Like M-\ in Emacs.
	case Whitespace
	
	public typealias RawValue = GtkDeleteType
	
	public var rawValue: RawValue {
		switch self {
		case .Characters:
			return GTK_DELETE_CHARS
		case .DisplayLineEnds:
			return GTK_DELETE_DISPLAY_LINE_ENDS
		case .DisplayLines:
			return GTK_DELETE_DISPLAY_LINES
		case .ParagraphEnds:
			return GTK_DELETE_PARAGRAPH_ENDS
		case .Paragraphs:
			return GTK_DELETE_PARAGRAPHS
		case .Whitespace:
			return GTK_DELETE_WHITESPACE
		case .WordEnds:
			return GTK_DELETE_WORD_ENDS
		case .Words:
			return GTK_DELETE_WORDS
		}
	}
	
	public init?(rawValue: RawValue) {
		switch rawValue {
		case GTK_DELETE_CHARS:
			self = .Characters
		case GTK_DELETE_DISPLAY_LINE_ENDS:
			self = .DisplayLineEnds
		case GTK_DELETE_DISPLAY_LINES:
			self = .DisplayLines
		case GTK_DELETE_PARAGRAPH_ENDS:
			self = .ParagraphEnds
		case GTK_DELETE_PARAGRAPHS:
			self = .Paragraphs
		case GTK_DELETE_WHITESPACE:
			self = .Whitespace
		case GTK_DELETE_WORD_ENDS:
			self = .WordEnds
		case GTK_DELETE_WORDS:
			self = .Words
		default:
			return nil
		}
	}
}
