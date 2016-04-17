//
//  Stack.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 16.04.16.
//
//

import CGTK

/// The `Stack` widget is a container which only shows one of its children at a
/// time. In contrast to `Notebook`, `Stack` does not provide a means for users
/// to change the visible child. Instead, the `StackSwitcher` widget can be used
/// with `Stack` to provide this functionality.
///
/// Transitions between pages can be animated as slides or fades. This can be
/// controlled with `transitionType` property. These animations respect the 
/// “gtk-enable-animations” setting.
///
/// - Version: The `Stack` widget was added in GTK+ 3.10.
public class Stack: Container {
	/// These enumeration values describe the possible transitions between pages
	/// in a `Stack` widget.
	///
	/// New values may be added to this enumeration over time.
	public enum TransitionType: RawRepresentable {
		/// No transition
		case None
		/// A cross-fade
		case Crossfade
		/// Slide from left to right
		case SlideRight
		/// Slide from right to left
		case SlideLeft
		/// Slide from bottom up
		case SlideUp
		/// Slide from top down
		case SlideDown
		/// Slide from left or right according to the children order
		case SlideLeftRight
		/// Slide from top down or bottom up according to the order
		case SlideUpDown
		/// Cover the old page by sliding up. 
		///
		/// - Version: Since 3.12
		case OverUp
		/// Cover the old page by sliding down. 
		///
		/// - Version: Since: 3.12
		case OverDown
		/// Cover the old page by sliding to the left. 
		///
		/// - Version: Since: 3.12
		case OverLeft
		/// Cover the old page by sliding to the right. 
		///
		/// - Version: Since: 3.12
		case OverRight
		/// Uncover the new page by sliding up. 
		///
		/// - Version: Since 3.12
		case UnderUp
		/// Uncover the new page by sliding down. 
		///
		/// - Version: Since: 3.12
		case UnderDown
		/// Uncover the new page by sliding to the left. 
		///
		/// - Version: Since: 3.12
		case UnderLeft
		/// Uncover the new page by sliding to the right. 
		///
		/// - Version: Since: 3.12
		case UnderRight
		/// Cover the old page sliding up or uncover the new page sliding down,
		/// according to order.
		///
		/// - Version: Since: 3.12
		case OverUpDown
		/// Cover the old page sliding down or uncover the new page sliding up,
		/// according to order. 
		///
		/// Since: 3.14
		case OverDownUp
		/// Cover the old page sliding left or uncover the new page sliding right,
		/// according to order. 
		///
		/// - Veriosn: Since: 3.14
		case OverLeftRight
		/// Cover the old page sliding right or uncover the new page sliding left,
		/// according to order. 
		///
		/// - Version: Since: 3.14
		case OverRightLeft

		public typealias RawValue = GtkStackTransitionType
		
		public var rawValue: RawValue {
			switch self {
			case .None:
				return GTK_STACK_TRANSITION_TYPE_NONE
			case .Crossfade:
				return GTK_STACK_TRANSITION_TYPE_CROSSFADE
			case .SlideRight:
				return GTK_STACK_TRANSITION_TYPE_SLIDE_RIGHT
			case .SlideLeft:
				return GTK_STACK_TRANSITION_TYPE_SLIDE_LEFT
			case .SlideUp:
				return GTK_STACK_TRANSITION_TYPE_SLIDE_UP
			case .SlideDown:
				return GTK_STACK_TRANSITION_TYPE_SLIDE_DOWN
			case .SlideLeftRight:
				return GTK_STACK_TRANSITION_TYPE_SLIDE_LEFT_RIGHT
			case .SlideUpDown:
				return GTK_STACK_TRANSITION_TYPE_SLIDE_UP_DOWN
			case .OverUp:
				return GTK_STACK_TRANSITION_TYPE_OVER_UP
			case .OverDown:
				return GTK_STACK_TRANSITION_TYPE_OVER_DOWN
			case .OverLeft:
				return GTK_STACK_TRANSITION_TYPE_OVER_LEFT
			case .OverRight:
				return GTK_STACK_TRANSITION_TYPE_OVER_RIGHT
			case .UnderUp:
				return GTK_STACK_TRANSITION_TYPE_UNDER_UP
			case .UnderDown:
				return GTK_STACK_TRANSITION_TYPE_UNDER_DOWN
			case .UnderLeft:
				return GTK_STACK_TRANSITION_TYPE_UNDER_LEFT
			case .UnderRight:
				return GTK_STACK_TRANSITION_TYPE_UNDER_RIGHT
			case .OverUpDown:
				return GTK_STACK_TRANSITION_TYPE_OVER_UP_DOWN
			case .OverDownUp:
				return GTK_STACK_TRANSITION_TYPE_OVER_DOWN_UP
			case .OverLeftRight:
				return GTK_STACK_TRANSITION_TYPE_OVER_LEFT_RIGHT
			case .OverRightLeft:
				return GTK_STACK_TRANSITION_TYPE_OVER_RIGHT_LEFT
			}
		}
		
		public init?(rawValue: RawValue) {
			switch rawValue {
			case GTK_STACK_TRANSITION_TYPE_NONE:
				self = .None
			case GTK_STACK_TRANSITION_TYPE_CROSSFADE:
				self = .Crossfade
			case GTK_STACK_TRANSITION_TYPE_SLIDE_RIGHT:
				self = .SlideRight
			case GTK_STACK_TRANSITION_TYPE_SLIDE_LEFT:
				self = .SlideLeft
			case GTK_STACK_TRANSITION_TYPE_SLIDE_UP:
				self = .SlideUp
			case GTK_STACK_TRANSITION_TYPE_SLIDE_DOWN:
				self = .SlideDown
			case GTK_STACK_TRANSITION_TYPE_SLIDE_LEFT_RIGHT:
				self = .SlideLeftRight
			case GTK_STACK_TRANSITION_TYPE_SLIDE_UP_DOWN:
				self = .SlideUpDown
			case GTK_STACK_TRANSITION_TYPE_OVER_UP:
				self = .OverUp
			case GTK_STACK_TRANSITION_TYPE_OVER_DOWN:
				self = .OverDown
			case GTK_STACK_TRANSITION_TYPE_OVER_LEFT:
				self = .OverLeft
			case GTK_STACK_TRANSITION_TYPE_OVER_RIGHT:
				self = .OverRight
			case GTK_STACK_TRANSITION_TYPE_UNDER_UP:
				self = .UnderUp
			case GTK_STACK_TRANSITION_TYPE_UNDER_DOWN:
				self = .UnderDown
			case GTK_STACK_TRANSITION_TYPE_UNDER_LEFT:
				self = .UnderLeft
			case GTK_STACK_TRANSITION_TYPE_UNDER_RIGHT:
				self = .UnderRight
			case GTK_STACK_TRANSITION_TYPE_OVER_UP_DOWN:
				self = .OverUpDown
			case GTK_STACK_TRANSITION_TYPE_OVER_DOWN_UP:
				self = .OverDownUp
			case GTK_STACK_TRANSITION_TYPE_OVER_LEFT_RIGHT:
				self = .OverLeftRight
			case GTK_STACK_TRANSITION_TYPE_OVER_RIGHT_LEFT:
				self = .OverRightLeft
			default:
				return nil
			}
		}
	}
	
	internal var n_Stack: UnsafeMutablePointer<GtkStack>
	
	internal init(n_Stack: UnsafeMutablePointer<GtkStack>) {
		self.n_Stack = n_Stack
		super.init(n_Container: UnsafeMutablePointer<GtkContainer>(n_Stack))
	}
	
	/// Creates a new `Stack` container.
	public convenience init() {
		self.init(n_Stack: UnsafeMutablePointer<GtkStack>(gtk_stack_new()))
	}
	
	/// Adds a child to stack. The child is identified by the `name`.
	///
	/// - Parameter child: the widget to add
	/// - Patameter name: the name for `child`
	public func add(child: Widget, withName name: String) {
		guard child.parent == nil else { return }
		gtk_stack_add_named(n_Stack, child.n_Widget, name)
		
		if !_children.contains(child) {
			_children.append(child)
		}
	}
	
	/// Adds a child to stack. The child is identified by the `name`. The title 
	/// will be used by `StackSwitcher` to represent child in a tab bar, so it
	/// should be short.
	///
	/// - Parameter child: the widget to add
	/// - Parameter name: the name for `child`
	/// - Parameter title: a human-readable title for `child`
	public func add(child: Widget, withName name: String,
	                andTitle title: String) {
		guard child.parent == nil else { return }
		gtk_stack_add_titled(n_Stack, child.n_Widget, name, title)
		
		if !_children.contains(child) {
			_children.append(child)
		}
	}
	
	/// Finds the child of the `Stack` with the name given as the argument. 
	/// Returns `nil` if there is no child with this name.
	///
	/// - Parameter name: the name of the child to find
	///
	/// - Returns: The requested child of the `Stack`.
	public func child(byName name: String) -> Widget? {
		let pointer = gtk_stack_get_child_by_name(n_Stack, name)
		guard pointer != nil else { return nil }
		return _childWithPointer(pointer)
	}
	
	/// Makes child the visible child of stack.
	///
	/// If `child` is different from the currently visible child, the transition
	/// between the two will be animated with the current transition type of 
	/// stack.
	///
	/// Note that the `child` widget has to be visible itself (see `show()`) in
	/// order to become the visible child of stack.
	/// 
	/// - Parameter child: a child of stack
	public func setVisible(child: Widget) {
		gtk_stack_set_visible_child(n_Stack, child.n_Widget)
	}
	
	/// The currently visible child of stack, or `nil` if there are no
	/// visible children.
	public var visibleChild: Widget? {
		let pointer = gtk_stack_get_visible_child(n_Stack)
		guard pointer != nil else { return nil }
		return _childWithPointer(pointer)
	}
	
	/// Makes the child with the given name visible.
	///
	/// If child is different from the currently visible child, the transition
	/// between the two will be animated with the current transition type of 
	/// stack.
	///
	/// Note that the child widget has to be visible itself (see `show()`) in 
	/// order to become the visible child of stack .
	///
	/// - Parameter name: the name of the child to make visible
	public func setVisible(childWithName name: String) {
		gtk_stack_set_visible_child_name(n_Stack, name)
	}
	
	/// The name of the currently visible child of stack, or `nil` if there is no
	/// visible child.
	public var nameOfVisibleChild: String? {
		let pointer = gtk_stack_get_visible_child_name(n_Stack)
		guard pointer != nil else { return nil }
		return String(cString: pointer)
	}
	
	/// Makes the child with the given name visible.
	///
	/// Note that the child widget has to be visible itself (see `show()`) in 
	/// order to become the visible child of stack.
	///
	/// - Parameter name: the name of the child to make visible
	/// - Parameter transition: the transition type to use
	public func setVisible(childWithName name: String,
	                       withTransition transition: TransitionType) {
		gtk_stack_set_visible_child_full(n_Stack, name, transition.rawValue)
	}
	
	/// Homogeneous sizing.
	///
	/// If it is homogeneous, the `Stack` will request the same size for all its
	/// children. If it isn't, the stack may change size when a different child
	/// becomes visible.
	public var homogeneous: Bool {
		set {
			gtk_stack_set_homogeneous(n_Stack, newValue ? 1 : 0)
		}
		get {
			return gtk_stack_get_homogeneous(n_Stack) != 0
		}
	}
	
	/// `true` if the stack allocates the same width for all children.
	///
	/// If it is homogeneous, the `Stack` will request the same width for all its
	/// children. If it isn't, the stack may change width when a different child
	/// becomes visible.
	public var hhomogeneous: Bool {
		set {
			gtk_stack_set_hhomogeneous(n_Stack, newValue ? 1 : 0)
		}
		get {
			return gtk_stack_get_hhomogeneous(n_Stack) != 0
		}
	}
	
	/// `true` if the stack allocates the same height for all children.
	///
	/// If it is homogeneous, the `Stack` will request the same height for all its
  /// children. If it isn't, the stack may change height when a different child
	/// becomes visible.
	public var vhomogeneous: Bool {
		set {
			gtk_stack_set_vhomogeneous(n_Stack, newValue ? 1 : 0)
		}
		get {
			return gtk_stack_get_vhomogeneous(n_Stack) != 0
		}
	}
	
	/// The amount of time (in milliseconds) that transitions between pages in 
	/// stack will take.
	public var transitionDuration: UInt {
		set {
			gtk_stack_set_transition_duration(n_Stack, guint(newValue))
		}
		get {
			return UInt(gtk_stack_get_transition_duration(n_Stack))
		}
	}
	
	/// The type of animation that will be used for transitions between pages in
	/// stack. Available types include various kinds of fades and slides.
	///
	/// The transition type can be changed without problems at runtime, so it is
	/// possible to change the animation based on the page that is about to become
	/// current.
	public var transitionType: TransitionType {
		set {
			gtk_stack_set_transition_type(n_Stack, newValue.rawValue)
		}
		get {
			return TransitionType(rawValue: gtk_stack_get_transition_type(n_Stack))!
		}
	}
	
	/// Whether the stack is currently in a transition from one page to another.
	public var transitionRunning: Bool {
		return gtk_stack_get_transition_running(n_Stack) != 0
	}
	
	/// Whether or not stack will interpolate its size when changing the visible
	/// child. If the `interpolateSize` property is set to `true`, stack will
	/// interpolate its size between the current one and the one it'll take after
	/// changing the visible child, according to the set transition duration.
	public var interpolateSize: Bool {
		set {
			gtk_stack_set_interpolate_size(n_Stack, newValue ? 1 : 0)
		}
		get {
			return gtk_stack_get_interpolate_size(n_Stack) != 0
		}
	}
}
