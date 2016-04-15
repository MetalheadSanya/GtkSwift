//
//  WindowGroup.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 15.04.16.
//
//

import CGTK
import gobjectswift

public class WindowGroup: Object {
	internal var n_WindowGroup: UnsafeMutablePointer<GtkWindowGroup>
	
	internal init(n_WindowGroup: UnsafeMutablePointer<GtkWindowGroup>) {
		self.n_WindowGroup = n_WindowGroup
		super.init(n_Object: UnsafeMutablePointer<GObject>(n_WindowGroup))
	}
	
	public convenience init() {
		self.init(n_WindowGroup: UnsafeMutablePointer<GtkWindowGroup>(gtk_window_group_new()))
	}
	
	private var _windows = [Window]()
	
	public func addWindow(_ window: Window) {
		gtk_window_group_add_window(n_WindowGroup, window.n_Window)
		
		if !_windows.contains(window) {
			_windows.append(window)
		}
	}
	
	public func removeWindow(_ window: Window) {
		gtk_window_group_remove_window(n_WindowGroup, window.n_Window)
		
		if let index = _windows.index(of: window) {
			_windows.remove(at: index)
		}
	}
	
	public var windows: [Window] {
		return _windows
	}
	
	public func getCurrentGrub() -> Window? {
		let n_Window = UnsafeMutablePointer<GtkWindow>(gtk_window_group_get_current_grab(n_WindowGroup))
		
		guard n_Window != nil else { return nil }
		
		var window: Widget? = _windows.filter{ $0.n_Window == n_Window }.first
		
		if window == nil {
			window = Container.correctWidgetForWidget(Window(n_Window: n_Window!))
			_windows.append(window as! Window)
		}
		
		return window as? Window
	}
}
