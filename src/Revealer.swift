//
//  Revealer.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 15.04.16.
//
//

import CGTK

/// The `Revealer` widget is a container which animates the transition of its 
/// child from invisible to visible.
///
/// The style of transition can be controlled with `transitionType` property.
///
/// These animations respect the `gtk-enable-animations` setting.
public class Revealer: Bin {
	internal var n_Revealer: UnsafeMutablePointer<GtkRevealer>
	
	internal init(n_Revealer: UnsafeMutablePointer<GtkRevealer>) {
		self.n_Revealer = n_Revealer
		super.init(n_Bin: UnsafeMutablePointer<GtkBin>(n_Revealer))
	}
	
	/// Creates a new `Revealer`.
	public convenience init() {
		self.init(n_Revealer: UnsafeMutablePointer<GtkRevealer>(gtk_revealer_new()))
	}
	
	/// This property is `true` as soon as the transition is to the revealed state 
	/// is started. 
	/// 
	/// Change the property tells the `Revealer` to reveal or conceal its child.
	/// The transition will be animated with the current transition type of
	/// revealer.
	///
	/// - seealso: To learn whether the child is fully revealed (ie the transition
	///   is completed), use `childRevealed` property.
	public var revealChild: Bool {
		set {
			gtk_revealer_set_reveal_child(n_Revealer, newValue ? 1 : 0)
		}
		get {
			return gtk_revealer_get_reveal_child(n_Revealer) != 0
		}
	}
	
	/// Whether the child is fully revealed, ie wether the transition to the 
	/// revealed state is completed.
	public var childRevealed: Bool {
		return gtk_revealer_get_child_revealed(n_Revealer) != 0
	}
	
	/// The amount of time (in milliseconds) that transitions will take.
	public var transitionDuration: UInt {
		set {
			gtk_revealer_set_transition_duration(n_Revealer, guint(newValue))
		}
		get {
			return UInt(gtk_revealer_get_transition_duration(n_Revealer))
		}
	}
	
	/// The type of animation that will be used for transitions in revealer. 
	/// Available types include various kinds of fades and slides.
	public var transitionType: RevealerTransitionType {
		set {
			gtk_revealer_set_transition_type(n_Revealer, newValue.rawValue)
		}
		get {
			return RevealerTransitionType(
				rawValue: gtk_revealer_get_transition_type(n_Revealer))!
		}
	}
}
