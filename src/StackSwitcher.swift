//
//  StackSwitcher.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 17.04.16.
//
//

import CGTK

/// The `StackSwitcher` widget acts as a controller for a `Stack`; it shows a 
/// row of buttons to switch between the various pages of the associated stack
/// widget.
///
/// All the content for the buttons comes from the child properties of the
/// `Stack`.
///
/// It is possible to associate multiple `StackSwitcher` widgets with the same
/// stack widget.
///
/// - Version: The `StackSwitcher` widget was added in 3.10.
public class StackSwitcher: Box {
	internal var n_StackSwitcher: UnsafeMutablePointer<GtkStackSwitcher>
	
	internal init(n_StackSwitcher: UnsafeMutablePointer<GtkStackSwitcher>) {
		self.n_StackSwitcher = n_StackSwitcher
		super.init(n_Box: UnsafeMutablePointer<GtkBox>(n_StackSwitcher))
	}
	
	/// Create a new `StackSwitcher`.
	public convenience init() {
		self.init(n_StackSwitcher:
			UnsafeMutablePointer<GtkStackSwitcher>(gtk_stack_switcher_new()))
	}
	
	private var _stack: Stack?
	
	/// Stack to control.
	public var stack: Stack? {
		set {
			if let newValue = newValue {
				gtk_stack_switcher_set_stack(n_StackSwitcher, newValue.n_Stack)
			} else {
				gtk_stack_switcher_set_stack(n_StackSwitcher, nil)
			}
		}
		get {
			let n_Stack = gtk_stack_switcher_get_stack(n_StackSwitcher)
			if n_Stack == nil {
				_stack = nil
				return nil
			}
			else if _stack?.n_Stack != n_Stack {
				print("WARNING: generate Stack obj from pointer")
				_stack = Stack(n_Stack: n_Stack)
			}
			return _stack
		}
	}
}
