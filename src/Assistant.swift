//
//  Assistant.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 13.04.16.
//
//

import CGTK
import gobjectswift

public typealias AssistantApplyCallback = (Assistant) -> Void
public typealias AssistantCancelCallback = (Assistant) -> Void
public typealias AssistantCloseCallback = (Assistant) -> Void
public typealias AssistantEscapeCallback = (Assistant) -> Void
//public typealias AssistantEscapeCallback = (Assistant) -> Void

public class Assistant: Window {
	
	internal var n_Assistant: UnsafeMutablePointer<GtkAssistant>
	
	internal init(n_Assistant: UnsafeMutablePointer<GtkAssistant>) {
		self.n_Assistant = n_Assistant
		super.init(n_Window: UnsafeMutablePointer<GtkWindow>(n_Assistant))
	}
	
	public convenience init() {
		let n_Assistant = gtk_assistant_new()
		self.init(n_Assistant: UnsafeMutablePointer<GtkAssistant>(n_Assistant))
	}
	
	public var currentPageIndex: Int {
		get {
			return Int(gtk_assistant_get_current_page(n_Assistant))
		}
		set {
			gtk_assistant_set_current_page(n_Assistant, gint(newValue))
		}
	}
	
	public var pagesCount: Int {
		return Int(gtk_assistant_get_n_pages(n_Assistant))
	}
	
	// TODO: gtk_assistant_get_nth_page
	
	public func prependPage(_ page: Widget) -> Int {
		return Int(gtk_assistant_prepend_page(n_Assistant, page.n_Widget))
	}
	
	public func appendPage(_ page: Widget) -> Int {
		return Int(gtk_assistant_append_page(n_Assistant, page.n_Widget))
	}
	
	public func insertPage(_ page: Widget, at index: Int) -> Int {
		return Int(gtk_assistant_insert_page(n_Assistant, page.n_Widget, gint(index)))
	}
	
	public func removePage(at index: Int) {
		gtk_assistant_remove_page(n_Assistant, gint(index))
	}
	
	// TODO: gtk_assistant_set_forward_page_func
	
	public func setType(_ pageType: AssistantPageType, forPage page: Widget) {
		gtk_assistant_set_page_type(n_Assistant, page.n_Widget, pageType.rawValue)
	}
	
	public func getTypeForPage(_ page: Widget) -> AssistantPageType {
		return AssistantPageType(rawValue: gtk_assistant_get_page_type(n_Assistant, page.n_Widget))!
	}
	
	public func setTitle(_ title: String, forPage page: Widget) {
		gtk_assistant_set_page_title(n_Assistant, page.n_Widget, title)
	}
	
	public func getTitleForPage(_ page: Widget) -> String {
		return String(cString: gtk_assistant_get_page_title(n_Assistant, page.n_Widget))
	}
	
	public func setComplete(_ complete: Bool, forPage page: Widget) {
		gtk_assistant_set_page_complete(n_Assistant, page.n_Widget, complete ? 1 : 0)
	}
	
	public func getCompleteForPage(_ page: Widget) -> Bool {
		return gtk_assistant_get_page_complete(n_Assistant, page.n_Widget) != 0 ? true : false
	}
	
	public func setHasPadding(_ hasPadding: Bool, forPage page: Widget) {
		gtk_assistant_set_page_has_padding(n_Assistant, page.n_Widget, hasPadding ? 1 : 0)
	}
	
	public func getHasPaddingForPage(_ page: Widget) -> Bool {
		return gtk_assistant_get_page_has_padding(n_Assistant, page.n_Widget) != 0 ? true : false
	}
	
	public func addActionWidget(_ widget: Widget) {
		gtk_assistant_add_action_widget(n_Assistant, widget.n_Widget)
	}
	
	public func removeActionWidget(_ widget: Widget) {
		gtk_assistant_remove_action_widget(n_Assistant, widget.n_Widget)
	}
	
	public func updateButtonsState() {
		gtk_assistant_update_buttons_state(n_Assistant)
	}
	
	public func commit() {
		gtk_assistant_commit(n_Assistant)
	}
	
	public func nextPage() {
		gtk_assistant_next_page(n_Assistant)
	}
	
	public func previousPage() {
		gtk_assistant_previous_page(n_Assistant)
	}
	
	typealias AssistantApplyNative = @convention(c)(UnsafeMutablePointer<GtkAssistant>, gpointer) -> Void
	
	lazy var applySignal: Signal<AssistantApplyCallback, Assistant, AssistantApplyNative>
		= Signal(obj: self, signal: "apply", c_handler: {
			(_, user_data) in
			let data = unsafeBitCast(user_data, to: SignalData<Assistant, AssistantApplyCallback>.self)
			
			let assistant = data.obj
			let action = data.function
			
			action(assistant)
		})
	
	typealias AssistantCancelNative = @convention(c)(UnsafeMutablePointer<GtkAssistant>, gpointer) -> Void
	
	lazy var cancelSignal: Signal<AssistantCancelCallback, Assistant, AssistantCancelNative>
		= Signal(obj: self, signal: "cancel", c_handler: {
			(_, user_data) in
			let data = unsafeBitCast(user_data, to: SignalData<Assistant, AssistantCancelCallback>.self)
			
			let assistant = data.obj
			let action = data.function
			
			action(assistant)
		})
	
	typealias AssistantCloseNative = @convention(c)(UnsafeMutablePointer<GtkAssistant>, gpointer) -> Void
	
	lazy var closeSignal: Signal<AssistantCloseCallback, Assistant, AssistantCloseNative>
		= Signal(obj: self, signal: "close", c_handler: {
			(_, user_data) in
			let data = unsafeBitCast(user_data, to: SignalData<Assistant, AssistantCloseCallback>.self)
			
			let assistant = data.obj
			let action = data.function
			
			action(assistant)
		})
	
	typealias AssistantEscapeNative = @convention(c)(UnsafeMutablePointer<GtkAssistant>, gpointer) -> Void
	
	lazy var escapeSignal: Signal<AssistantEscapeCallback, Assistant, AssistantEscapeNative>
		= Signal(obj: self, signal: "escape", c_handler: {
			(_, user_data) in
			let data = unsafeBitCast(user_data, to: SignalData<Assistant, AssistantEscapeCallback>.self)
			
			let assistant = data.obj
			let action = data.function
			
			action(assistant)
		})
}