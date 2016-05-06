//
//  Entry.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 06.05.16.
//
//

import CGTK
import gobjectswift

/// The `Entry` widget is a single line text entry widget. A fairly large set of
/// key bindings are supported by default. If the entered text is longer than
/// the allocation of the widget, the widget will scroll so that the cursor
/// position is visible.
///
/// When using an entry for passwords and other sensitive information, it can be
/// put into “password mode” using `Entry.visibility` property. In this mode,
/// entered text is displayed using a “invisible” character. By default, GTK+
/// picks the best invisible character that is available in the current font,
/// but it can be changed with `Entry.invisibleCharacter` property. Since 2.16,
/// GTK+ displays a warning when Caps Lock or input methods might interfere with
/// entering text in a password entry. The warning can be turned off with the
/// `Entry.capsLockWarning` property.
///
/// Since 2.16, `Entry` has the ability to display progress or activity
/// information behind the text. To make an entry display such information, use
/// `Entry.progressFraction` property or `Entry.progressPulseStep` property.
///
/// Additionally, `Entry` can show icons at either side of the entry. These
/// icons can be activatable by clicking, can be set up as drag source and can
/// have tooltips. To add an icon, use `Entry.setIcon(fromGicon:)` or one of the
/// various other functions that set an icon from a stock id, an icon name or a
/// pixbuf. To trigger an action when the user clicks an icon, connect to the
/// `Entry.iconPressSignal`. To allow Drug and Drop operations from an icon, use
/// `Entry.setIconDragSource(iconPosition:targetList:action)`. To set a tooltip
/// on an icon, use `Entry.setIconTooltipText(_:forIconPosition:) or the
/// corresponding function for markup.
///
/// Note that functionality or information that is only available by clicking on
/// an icon in an entry may not be accessible at all to users which are not able
/// to use a mouse or other pointing device. It is therefore recommended that
/// any such functionality should also be available by other means, e.g. via the
/// context menu of the entry.
public class Entry: Widget {
	
	internal var n_Entry: UnsafeMutablePointer<GtkEntry>
	
	internal var _entryBuffer: EntryBuffer
	internal var _cursorHorizontalAdjustment: Adjustment?
	
	/// Specifies the side of the entry at which an icon is placed.
	///
	/// - Since: 2.16
	public enum IconPosition: RawRepresentable {
		/// At the beginning of the entry (depending on the text direction).
		case Primary
		/// At the end of the entry (depending on the text direction).
		case Secondary
		
		public typealias RawValue = GtkEntryIconPosition
		
		public var rawValue: RawValue {
			switch self {
			case .Primary:
				return GTK_ENTRY_ICON_PRIMARY
			case .Secondary:
				return GTK_ENTRY_ICON_SECONDARY
			}
		}
		
		public init?(rawValue: RawValue) {
			switch rawValue {
			case GTK_ENTRY_ICON_PRIMARY:
				self = .Primary
			case GTK_ENTRY_ICON_SECONDARY:
				self = .Secondary
			default:
				return nil
			}
		}
	}
	
	/// Describes primary purpose of the input widget. This information is useful
	/// for on-screen keyboards and similar input methods to decide which keys
	/// should be presented to the user.
	///
	/// Note that the purpose is not meant to impose a totally strict rule about
	/// allowed characters, and does not replace input validation. It is fine for
	/// an on-screen keyboard to let the user override the character set
	/// restriction that is expressed by the purpose. The application is expected
	/// to validate the entry contents, even if it specified a purpose.
	///
	/// The difference between `.Digits` and `.Number` is that the former accepts
	/// only digits while the latter also some punctuation (like commas or points,
	/// plus, minus) and “e” or “E” as in 3.14E+000.
	///
	/// This enumeration may be extended in the future; input methods should
	/// interpret unknown values as “free form”.
	public enum InputPurpose: RawRepresentable {
		/// Allow any character
		case FreeForm
		/// Allow only alphabetic characters
		case Alpha
		/// Allow only digits
		case Digits
		/// Edited field expects numbers
		case Number
		/// Edited field expects phone number
		case Phone
		/// Edited field expects URL
		case Url
		/// Edited field expects email address
		case Email
		/// Edited field expects the name of a person
		case Name
		/// Like `.FreeForm`, but characters are hidden
		case Password
		/// Like `Digits`, but characters are hidden
		case Pin
		
		public typealias RawValue = GtkInputPurpose
		
		public var rawValue: RawValue {
			switch self {
			case .FreeForm:
				return GTK_INPUT_PURPOSE_FREE_FORM
			case .Alpha:
				return GTK_INPUT_PURPOSE_ALPHA
			case .Digits:
				return GTK_INPUT_PURPOSE_DIGITS
			case .Number:
				return GTK_INPUT_PURPOSE_NUMBER
			case .Phone:
				return GTK_INPUT_PURPOSE_PHONE
			case .Url:
				return GTK_INPUT_PURPOSE_URL
			case .Email:
				return GTK_INPUT_PURPOSE_EMAIL
			case .Name:
				return GTK_INPUT_PURPOSE_NAME
			case .Password:
				return GTK_INPUT_PURPOSE_PASSWORD
			case .Pin:
				return GTK_INPUT_PURPOSE_PIN
			}
		}
		
		public init?(rawValue: RawValue) {
			switch rawValue {
			case GTK_INPUT_PURPOSE_FREE_FORM:
				self = .FreeForm
			case GTK_INPUT_PURPOSE_ALPHA:
				self = .Alpha
			case GTK_INPUT_PURPOSE_DIGITS:
				self = .Digits
			case GTK_INPUT_PURPOSE_NUMBER:
				self = .Number
			case GTK_INPUT_PURPOSE_PHONE:
				self = .Phone
			case GTK_INPUT_PURPOSE_URL:
				self = .Url
			case GTK_INPUT_PURPOSE_EMAIL:
				self = .Email
			case GTK_INPUT_PURPOSE_NAME:
				self = .Name
			case GTK_INPUT_PURPOSE_PASSWORD:
				self = .Password
			case GTK_INPUT_PURPOSE_PIN:
				self = .Pin
			default:
				return nil
			}
		}
	}
	
	
	/// Describes hints that might be taken into account by input methods or
	/// applications. Note that input methods may already tailor their behaviour
	/// according to the `InputPurpose` of the entry.
	///
	/// Some common sense is expected when using these flags - mixing
	/// `.Lowercase` with any of the uppercase hints makes no sense.
	///
	/// This enumeration may be extended in the future; input methods should
	/// ignore unknown values.
	///
	/// - Since: 3.6
	public struct InputHints: OptionSet {
		public typealias RawValue = GtkInputHints
		
		public let rawValue: RawValue
		
		public init(rawValue: RawValue) {
			self.rawValue = rawValue
		}
		
		/// No special behaviour suggested
		public static let None = InputHints(rawValue: GTK_INPUT_HINT_NONE)
		
		/// Suggest checking for typos
		public static let Spellcheck
			= InputHints(rawValue: GTK_INPUT_HINT_SPELLCHECK)
		
		/// Suggest not checking for typos
		public static let NoSpellcheck
			= InputHints(rawValue: GTK_INPUT_HINT_NO_SPELLCHECK)
		
		/// Suggest word completion
		public static let WordCompletion
			= InputHints(rawValue: GTK_INPUT_HINT_WORD_COMPLETION)
		
		/// Suggest to convert all text to lowercase
		public static let Lowercase
			= InputHints(rawValue: GTK_INPUT_HINT_LOWERCASE)
		
		/// Suggest to capitalize all text
		public static let UppercaseCharacters
			= InputHints(rawValue: GTK_INPUT_HINT_UPPERCASE_CHARS)
		
		/// Suggest to capitalize the first character of each word
		public static let UppercaseWords
			= InputHints(rawValue: GTK_INPUT_HINT_UPPERCASE_WORDS)
		
		/// Suggest to capitalize the first word of each sentence
		public static let UppercaseSentence
			= InputHints(rawValue: GTK_INPUT_HINT_UPPERCASE_SENTENCES)
		
		/// Suggest to not show an onscreen keyboard (e.g for a calculator that
		/// already has all the keys).
		public static let InhibitOsk
			= InputHints(rawValue: GTK_INPUT_HINT_INHIBIT_OSK)
		
		/// The text is vertical. 
		///
		/// - Since 3.18
		public static let VertivalWriting
			= InputHints(rawValue: GTK_INPUT_HINT_VERTICAL_WRITING)
		
	}
	
	// MARK: - Initializers
	
	internal init(n_Entry: UnsafeMutablePointer<GtkEntry>) {
		self.n_Entry = n_Entry
		_entryBuffer = EntryBuffer(n_EntryBuffer: gtk_entry_get_buffer(n_Entry))
		_cursorHorizontalAdjustment = Adjustment(
			n_Adjustment: gtk_entry_get_cursor_hadjustment(n_Entry))
		super.init(n_Widget: UnsafeMutablePointer<GtkWidget>(n_Entry))
	}
	
	/// Creates a new entry.
	public convenience init() {
		self.init(n_Entry: UnsafeMutablePointer<GtkEntry>(gtk_entry_new()))
	}
	
	/// Creates a new entry with the specified text buffer.
	///
	/// - Parameter buffer: the buffer to use for the new `Entry`.
	public init(buffer: EntryBuffer) {
		_entryBuffer = buffer
		n_Entry = UnsafeMutablePointer<GtkEntry>(
			gtk_entry_new_with_buffer(buffer.n_EntryBuffer))
		_cursorHorizontalAdjustment = Adjustment(
			n_Adjustment: gtk_entry_get_cursor_hadjustment(n_Entry))
		super.init(n_Widget: UnsafeMutablePointer<GtkWidget>(n_Entry))
	}
	
	// MARK: - Methods
	
	/// Unsets the invisible char previously set with `Entry.invisibleCharacter`
	/// property. So that the default invisible char is used again.
	///
	/// - Since: 2.16
	public func unsetInvisibleCharacter() {
		gtk_entry_unset_invisible_char(n_Entry)
	}
	
	/// Indicates that some progress is made, but you don’t know how much. Causes
	/// the entry’s progress indicator to enter “activity mode,” where a block
	/// bounces back and forth. Each call to `Entry.progressPulse()` causes the
	/// block to move by a little bit (the amount of movement per pulse is
	/// determined by `Entry.progressPulseStep` property).
	public func progressPulse() {
		gtk_entry_progress_pulse(n_Entry)
	}
	
	/// Sets the icon shown in the entry at the specified position from the
	/// current icon theme.
	///
	/// If the icon name isn’t known, a “broken image” icon will be displayed
	/// instead.
	///
	/// If `iconName` is `nil`, no icon will be shown in the specified position.
	///
	/// - Parameter iconName: an icon name, or `nil`.
	/// - Parameter position: the position at which to set the icon
	public func setIcon(fromIconName iconName: String?,
	                    forIconPosition position: IconPosition) {
		gtk_entry_set_icon_from_icon_name(n_Entry, position.rawValue, iconName)
	}
	
	/// Gets the type of representation being used by the icon to store image
	/// data. If the icon has no image data, the return value will be
	/// `.Empty`.
	///
	/// - Parameter position: icon position
	///
	/// - Returns: image representation being used
	public func getIconStorageType(forIcon position: IconPosition) -> ImageType {
		return ImageType(rawValue:
			gtk_entry_get_icon_storage_type(n_Entry, position.rawValue))!
	}
	
	/// Retrieves the icon name used for the icon, or `nil` if there is no icon or
	/// if the icon was set by some other method (e.g., by pixbuf, stock or
	/// gicon).
	///
	/// - Parameter position: icon position
	///
	/// - Returns: An icon name, or `nil` if no icon is set or if the icon wasn’t
	/// set from an icon name.
	///
	/// - Since: 2.16
	public func getIconName(forIcon position: IconPosition) -> String? {
		if let name = gtk_entry_get_icon_name(n_Entry, position.rawValue) {
			return String(cString: name)
		} else {
			return nil
		}
	}
	
	/// Sets whether the icon is activatable.
	/// 
	/// - Parameter activable: `true` if the icon should be activatable
	/// - Parameter position:  icon position
	///
	/// - Since: 2.16
	public func setActivable(_ activable: Bool,
	                         iconWithPosition position: IconPosition) {
		gtk_entry_set_icon_activatable(n_Entry, position.rawValue,
		                               activable ? 1 : 0)
	}
	
	/// Returns whether the icon is activatable.
	///
	/// - Parameter position: icon position
	///
	/// - Returns: `true` if the icon is activatable.
	///
	/// - Since: 2.16
	public func getActivableForIcon(withPosition position: IconPosition) -> Bool {
		return gtk_entry_get_icon_activatable(n_Entry, position.rawValue) != 0
	}
	
	/// Sets the sensitivity for the specified icon.
	///
	/// - Parameter activable: `true` if the icon should be activatable
	/// - Parameter sensitive: specifies whether the icon should appear sensitive
	///   or insensitive
	///
	/// - Since: 2.16
	public func setSensitive(_ sensitive: Bool,
	                         iconWithPosition position: IconPosition) {
		gtk_entry_set_icon_sensitive(n_Entry, position.rawValue, sensitive ? 1 : 0)
	}
	
	/// Returns whether the icon appears sensitive or insensitive.
	///
	/// - Parameter position: icon position
	///
	/// - Returns: `true` if the icon is sensitive.
	///
	/// - Since: 2.16
	public func getSensitiveForIcon(withPosition position: IconPosition) -> Bool {
		return gtk_entry_get_icon_sensitive(n_Entry, position.rawValue) != 0
	}
	
	/// Finds the icon at the given position and return its index. The position’s
	/// coordinates are relative to the entry ’s top left corner. If `x`, `y`
	/// doesn’t lie inside an icon, -1 is returned. This function is intended for
	/// use in a `Entry.queryTooltipSignal` handler.
	///
	/// - Parameter x: the x coordinate of the position to find
	/// - Parameter y: the y coordinate of the position to find
	///
	/// - Returns: the index of the icon at the given position, or -1
	///
	/// - Since: 2.16
	public func getIconIndex(atX x: Int, andY y: Int) -> Int {
		return Int(gtk_entry_get_icon_at_pos(n_Entry, gint(x), gint(y)))
	}
	
	/// Sets tooltip as the contents of the tooltip for the icon at the specified
	/// position.
	///
	/// Use `nil` for tooltip to remove an existing tooltip.
	///
	/// - Parameter text:     the contents of the tooltip for the icon, or `nil`.
	/// - Parameter position: the icon position
	///
	/// - SeeAlso `Widget.tooltipText` and
	///   `Entry.setTooltipMarkup(_:forIconAtPosition:)`.
	public func setTooltipText(_ text: String?,
	                           forIconAtPosition position: IconPosition) {
		gtk_entry_set_icon_tooltip_text(n_Entry, position.rawValue, text)
	}
	
	/// Gets the contents of the tooltip on the icon at the specified position in
	/// entry.
	/// 
	/// - Parameter position: the icon position
	///
	/// - Returns: the tooltip text, or `nil`.
	public func getTooltipTextForIcon(withPosition position: IconPosition)
		-> String? {
			let ptr = gtk_entry_get_icon_tooltip_text(n_Entry, position.rawValue)
			let str: String?
			if let ptr = ptr {
				str = String(cString: ptr)
			} else { str = nil }
			g_free(ptr)
			return str
	}
	
	/// Sets tooltip as the contents of the tooltip for the icon at the specified
	/// position. tooltip is assumed to be marked up with the Pango text markup
	/// language.
	/// 
	/// Use `nil` for tooltip to remove an existing tooltip.
	///
	/// - SeeAlso: `Widget.tooltipMarkup` and 
	///   `Entry.setTooltipText(_:forIconAtPosition:).
	///
	/// - Parameter markup:   the contents of the tooltip for the icon, or `nil`.
	/// - Parameter position: the icon position
	///
	/// - SeeAlso `Widget.tooltipText` and
	///   `Entry.setTooltipMarkup(_:forIconAtPosition:)`.
	public func setTooltipMarkup(_ markup: String?,
	                           forIconAtPosition position: IconPosition) {
		gtk_entry_set_icon_tooltip_markup(n_Entry, position.rawValue, markup)
	}
	
	/// Gets the contents of the tooltip on the icon at the specified position in
	/// entry.
	///
	/// - Parameter position: the icon position
	///
	/// - Returns: the tooltip text, or `nil`.
	public func getTooltipMarkupForIcon(withPosition position: IconPosition)
		-> String? {
			let ptr = gtk_entry_get_icon_tooltip_markup(n_Entry, position.rawValue)
			let str: String?
			if let ptr = ptr {
				str = String(cString: ptr)
			} else { str = nil }
			g_free(ptr)
			return str
	}
	
	// MARK: - Properties
	
	/// Text buffer object which actually stores entry text.
	///
	/// - Since: 2.18
	public var buffer: EntryBuffer {
		get {
			guard gtk_entry_get_buffer(n_Entry) == _entryBuffer.n_EntryBuffer
				else { fatalError() }
			return _entryBuffer
		}
		set {
			_entryBuffer = newValue
			gtk_entry_set_buffer(n_Entry, _entryBuffer.n_EntryBuffer)
		}
	}
	
	/// The contents of the entry.
	///
	/// Default value: ""
	///
	/// - SeeAlso: `EntryBuffet.text` property
	public var text: String {
		set {
			gtk_entry_set_text(n_Entry, newValue)
		}
		get {
			return String(cString: gtk_entry_get_text(n_Entry))
		}
	}
	
	/// The length of the text in the `Entry`.
	///
	/// Allowed values: <= 65535
	///
	/// Default value: 0
	///
	/// - Since: 2.14
	public var length: UInt {
		return UInt(gtk_entry_get_text_length(n_Entry))
	}
	
	/// The area where the entry’s text is drawn. This property is useful when
	/// drawing something to the entry in a draw callback.
	///
	/// If the entry is not realized, textArea is filled with zeros.
	///
	/// - Since: 3.0
	public var textArea: Rectangle {
		let n_Rectangle: UnsafeMutablePointer<GdkRectangle>? = nil
		gtk_entry_get_text_area(n_Entry, n_Rectangle)
		return Rectangle(n_Rectangle: n_Rectangle!)
	}
	
	/// `false` displays the "invisible char" instead of the actual text (password
	/// mode).
	///
	/// Default value: `true`
	public var visibility: Bool {
		set {
			gtk_entry_set_visibility(n_Entry, newValue ? 1 : 0)
		}
		get {
			return gtk_entry_get_visibility(n_Entry) != 0
		}
	}
	
	/// The invisible character is used when masking entry contents (in
	/// "password mode"). When it is not explicitly set with the
	/// `Entry.invisibleCharacter` property, GTK+ determines the character to use
	/// from a list of possible candidates, depending on availability in the
	/// current font.
	///
	/// This style property allows the theme to prepend a character to the list of
	/// candidates.
	///
	/// Default value: "*"
	///
	/// - Since: 2.18
	public var invisibleCharacter: Character {
		set {
			let str = String(newValue)
			let scalars = str.unicodeScalars
			let scalar = scalars[scalars.startIndex]
			gtk_entry_set_invisible_char(n_Entry, scalar.value)
		}
		get {
			let scalar = UnicodeScalar(gtk_entry_get_invisible_char(n_Entry))
			return Character(scalar)
		}
	}
	
	/// Maximum number of characters for this entry. Zero if no maximum.
	///
	/// Allowed values: 0...65535
	///
	/// Default value: 0
	public var maxLenght: Int {
		set {
			gtk_entry_set_max_length(n_Entry, gint(newValue))
		}
		get {
			return Int(gtk_entry_get_max_length(n_Entry))
		}
	}
	
	/// Whether to activate the default widget (such as the default button in a
	/// dialog) when Enter is pressed.
	///
	/// Default value: `false`
	public var activatesDefault: Bool {
		set {
			gtk_entry_set_activates_default(n_Entry, newValue ? 1 : 0)
		}
		get {
			return gtk_entry_get_activates_default(n_Entry) != 0
		}
	}
	
	/// `false` removes outside bevel from entry.
	///
	/// Default value: `true`
	public var hasFrame: Bool {
		set {
			gtk_entry_set_has_frame(n_Entry, newValue ? 1 : 0)
		}
		get {
			return gtk_entry_get_has_frame(n_Entry) != 0
		}
	}
	
	/// Number of characters to leave space for in the entry.
	///
	/// Allowed values: >= -1
	///
	/// Default value: -1
	public var widthCharcters: Int {
		set {
			gtk_entry_set_width_chars(n_Entry, gint(newValue))
		}
		get {
			return Int(gtk_entry_get_width_chars(n_Entry))
		}
	}
	
	/// The desired maximum width of the entry, in characters. If this property is
	/// set to -1, the width will be calculated automatically.
	///
	/// Allowed values: >= -1
	///
	/// Default value: -1
	///
	/// - Since: 3.12
	public var maxWidthCharcters: Int {
		set {
			gtk_entry_set_max_width_chars(n_Entry, gint(newValue))
		}
		get {
			return Int(gtk_entry_get_max_width_chars(n_Entry))
		}
	}
	
	/// The horizontal alignment, from 0 (left) to 1 (right). Reversed for Right
	/// To Left layouts.
	///
	/// Allowed values: 0...1
	///
	/// Default value: 0
	///
	/// - Since: 2.4
	public var alignment: Double {
		set {
			gtk_entry_set_alignment(n_Entry, gfloat(newValue))
		}
		get {
			return Double(gtk_entry_get_alignment(n_Entry))
		}
	}
	
	/// The text that will be displayed in the `Entry` when it is empty and
	/// unfocused.
	///
	/// Default value: `nil`
	///
	/// - Since: 3.2
	public var placeholder: String? {
		set {
			gtk_entry_set_placeholder_text(n_Entry, newValue)
		}
		get {
			return String(cString: gtk_entry_get_placeholder_text(n_Entry))
		}
	}
	
	/// If text is overwritten when typing in the `Entry`.
	///
	/// Default value: `false`
	///
	/// - Since: 2.14
	public var overwriteMode: Bool {
		set {
			gtk_entry_set_overwrite_mode(n_Entry, newValue ? 1 : 0)
		}
		get {
			return gtk_entry_get_overwrite_mode(n_Entry) != 0
		}
	}
	
	//	public var layoutOffset: Point {
	//		var x: gint = 0
	//		var y: gint = 0
	//
	//		gtk_entry_get_layout_offsets(n_Entry, &x, &y)
	//
	//		return Point(x: Int(x), y: Int(y))
	//	}
	
	/// Hooks up an adjustment to the cursor position in an entry, so that when
	/// the cursor is moved, the adjustment is scrolled to show that position.
	///
	/// The adjustment has to be in pixel units and in the same coordinate system
	/// as the entry.
	///
	/// - Since: 2.12
	public var cursorHorizontalAdjustment: Adjustment? {
		set {
			_cursorHorizontalAdjustment = newValue
			gtk_entry_set_cursor_hadjustment(n_Entry, newValue?.n_Adjustment)
		}
		get {
			guard gtk_entry_get_cursor_hadjustment(n_Entry)
				== _cursorHorizontalAdjustment?.n_Adjustment
				else { fatalError() }
			return _cursorHorizontalAdjustment
		}
	}
	
	/// The current fraction of the task that's been completed.
	///
	/// Allowed values: 0...1
	///
	/// Default value: 0
	///
	/// - Since: 2.16
	public var progressFraction: Double {
		set {
			gtk_entry_set_progress_fraction(n_Entry, gdouble(newValue))
		}
		get {
			return Double(gtk_entry_get_progress_fraction(n_Entry))
		}
	}
	
	/// The fraction of total entry width to move the progress bouncing block for
	/// each call to `Entry.progressPulse()`.
	///
	/// Allowed values: 0...1
	///
	/// Default value: 0.1
	/// 
	/// - Since: 2.16
	public var progressPulseStep: Double {
		set {
			gtk_entry_set_progress_pulse_step(n_Entry, gdouble(newValue))
		}
		get {
			return Double(gtk_entry_get_progress_pulse_step(n_Entry))
		}
	}
	
	/// The purpose of this text field.
	///
	/// This property can be used by on-screen keyboards and other input methods
	/// to adjust their behaviour.
	/// Note that setting the purpose to `.Password` or `.Pin` is independent from
	/// setting `Entry.visibility`.
	///
	/// Default value: `.FreeForm`
	///
	/// - Since: 3.6
	public var inputPurpose: InputPurpose {
		set {
			gtk_entry_set_input_purpose(n_Entry, newValue.rawValue)
		}
		get {
			return InputPurpose(rawValue: gtk_entry_get_input_purpose(n_Entry))!
		}
	}
	
	/// Additional hints (beyond `Entry.inputPurpose`) that allow input methods to
	/// fine-tune their behaviour.
	///
	/// - Since: 3.6
	public var inputHints: InputHints {
		set {
			gtk_entry_set_input_hints(n_Entry, newValue.rawValue)
		}
		get {
			return InputHints(rawValue: gtk_entry_get_input_hints(n_Entry))
		}
	}
	
	// MARK: - Signals
	
	/// - Parameter entry: the entry on which the signal is emitted
	public typealias ActivateCallback = (entry: Entry) -> Void
	public typealias ActivateNative = (UnsafeMutablePointer<GtkEntry>,
		gpointer) -> Void
	
	/// The `::activate` signal is emitted when the user hits the Enter key.
	///
	/// While this signal is used as a keybinding signal, it is also commonly used
	/// by applications to intercept activation of entries.
	///
	/// The default bindings for this signal are all forms of the Enter key.
	public lazy var activateSignal:
		Signal<ActivateCallback, Entry, ActivateNative> =
		Signal(obj: self, signal: "activate", c_handler: {
			_, n_UserData in
			let data = unsafeBitCast(n_UserData,
			                         to: SignalData<Entry, ActivateCallback>.self)
			
			let entry = data.obj
			let action = data.function
			
			action(entry: entry)
		})
	
	/// - Parameter entry: the entry on which the signal is emitted
	public typealias BackspaceCallback = (entry: Entry) -> Void
	public typealias BackspaceNative = (UnsafeMutablePointer<GtkEntry>,
		gpointer) -> Void
	
	/// The `::backspace` signal is a keybinding signal which gets emitted when
	/// the user asks for it.
	///
	/// The default bindings for this signal are Backspace and Shift-Backspace.
	public lazy var backspaceSignal:
		Signal<BackspaceCallback, Entry, BackspaceNative> =
		Signal(obj: self, signal: "backspace", c_handler: {
			_, n_UserData in
			let data = unsafeBitCast(n_UserData,
			                         to: SignalData<Entry, BackspaceCallback>.self)
			
			let entry = data.obj
			let action = data.function
			
			action(entry: entry)
		})
	
	/// - Parameter entry: the entry on which the signal is emitted
	public typealias CopyClipboardCallback = (entry: Entry) -> Void
	public typealias CopyClipboardNative = (UnsafeMutablePointer<GtkEntry>,
		gpointer) -> Void
	
	/// The `::copy-clipboard` signal is a keybinding signal which gets emitted to
	/// copy the selection to the clipboard.
	///
	/// The default bindings for this signal are Ctrl-c and Ctrl-Insert.
	public lazy var copyClipboardSignal:
		Signal<CopyClipboardCallback, Entry, CopyClipboardNative> =
		Signal(obj: self, signal: "copy-clipboard", c_handler: {
			_, n_UserData in
			let data = unsafeBitCast(n_UserData,
			                         to: SignalData<Entry,
																CopyClipboardCallback>.self)
			
			let entry = data.obj
			let action = data.function
			
			action(entry: entry)
		})

	/// - Parameter entry: the entry on which the signal is emitted
	public typealias CutClipboardCallback = (entry: Entry) -> Void
	public typealias CutClipboardNative = (UnsafeMutablePointer<GtkEntry>,
		gpointer) -> Void
	
	/// The `::cut-clipboard` signal is a keybinding signal which gets emitted to
	/// cut the selection to the clipboard.
	///
	/// The default bindings for this signal are Ctrl-x and Shift-Delete.
	public lazy var cutClipboardSignal:
		Signal<CopyClipboardCallback, Entry, CopyClipboardNative> =
		Signal(obj: self, signal: "cut-clipboard", c_handler: {
			_, n_UserData in
			let data = unsafeBitCast(n_UserData,
			                         to: SignalData<Entry,
																CutClipboardCallback>.self)
			
			let entry = data.obj
			let action = data.function
			
			action(entry: entry)
		})
	
	/// - Parameter entry: the entry on which the signal is emitted
	/// - Parameter type:  the granularity of the deletion, as a `DeleteType`
	/// - Parameter count: the number of `type` units to delete
	public typealias DeleteFromCursorCallback = (entry: Entry, type: DeleteType,
		count: Int) -> Void
	public typealias DeleteFromCursorNative = (UnsafeMutablePointer<GtkEntry>,
		GtkDeleteType, gint, gpointer) -> Void
	
	/// The `::delete-from-cursor` signal is a keybinding signal which gets
	/// emitted when the user initiates a text deletion.
	///
	/// If the type is `.Characters`, GTK+ deletes the selection if there is one,
	/// otherwise it deletes the requested number of characters.
	///
	/// The default bindings for this signal are Delete for deleting a character
	/// and Ctrl-Delete for deleting a word.
	public lazy var deleteFromCursorSignal:
		Signal<DeleteFromCursorCallback, Entry, DeleteFromCursorNative> =
		Signal(obj: self, signal: "delete-from-cursor", c_handler: {
			_, n_Type, n_Count, n_UserData in
			let data = unsafeBitCast(n_UserData,
			                         to: SignalData<Entry,
																DeleteFromCursorCallback>.self)
			
			let entry = data.obj
			let action = data.function
			
			action(entry: entry, type: DeleteType(rawValue: n_Type)!, count:
				Int(n_Count))
		})
	
	/// - Parameter entry: the entry on which the signal is emitted
	/// - Parameter text:  the string to insert
	public typealias InsertAtCursorCallback = (entry: Entry, text: String) -> Void
	public typealias InsertAtCursorNative = (UnsafeMutablePointer<GtkEntry>,
		UnsafeMutablePointer<gchar>, gpointer) -> Void
	
	/// The `::delete-from-cursor` signal is a keybinding signal which gets
	/// emitted when the user initiates a text deletion.
	///
	/// If the type is `.Characters`, GTK+ deletes the selection if there is one,
	/// otherwise it deletes the requested number of characters.
	///
	/// The default bindings for this signal are Delete for deleting a character
	/// and Ctrl-Delete for deleting a word.
	public lazy var insertAtCursorSignal:
		Signal<InsertAtCursorCallback, Entry, InsertAtCursorNative> =
		Signal(obj: self, signal: "insert-at-cursor", c_handler: {
			_, n_String, n_UserData in
			let data = unsafeBitCast(n_UserData,
			                         to: SignalData<Entry,
																InsertAtCursorCallback>.self)
			
			let entry = data.obj
			let action = data.function
			
			action(entry: entry, text: String(cString: n_String))
		})
	
	/// - Parameter entry: the entry on which the signal is emitted
	/// - Parameter step: the granularity of the move, as a `MovementStep`
	/// - Parameter count: the number of `step` units to move
	/// - Parameter extendSelection: `true` if the move should extend the
	///   selection
	public typealias MoveCursorCallback = (entry: Entry, step: MovementStep,
		count: Int, extendSelection: Bool) -> Void
	public typealias MoveCursorNative = (UnsafeMutablePointer<GtkEntry>,
		GtkMovementStep, gint, gboolean, gpointer) -> Void
	
	/// The `::move-cursor` signal is a keybinding signal which gets emitted when
	/// the user initiates a cursor movement. If the cursor is not visible in
	/// entry , this signal causes the viewport to be moved instead.
	///
	///	Applications should not connect to it, but may emit it with
	/// `Signal.emit()` if they need to control the cursor programmatically.
	///
	/// The default bindings for this signal come in two variants, the variant
	/// with the Shift modifier extends the selection, the variant without the
	/// Shift modifer does not. There are too many key combinations to list them
	/// all here.
	/// - Arrow keys move by individual characters/lines
	/// - Ctrl-arrow key combinations move by words/paragraphs
	/// - Home/End keys move to the ends of the buffer	
	public lazy var moveCursorSignal:
		Signal<MoveCursorCallback, Entry, MoveCursorNative> =
		Signal(obj: self, signal: "move-cursor", c_handler: {
			_, n_Step, n_Count, n_ExtendSelection, n_UserData in
			let data = unsafeBitCast(n_UserData,
			                         to: SignalData<Entry,
																MoveCursorCallback>.self)
			
			let entry = data.obj
			let action = data.function
			
			action(entry: entry, step: MovementStep(rawValue: n_Step)!,
			       count: Int(n_Count), extendSelection: n_ExtendSelection != 0)
		})
	
	/// - Parameter entry: the entry on which the signal is emitted
	public typealias PasteClipboardCallback = (entry: Entry) -> Void
	public typealias PasteClipboardNative = (UnsafeMutablePointer<GtkEntry>,
		gpointer) -> Void
	
	/// The `::paste-clipboard` signal is a keybinding signal which gets emitted
	/// to paste the contents of the clipboard into the text view.
	///
	/// The default bindings for this signal are Ctrl-v and Shift-Insert.	
	public lazy var pasteClipboardSignal:
		Signal<PasteClipboardCallback, Entry, PasteClipboardNative> =
		Signal(obj: self, signal: "paste-clipboard", c_handler: {
			_, n_UserData in
			let data = unsafeBitCast(n_UserData,
			                         to: SignalData<Entry,
																PasteClipboardCallback>.self)
			
			let entry = data.obj
			let action = data.function
			
			action(entry: entry)
		})
	
	/// - Parameter entry: the entry on which the signal is emitted
	/// - Parameter preedit: the current preedit string
	public typealias PreeditChangedCallback = (entry: Entry, preedit: String)
		-> Void
	public typealias PreeditChangedNative = (UnsafeMutablePointer<GtkEntry>,
		UnsafeMutablePointer<gchar>, gpointer) -> Void
	
	/// If an input method is used, the typed text will not immediately be
	/// committed to the buffer. So if you are interested in the text, connect to
	/// this signal.
	///
	/// - Since: 2.20
	public lazy var preeditChangedSignal:
		Signal<PreeditChangedCallback, Entry, PreeditChangedNative> =
		Signal(obj: self, signal: "preedit-changed", c_handler: {
			_, n_String, n_UserData in
			let data = unsafeBitCast(n_UserData,
			                         to: SignalData<Entry,
																PreeditChangedCallback>.self)
			
			let entry = data.obj
			let action = data.function
			
			action(entry: entry, preedit: String(cString: n_String))
		})
	
	/// - Parameter entry: the entry on which the signal is emitted
	public typealias ToggleOverwriteCallback = (entry: Entry) -> Void
	public typealias ToggleOverwriteNative = (UnsafeMutablePointer<GtkEntry>,
		gpointer) -> Void
	
	/// The ::toggle-overwrite signal is a keybinding signal which gets emitted to
	/// toggle the overwrite mode of the entry.
	///
	/// The default bindings for this signal is Insert.
	public lazy var toggleOverwriteSignal:
		Signal<ToggleOverwriteCallback, Entry, ToggleOverwriteNative> =
		Signal(obj: self, signal: "toggle-overwrite", c_handler: {
			_, n_UserData in
			let data = unsafeBitCast(n_UserData,
			                         to: SignalData<Entry,
																ToggleOverwriteCallback>.self)
			
			let entry = data.obj
			let action = data.function
			
			action(entry: entry)
		})
}

extension GtkInputHints: BitwiseOperations {
	public static var allZeros: GtkInputHints {
 		return GTK_INPUT_HINT_NONE
	}
}

public func &(lhs: GtkInputHints, rhs: GtkInputHints) -> GtkInputHints {
	return GtkInputHints(rawValue: lhs.rawValue & rhs.rawValue)
}

public func |(lhs: GtkInputHints, rhs: GtkInputHints) -> GtkInputHints {
	return GtkInputHints(rawValue: lhs.rawValue | rhs.rawValue)
}

public func ^(lhs: GtkInputHints, rhs: GtkInputHints) -> GtkInputHints {
	return GtkInputHints(rawValue: lhs.rawValue ^ rhs.rawValue)
}

prefix public func ~(x: GtkInputHints) -> GtkInputHints {
	return GtkInputHints(rawValue: ~x.rawValue)
}

// TODO: var and func with pango-swift
// TODO: completion
// TODO: images