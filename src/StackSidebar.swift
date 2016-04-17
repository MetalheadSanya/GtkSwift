//
//  StackSidebar.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 17.04.16.
//
//

import CGTK

/// A `StackSidebar` enables you to quickly and easily provide a consistent
/// `sidebar` object for your user interface.
///
/// In order to use a `StackSidebar`, you simply use a `Stack` to organize your
/// UI flow, and add the sidebar to your sidebar area. You can use `stack`
/// property to connect the `StackSidebar` to the `Stack`.
public class StackSidebar: Bin {
	internal var n_StackSidebar: UnsafeMutablePointer<GtkStackSidebar>
	
	internal init(n_StackSidebar: UnsafeMutablePointer<GtkStackSidebar>) {
		self.n_StackSidebar = n_StackSidebar
		super.init(n_Bin: UnsafeMutablePointer<GtkBin>(n_StackSidebar))
	}
	
	/// Creates a new sidebar.
	public convenience init() {
		self.init(n_StackSidebar:
			UnsafeMutablePointer<GtkStackSidebar>(gtk_stack_sidebar_new()))
	}
	
	private var _stack: Stack?
	
	/// The `Stack` associated with this `StackSidebar`.
	///
	/// The sidebar widget will automatically update according to the order
	/// (packing) and items within the given `Stack`.
	public var stack: Stack? {
		set {
			if let newValue = newValue {
				gtk_stack_sidebar_set_stack(n_StackSidebar, newValue.n_Stack)
			} else {
				gtk_stack_sidebar_set_stack(n_StackSidebar, nil)
			}
		}
		get {
			let n_Stack = gtk_stack_sidebar_get_stack(n_StackSidebar)
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