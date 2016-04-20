//
// Created by Alexander Zalutskiy on 21.12.15.
// Copyright (c) 2015 Metalhead. All rights reserved.
//

import CGTK

public class Label: Misc {

	internal var n_Label: UnsafeMutablePointer<GtkLabel>

	override class var n_Type: UInt {
		return gtk_label_get_type()
	}

	internal init(n_Label: UnsafeMutablePointer<GtkLabel>) {
		self.n_Label = n_Label
		super.init(n_Misc: UnsafeMutablePointer<GtkMisc>(self.n_Label))
	}
	
	/// Creates a new label with the given text inside it. You can pass `nil` to 
	/// get an empty label widget.
	///
	/// - Parameter string: The text of the label
	public convenience init(string: String?) {
		self.init(n_Label: UnsafeMutablePointer<GtkLabel>(gtk_label_new(string)))
	}
	
	/// Creates a new `Label`, containing the text in `string`.
	///
	/// If characters in `string` are preceded by an underscore, they are
	/// underlined. If you need a literal underscore character in a label, use
	/// '__' (two underscores). The first underlined character represents a
	/// keyboard accelerator called a mnemonic. The mnemonic key can be used to
	/// activate another widget, chosen automatically, or explicitly using
	/// `mnemonicWidget` property.
	///
	/// If `mnemonicWidget` property is not setted, then the first activatable
	/// ancestor of the `Label` will be chosen as the mnemonic widget. For
	/// instance, if the label is inside a button or menu item, the button or menu
	/// item will automatically become the mnemonic widget and be activated by the
	/// mnemonic.
	public convenience init(mnemonic string: String?) {
		self.init(n_Label:
			UnsafeMutablePointer<GtkLabel>(gtk_label_new_with_mnemonic(string)))
	}

	/// The text within the `Label` widget. Change property overwrites any text 
	/// that was there before.
	///
	/// Change property will clear any previously set mnemonic accelerators, and 
	/// set the `useUnderline` property to `false` as a side effect.
	///
	/// Change property will set the `useMarkup` property to `false` as a side 
	/// effect.
	///
	/// - SeeAlso: `setMarkup(_:)`
	public var text: String? {
		set {
			gtk_label_set_text(n_Label, newValue)
		}
		get {
			let str = gtk_label_get_text(n_Label)
			if str != nil {
				return String(cString: str)
			} else {
				return nil
			}
		}
	}
	
	// TODO: `attributes` property, need pango-swift

	/// Parses `string` which is marked up with the Pango text markup language, 
	/// setting the label’s text and attribute list based on the parse results.
	///
	/// This function will set the `useMarkup` property to `true` as a side
	/// effect.
	///
	/// If you set the label contents using the `label` property you should also 
	/// ensure that you set the `useMarkup` property accordingly.
	///
	/// - SeeAlso: `text` property
	///
	/// - Parameter string: a markup string (see Pango markup format)
	public func setMarkup(_ string: String) {
		gtk_label_set_markup(n_Label, string)
	}
	
	/// Parses `string` which is marked up with the Pango text markup language,
	/// setting the label’s text and attribute list based on the parse results. If
	/// characters in `string` are preceded by an underscore, they are underlined
	/// indicating that they represent a keyboard accelerator called a mnemonic.
	///
	/// - Parameter string: a markup string (see Pango markup format)
	public func setMarkupWithMnemonic(_ string: String) {
		gtk_label_set_markup_with_mnemonic(n_Label, string)
	}
	
	/// The pattern of underlines you want under the existing text within the
	/// `Label` widget. For example if the current text of the label says
	/// “FooBarBaz” passing a pattern of “___ ___” will underline “Foo” and “Baz”
	/// but not “Bar”.
	///
	/// - Parameter pattern: the pattern as described above.
	public func setPattern(_ pattern: String) {
		gtk_label_set_pattern(n_Label, pattern)
	}
	
	// TODO: justify property
	
	/// The `xalign` property determines the horizontal aligment of the label text
	/// inside the labels size allocation. Compare this to `halign`, which
	/// determines how the labels size allocation is positioned in the space
	/// available for the label.
	///
	/// - Version: Since: 3.16
	///
	/// - Allowed values: [0,1]
	public var xAlign: Float {
		set {
			gtk_label_set_xalign(n_Label, gfloat(newValue))
		}
		get {
			return Float(gtk_label_get_xalign(n_Label))
		}
	}
	
	/// The `yalign` property determines the vertical aligment of the label text
	/// inside the labels size allocation. Compare this to `valign`, which
	/// determines how the labels size allocation is positioned in the space
	/// available for the label.
	///
	/// - Version: Since: 3.16
	///
	/// - Allowed values: [0,1]
	public var yAlign: Float {
		set {
			gtk_label_set_yalign(n_Label, gfloat(newValue))
		}
		get {
			return Float(gtk_label_get_yalign(n_Label))
		}
	}
	
	// TODO: ellipsize property, need pango-swift
	
	/// The desired width of the label, in characters. If this property is set to 
	/// -1, the width will be calculated automatically.
	///
	/// See the section on text layout for details of how `widthChars` and 
	/// `maxWidthChars` determine the width of ellipsized and wrapped labels.
	public var widthChars: Int {
		set {
			gtk_label_set_width_chars(n_Label, gint(newValue))
		}
		get {
			return Int(gtk_label_get_width_chars(n_Label))
		}
	}
	
	/// The desired maximum width of the label, in characters. If this property is
	/// set to -1, the width will be calculated automatically.
	///
	/// See the section on text layout for details of how `widthChars` and 
	/// `maxWidthChars` determine the width of ellipsized and wrapped labels.
	public var maxWidthChars: Int {
		set {
			gtk_label_set_max_width_chars(n_Label, gint(newValue))
		}
		get {
			return Int(gtk_label_get_max_width_chars(n_Label))
		}
	}
	
	/// Toggles line wrapping within the `Label` widget. `true` makes it break
	/// lines if text exceeds the widget’s size. `false` lets the text get cut off
	/// by the edge of the widget if it exceeds the widget size.
	///
	/// Note that setting line wrapping to `true` does not make the label wrap at
	/// its parent container’s width, because GTK+ widgets conceptually can’t make
	/// their requisition depend on the parent container’s size. For a label that
	/// wraps at a specific position, set the label’s width using `sizeRequest`
	/// property.
	public var lineWrap: Bool {
		set {
			gtk_label_set_line_wrap(n_Label, newValue ? 1 : 0)
		}
		get {
			return gtk_label_get_line_wrap(n_Label) != 0
		}
	}
	
	// TODO: lineWrapMode property, need pango-swift
	
	/// The number of lines to which an ellipsized, wrapping label should be
	/// limited. This has no effect if the label is not wrapping or ellipsized.
	/// Set this to -1 if you don’t want to limit the number of lines.
	public var lines: Int {
		set {
			gtk_label_set_lines(n_Label, gint(newValue))
		}
		get {
			return Int(gtk_label_get_lines(n_Label))
		}
	}
	
	// TODO: docs
	/// Obtains the coordinates where the label will draw the `Pango.Layout`
	/// representing the text in the label; useful to convert mouse events into
	/// coordinates inside the `Pango.Layout`, e.g. to take some action if some
	/// part of the label is clicked. Of course you will need to create a 
	/// `EventBox` to receive the events, and pack the label inside it, since
	/// labels are windowless (`hasWindow` property is `false`). Remember when
	/// using the `Pango.Layout` functions you need to convert to and from pixels
	/// using PANGO_PIXELS() or PANGO_SCALE.
	public var layoutOffsets: Point {
		var x, y: gint
		
		x = 0; y = 0
		
		gtk_label_get_layout_offsets(n_Label, &x, &y)
		
		return Point(x: Int(x), y: Int(y))
	}
	
	// TODO: mnemonicKeyval property { get }, need gdk-swift
	
	/// Whether the label text can be selected with the mouse.
	public var selectable: Bool {
		set {
			gtk_label_set_selectable(n_Label, newValue ? 1 : 0)
		}
		get {
			return gtk_label_get_selectable(n_Label) != 0
		}
	}
}
