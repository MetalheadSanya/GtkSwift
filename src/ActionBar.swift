//
//  ActionBar.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 18.04.16.
//
//

import CGTK

/// `ActionBar` is designed to present contextual actions. It is expected to be
/// displayed below the content and expand horizontally to fill the area.
///
/// It allows placing children at the start or the end. In addition, it contains
/// an internal centered box which is centered with respect to the full width of
/// the box, even if the children at either side take up different amounts of
/// space.
public class ActionBar: Bin {
	internal var n_ActionBar: UnsafeMutablePointer<GtkActionBar>
	
	internal init(n_ActionBar: UnsafeMutablePointer<GtkActionBar>) {
		self.n_ActionBar = n_ActionBar
		super.init(n_Bin: UnsafeMutablePointer<GtkBin>(n_ActionBar))
	}
	
	/// Creates a new `ActionBar` widget.
	public convenience init() {
		self.init(n_ActionBar:
			UnsafeMutablePointer<GtkActionBar>(gtk_action_bar_new()))
	}
	
	/// Adds `child` to `ActionBar`, packed with reference to the start of the
	/// `ActionBar`.
	///
	/// - Parameter child: the `Widget` to be added to `ActionBar`
	public func packStart(child: Widget) {
		guard child.parent == nil else { return }
		
		gtk_action_bar_pack_start(n_ActionBar, child.n_Widget)
		
		if !_children.contains(child) {
		_children.append(child)
		}
	}
	
	/// Adds `child` to `ActionBar`, packed with reference to the end of the
	/// `ActionBar`.
	///
	/// - Parameter child: the `Widget` to be added to `ActionBar`
	public func packEnd(child: Widget) {
		guard child.parent == nil else { return }
		
		gtk_action_bar_pack_end(n_ActionBar, child.n_Widget)
		
		if !_children.contains(child) {
			_children.append(child)
		}
	}
}
