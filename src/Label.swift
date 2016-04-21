//
// Created by Alexander Zalutskiy on 21.12.15.
// Copyright (c) 2015 Metalhead. All rights reserved.
//

import CGTK
import gobjectswift

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
	
	/// The alignment of the lines in the text of the label relative to each
	/// other. `.Left` is the default value when the widget is first created with
	/// init(). If you instead want to set the alignment of the label as a whole,
	/// use `hAlign` property instead.
	///
	/// `justify` property has no effect on labels containing only a single line.
	public var justify: Justification {
		set {
			gtk_label_set_justify(n_Label, newValue.rawValue)
		}
		get {
			return Justification(rawValue: gtk_label_get_justify(n_Label))!
		}
	}
	
	/// The `xAlign` property determines the horizontal aligment of the label text
	/// inside the labels size allocation. Compare this to `hAlign`, which
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
	
	/// The `yAlign` property determines the vertical aligment of the label text
	/// inside the labels size allocation. Compare this to `vAlign`, which
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
	
	/// Selects a range of characters in the label, if the label is selectable.
	/// See `selectable` propery. If the label is not selectable, this function
	/// has no effect. If startIndex or endIndex are -1, then the end of the label
	/// will be substituted.
	///
	/// - Parameter startIndex: start offset (in characters not bytes)
	/// - Parameter endIndex: end offset (in characters not bytes)
	public func selectRegion(from startIndex: Int, to endIndex: Int) {
		gtk_label_select_region(n_Label, gint(startIndex), gint(endIndex))
	}
	
	private var _mnemonicWidget: Widget?
	
	/// If the label has been set so that it has an mnemonic key (using i.e.
	/// `setMarkupWithMnemonic(_:)`, `setTextWithMnemonic(_:)`,
	/// `Label.init(mnemonic:)` or the `useUnderline` property) the label can be
	/// associated with a widget that is the target of the mnemonic. When the
	/// label is inside a widget (like a `Button` or a `Notebook` tab) it is
	/// automatically associated with the correct widget, but sometimes (i.e. when
	/// the target is a `Entry` next to the label) you need to set it explicitly
	/// using this function.
	///
	/// The target widget will be accelerated by emitting the
	/// `Widget::mnemonicActivate` signal on it. The default handler for this
	/// signal will activate the widget if there are no mnemonic collisions and
	/// toggle focus between the colliding widgets otherwise.
	public var mnemonicWidget: Widget? {
		set {
			gtk_label_set_mnemonic_widget(n_Label, newValue?.n_Widget)
		}
		get {
			let n_Widget = gtk_label_get_mnemonic_widget(n_Label)
			if n_Widget == nil {
				_mnemonicWidget = nil
				return nil
			}
			else if _mnemonicWidget?.n_Widget != n_Widget {
				print("WARNING: [Label.mnemonicWidget] generate Widget obj from" +
					"pointer")
				_mnemonicWidget = Container.correctWidgetForWidget(
					Widget(n_Widget: n_Widget))
			}
			return _mnemonicWidget
		}
	}
	
	/// Sets the label’s text from the string `string`. If characters in `string`
	/// are preceded by an underscore, they are underlined indicating that they
	/// represent a keyboard accelerator called a mnemonic. The mnemonic key can
	/// be used to activate another widget, chosen automatically, or explicitly
	/// using `mnemonicWidget` property.
	///
	/// - Parameter string: a string
	public func setTextWithMnemonic(_ string: String) {
		gtk_label_set_text_with_mnemonic(n_Label, string)
	}
	
	/// Sets the text of the label. The label is interpreted as including embedded
	/// underlines and/or Pango markup depending on the values of the
	/// `useInderline` and `useMarkup` properties.
	public var label: String {
		set {
			gtk_label_set_label(n_Label, newValue)
		}
		get {
			return String(cString: gtk_label_get_label(n_Label))
		}
	}
	
	// TODO: layout property, need pango-swift
	
	/// Gets the selected range of characters in the label, returning `nil` if
	/// there’s a selection.
	public var selectionBounds: (start: Int, end: Int)? {
		var start, end: gint
		start = 0; end = 0
		
		let result = gtk_label_get_selection_bounds(n_Label, &start, &end)
		
		guard result != 0 else { return nil }
		
		return (start: Int(start), end: Int(end))
	}
	
	/// Whether the text of the label contains markup in Pango’s text markup
	/// language.
	///
	/// - SeeAlso: `setMarkup(_:)`
	public var useMarkup: Bool {
		set {
			gtk_label_set_use_markup(n_Label, newValue ? 1 : 0)
		}
		get {
			return gtk_label_get_use_markup(n_Label) != 0
		}
	}
	
	/// If true, an underline in the text indicates the next character should be
	/// used for the mnemonic accelerator key.
	public var useUnderline: Bool {
		set {
			gtk_label_set_use_underline(n_Label, newValue ? 1 : 0)
		}
		get {
			return gtk_label_get_use_underline(n_Label) != 0
		}
	}
	
	/// Whether the label is in single line mode.
	public var singleLineMode: Bool {
		set {
			gtk_label_set_single_line_mode(n_Label, newValue ? 1 : 0)
		}
		get {
			return gtk_label_get_use_underline(n_Label) != 0
		}
	}
	
	/// The angle of rotation for the label. An angle of 90 reads from from bottom
	/// to top, an angle of 270, from top to bottom. The angle setting for the
	/// label is ignored if the label is selectable, wrapped, or ellipsized.
	public var angle: Double {
		set {
			gtk_label_set_angle(n_Label, gdouble(newValue))
		}
		get {
			return Double(gtk_label_get_angle(n_Label))
		}
	}
	
	/// Returns the URI for the currently active link in the label. The active
	/// link is the one under the mouse pointer or, in a selectable label, the
	/// link in which the text cursor is currently positioned.
	///
	/// This property is intended for use in a `activateLinkSignal` handler or for
	/// use in a `queryTooltipSignal` handler.
	public var currentUri: String {
		return String(cString: gtk_label_get_current_uri(n_Label))
	}
	
	/// Whether the label should keep track of clicked links (and use a different
	/// color for them).
	public var trackVisitedLinks: Bool {
		set {
			gtk_label_set_track_visited_links(n_Label, newValue ? 1 : 0)
		}
		get {
			return gtk_label_get_track_visited_links(n_Label) != 0
		}
	}
	
	/// - Parameter label: the label on which the signal was emitted
	public typealias ActivateCurrentLinkCallback = (label: Label) -> Void
	public typealias ActivateCurrentLinkNative = (GtkLabel, gpointer) -> Void
	
	/// A keybinding signal which gets emitted when the user activates a link in
	/// the label.
	///
	/// Applications may also emit the signal with `emit` method if they need to
	/// control activation of URIs programmatically.
	///
	/// The default bindings for this signal are all forms of the Enter key.
	public lazy var activateCurrentLinkSignal:
		Signal<ActivateCurrentLinkCallback, Label, ActivateCurrentLinkNative> =
		Signal(obj: self, signal: "activate-current-link", c_handler: {
			_, user_data in
			let data = unsafeBitCast(user_data,
			                         to: SignalData<Label,
																ActivateCurrentLinkCallback>.self)
			
			let label = data.obj
			let action = data.function
			
			action(label: label)
			
		})
	
	/// - Parameter label: The label on which the signal was emitted
	/// - Parameter uri: the URI that is activated
	public typealias ActivateLinkCallback = (label: Label, uri: String) -> Bool
	public typealias ActivateLinkNative = (GtkLabel, UnsafePointer<gchar>,
		gpointer) -> gboolean
	
	// TODO: docs
	/// The signal which gets emitted to activate a URI. Applications may connect
	/// to it to override the default behaviour, which is to call `showUri()`.
	public lazy var activateLinkSignal:
		Signal<ActivateLinkCallback, Label, ActivateLinkNative> =
		Signal(obj: self, signal: "activate-link", c_handler: {
			_, n_Uri, user_data in
			let data = unsafeBitCast(user_data,
			                         to: SignalData<Label,
																ActivateLinkCallback>.self)
			
			let label = data.obj
			let uri = String(cString: n_Uri)
			let action = data.function
			
			return action(label: label, uri: uri) ? 1 : 0
		})
	
	/// - Parameter label: the label on which the signal was emitted
	public typealias CopyClipboardCallback = (label: Label) -> Void
	public typealias CopyClipboardNative = (GtkLabel, gpointer) -> Void
	
	/// The `::copyClipboard` signal is a keybinding signal which gets emitted to
	/// copy the selection to the clipboard.
	///
	/// The default binding for this signal is Ctrl-c.
	public lazy var copyClipboardSignal:
		Signal<CopyClipboardCallback, Label, CopyClipboardNative> =
		Signal(obj: self, signal: "copy-clipboard", c_handler: {
			_, user_data in
			let data = unsafeBitCast(user_data,
			                         to: SignalData<Label,
																CopyClipboardCallback>.self)
			
			let label = data.obj
			let action = data.function
			
			action(label: label)
			
		})
	
	/// - Parameter label: the label on which the signal was emitted
	/// - Parameter step: the granularity of the move, as a `MovementStep`
	/// - Parameter count: the number of `step` units to move
	/// - Parameter extendSelection: `true` if the move should extend the 
	///   selection
	public typealias MoveCursorCallback = (label: Label, step: MovementStep,
		count: Int, extendSelection: Bool) -> Void
	public typealias MoveCursorNative = (GtkLabel, GtkMovementStep, gint,
		gboolean, gpointer) -> Void
	
	/// The `::moveCursor` signal is a keybinding signal which gets emitted when
	/// the user initiates a cursor movement. If the cursor is not visible in
	/// `label`, this signal causes the viewport to be moved instead.
	///
	/// Applications should not connect to it, but may emit it with `emit()` if
	/// they need to control the cursor programmatically.
	///
	/// The default bindings for this signal come in two variants, the variant with
	/// the Shift modifier extends the selection, the variant without the Shift
	/// modifer does not. There are too many key combinations to list them all
	/// here.
	///
	/// - Arrow keys move by individual characters/lines
	/// - Ctrl-arrow key combinations move by words/paragraphs
	/// - Home/End keys move to the ends of the buffer
	public lazy var moveCursorSignal:
		Signal<MoveCursorCallback, Label, MoveCursorNative> =
		Signal(obj: self, signal: "move-cursor", c_handler: {
			_, n_Step, count, extendSelection, user_data in
			let data = unsafeBitCast(user_data,
			                         to: SignalData<Label,
																MoveCursorCallback>.self)
			
			let label = data.obj
			let action = data.function
			
			action(label: label, step: MovementStep(rawValue: n_Step)!,
			       count: Int(count), extendSelection: extendSelection != 0)
			
		})

	// TODO: The “populate-popup” signal
}
