//
//  EntryBuffer.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 06.05.16.
//
//

import CGTK
import gobjectswift

/// The `EntryBuffer` class contains the actual text displayed in a `Entry` 
/// widget.
/// A single `EntryBuffer` object can be shared by multiple `Entry` widgets
/// which will then share the same text content, but not the cursor position,
/// visibility attributes, icon etc.
///
/// `EntryBuffer` may be derived from. Such a derived class might allow text to
/// be stored in an alternate location, such as non-pageable memory, useful in
/// the case of important passwords. Or a derived class could integrate with an
/// application’s concept of undo/redo.
public class EntryBuffer: Object {
	internal var n_EntryBuffer: UnsafeMutablePointer<GtkEntryBuffer>
	
	// MARK: - Initializers
	internal init(n_EntryBuffer: UnsafeMutablePointer<GtkEntryBuffer>) {
		self.n_EntryBuffer = n_EntryBuffer
		super.init(n_Object: UnsafeMutablePointer<GObject>(n_EntryBuffer))
	}
	
	/// Create a new `EntryBuffer` object.
	/// Optionally, specify initial text to set in the buffer.
	///
	/// - Parameter text: initial buffer text, or `nil`.
	public convenience init(text: String?) {
		self.init(n_EntryBuffer:
			gtk_entry_buffer_new(text, gint(text?.characters.count ?? -1)))
	}
	
	// MARK: - Methods
	
	/// Inserts text into the contents of the buffer, at `position`.
	///
	/// Note that the position and length are in characters, not in bytes.
	///
	/// - Parameter text:     the text to insert into the buffer.
	/// - Parameter position: the position at which to insert text.
	///
	/// - Returns: The number of characters actually inserted.
	func insertText(_ text: String, atPosition position: UInt) -> UInt {
		return UInt(gtk_entry_buffer_insert_text(n_EntryBuffer, guint(position),
		                                         text, gint(text.characters.count)))
	}
	
	/// Deletes a sequence of characters from the buffer. `count` characters are
	/// deleted starting at `position`. If `count` is negative, then all
	/// characters until the end of the text are deleted.
	///
	/// If `position` or `count` are out of bounds, then they are coerced to sane
	/// values.
	///
	/// Note that the positions are specified in characters, not bytes.
	///
	/// - Parameter count:    number of characters to delete
	/// - Parameter position: position at which to delete text
	///
	/// - Returns: The number of characters deleted.
	///
	/// - Since: 2.18
	func delete(charactersCount count: Int, atPosition position: UInt) -> UInt {
		return UInt(gtk_entry_buffer_delete_text(n_EntryBuffer, guint(position),
		                                         gint(count)))
	}
	
	// MARK: - Properties
	
	/// The contents of the buffer.
	///
	/// Default value: ""
	///
	/// - Since: 2.18
	public var text: String {
		set {
			gtk_entry_buffer_set_text(n_EntryBuffer, newValue,
			                          gint(newValue.characters.count))
		}
		get {
			return String(cString: gtk_entry_buffer_get_text(n_EntryBuffer))
		}
	}
	
	/// The length (in characters) of the text in buffer.
	///
	/// Allowed values: 0...65535
	///
	/// Default value: 0
	///
	/// - Since: 2.18
	public var maxLength: Int {
		set {
			gtk_entry_buffer_set_max_length(n_EntryBuffer, gint(newValue))
		}
		get {
			return Int(gtk_entry_buffer_get_max_length(n_EntryBuffer))
		}
	}
	
	/// The length (in characters) of the text in buffer.
	///
	/// Allowed values: <= 65535
	///
	/// Default value: 0
	///
	/// - Since: 2.18
	public var length: UInt {
		return UInt(gtk_entry_buffer_get_length(n_EntryBuffer))
	}
	
	/// The length in bytes of the buffer.
	///
	/// - SeeAlso: `length` property
	///
	/// - Since: 2.18
	public var bytes: Int {
		return Int(gtk_entry_buffer_get_bytes(n_EntryBuffer))
	}
	
	// MARK: - Signals
	
	/// - Parameter buffer:   a `EntryBuffer`.
	/// - Parameter position: the position the text was deleted at.
	/// - Parameter count:    the number of characters that were deleted.
	public typealias DeletedTextCallback = (buffer: EntryBuffer, position: UInt,
		count: UInt) -> Void
	public typealias DeletedTextNative = (UnsafeMutablePointer<GtkEntryBuffer>,
		guint, guint, gpointer) -> Void
	
	/// This signal is emitted after text is deleted from the buffer.
	///
	/// - Since: 2.18
	public lazy var deletedTextSignal:
		Signal<DeletedTextCallback, EntryBuffer, DeletedTextNative> =
		Signal(obj: self, signal: "deleted-text", c_handler: {
			_ , n_Position, n_Chars, n_UserData in
			let data = unsafeBitCast(n_UserData,
			                         to: SignalData<EntryBuffer,
																DeletedTextCallback>.self)
			
			let entryBuffer = data.obj
			let action = data.function
			
			action(buffer: entryBuffer, position: UInt(n_Position),
			       count: UInt(n_Chars))
		})
	
	/// - Parameter buffer:   a `EntryBuffer`.
	/// - Parameter position: the position the text was inserted at.
	/// - Parameter text:     the text that was inserted.
	public typealias InsertedTextCallback = (buffer: EntryBuffer, position: UInt,
		text: String) -> Void
	public typealias InsertedTextNative = (UnsafeMutablePointer<GtkEntryBuffer>,
		guint, UnsafeMutablePointer<gchar>, guint, gpointer) -> Void
	
	/// This signal is emitted after text is inserted into the buffer.
	///
	/// - Since: 2.18
	public lazy var insertedTextSignal:
		Signal<InsertedTextCallback, EntryBuffer, InsertedTextNative> =
		Signal(obj: self, signal: "inserted-text", c_handler: {
			_ , n_Position, n_Chars, n_CharsCount, n_UserData in
			let data = unsafeBitCast(n_UserData,
			                         to: SignalData<EntryBuffer,
																InsertedTextCallback>.self)
			
			let entryBuffer = data.obj
			let action = data.function
			
			action(buffer: entryBuffer, position: UInt(n_Position),
			       text: String(cString: n_Chars))
		})
}
