//
// Created by Alexander Zalutskiy on 21.12.15.
// Copyright (c) 2015 Metalhead. All rights reserved.
//

import CGTK

/// The `Box` widget organizes child widgets into a rectangular area.
///
/// The rectangular area of a `Box` is organized into either a single row or a
/// single column of child widgets depending upon the orientation. Thus, all 
/// children of a `Box` are allocated one dimension in common, which is the 
/// height of a row, or the width of a column.
///
/// `Box` uses a notion of packing. Packing refers to adding widgets with
/// reference to a particular position in a `Container`. For a Box, there are 
/// two reference positions: the start and the end of the box. For a vertical 
/// `Box`, the start is defined as the top of the box and the end is defined as 
/// the bottom. For a horizontal `Box` the start is defined as the left side and 
/// the end is defined as the right side.
///
/// Use repeated calls to `packStart(child:expand:fill:padding)` to pack widgets
/// into a `Box` from start to end. Use `packEnd(child:expand:fill:padding)` to 
/// add widgets from end to start. You may intersperse these calls and add 
/// widgets from both ends of the same `Box`.
/// 
/// Because `Box` is a `Container`, you may also use `addWidget(_:)` to insert 
/// widgets into the box, and they will be packed with the default values for 
/// expand and fill child properties. Use `removeWidget(_:)` to remove widgets 
/// from the `Box`.
///
/// Use `homogeneous` property to specify whether or not all children of the 
/// `Box` are forced to get the same amount of space.
///
/// Use `spacing` property to determine how much space will be minimally placed 
/// between all children in the `Box`. Note that spacing is added between the 
/// children, while padding added by `packStart(child:expand:fill:padding)` or 
/// `packEnd(child:expand:fill:padding)` is added on either side of the widget 
/// it belongs to.
///
/// Use `reorder(child:position:)` to move a `Box` child to a different place in
/// the box.
///
/// Use `setChildPacking(_:forChild:)` to reset the expand, fill and padding 
/// child properties. Use `getQueryChildPacking(child:)` to query these fields.
///
/// Note that a single-row or single-column Grid provides exactly the same 
/// functionality as Box.
public class Box: Container {
	public struct ChildPacking {
		public var padding: UInt
		public var expand: Bool
		public var fill: Bool
		public var pack: PackType
	}
	
	internal var n_Box: UnsafeMutablePointer<GtkBox>
	
	internal init(n_Box: UnsafeMutablePointer<GtkBox>) {
		self.n_Box = n_Box
		super.init(n_Container:
			unsafeBitCast(self.n_Box, to: UnsafeMutablePointer<GtkContainer>.self))
	}
	
	/// Creates a new Box.
	///
	/// - Parameter orientation: the box’s orientation.
	/// - Parameter spacing: the number of pixels to place by default between 
	///   children.
	public convenience init(orientation: Orientation, spacing: Int) {
		self.init(n_Box: UnsafeMutablePointer<GtkBox>(
			gtk_box_new(orientation.rawValue, gint(spacing)))
		)
	}
	
	/// Adds `child` to box, packed with reference to the end of box. The `child`
	/// is packed after (away from end of) any other child packed with reference
	/// to the end of box.
	///
	/// - Parameter child: the Widget to be added to box
	/// - Parameter expand: `true` if the new child is to be given extra space
	///   allocated to box. The extra space will be divided evenly between all
	///   children that use this option
	/// - Parameter fill: `true` if space given to `child` by the `expand` option
	///   is actually allocated to `child`, rather than just padding it. This
	///   parameter has no effect if expand is set to `false`. A `child` is always
	///   allocated the full height of a horizontal Box and the full width of a
	///   vertical Box. This option affects the other dimension
	/// - Parameter padding: extra space in pixels to put between this child and
	///   its neighbors, over and above the global amount specified by “spacing”
	///   property. If `child` is a widget at one of the reference ends of box,
	///   then `padding` pixels are also put between `child` and the reference
	///   edge of box
	public func packStart(child: Widget, expand: Bool,
	                      fill: Bool, padding: UInt) {
		
		guard child.parent == nil else { return }
		
		gtk_box_pack_start(n_Box, child.n_Widget, expand ? 1 : 0, fill ? 1 : 0,
		                   guint(padding))
		if !_children.contains(child) {
			_children.append(child)
		}
	}
	
	/// Adds `child` to box, packed with reference to the start of box. The
	/// `child` is packed after any other child packed with reference to the start
	/// of box.
	///
	/// - Parameter child: the Widget to be added to box
	/// - Parameter expand: `true` if the new child is to be given extra space
	///   allocated to box. The extra space will be divided evenly between all
	///   children that use this option
	/// - Parameter fill: `true` if space given to `child` by the `expand` option
	///   is actually allocated to `child`, rather than just padding it. This
	///   parameter has no effect if expand is set to `false`. A `child` is always
	///   allocated the full height of a horizontal Box and the full width of a
	///   vertical Box. This option affects the other dimension
	/// - Parameter padding: extra space in pixels to put between this child and
	///   its neighbors, over and above the global amount specified by “spacing”
	///   property. If `child` is a widget at one of the reference ends of box,
	///   then `padding` pixels are also put between `child` and the reference
	///   edge of box
	public func packEnd(child: Widget, expand: Bool, fill: Bool, padding: UInt) {
		guard child.parent == nil else { return }
		
		gtk_box_pack_end(n_Box, child.n_Widget, expand ? 1 : 0, fill ? 1 : 0,
		                 guint(padding))
		if !_children.contains(child) {
			_children.append(child)
		}
	}
	
	/// `homogeneous` property of box, controlling whether or not all children of
	/// box are given equal space in the box.
	public var homogeneous: Bool {
		set {
			gtk_box_set_homogeneous(n_Box, newValue ? 1 : 0)
		}
		get {
			return gtk_box_get_homogeneous(n_Box) != 0
		}
	}
	
	/// `spacing` property of box, which is the number of pixels to place between
	/// children of box .
	public var spacing: Int {
		set {
			gtk_box_set_spacing(n_Box, gint(newValue))
		}
		get {
			return Int(gtk_box_get_spacing(n_Box))
		}
	}
	
	/// Moves `child` to a new position in the list of box children. The list
	/// contains widgets packed `.Start` as well as widgets packed `.End`, in the
	/// order that these widgets were added to box.
	///
	/// A widget’s position in the box children list determines where the widget
	/// is packed into box. A child widget at some position in the list will be
	/// packed just after all other widgets of the same packing type that appear
	/// earlier in the list.
	///
	/// - Parameter child: the Widget to move
	/// - Parameter position: the new position for `child` in the list of children
	///   of box, starting from 0. If negative, indicates the end of the list
	public func reorder(child: Widget, position: Int) {
		gtk_box_reorder_child(n_Box, child.n_Widget, gint(position))
	}
	
	/// Obtains information about how `child` is packed into box.
	///
	/// - Parameter child: the Widget of the child to query
	///
	/// - Returns: A `ChildPacking` struct with padding, expand, fill and packing
	///   type
	public func getQueryChildPacking(child: Widget) -> ChildPacking {
		var expand: gboolean = 0
		var fill: gboolean = 0
		var padding: guint = 0
		var pack_type: GtkPackType = GTK_PACK_START
		
		gtk_box_query_child_packing(n_Box, child.n_Widget, &expand, &fill,
		                            &padding, &pack_type)
		
		return ChildPacking(padding: UInt(padding), expand: expand != 0,
		                    fill: fill != 0, pack: PackType(rawValue: pack_type)!)
	}
	
	/// Sets the way `child` is packed into box.
	///
	/// - Parameter childPacking: A `ChildPacking` struct with packing settings
	/// - Parameter child: the Widget of the child to set
	public func setChildPacking(_ childPacking: ChildPacking,
	                            forChild child: Widget) {
		
		gtk_box_set_child_packing(n_Box, child.n_Widget,
		                          childPacking.expand ? 1 : 0,
		                          childPacking.fill ? 1 : 0,
		                          guint(childPacking.padding),
		                          childPacking.pack.rawValue)
	}
	
	/// The baseline position of a box. This affects only horizontal boxes with
	/// at least one baseline aligned child. If there is more vertical space
	/// available than requested, and the baseline is not allocated by the parent
	/// then position is used to allocate the baseline wrt the extra space
	/// available.
	public var baselinePosition: BaselinePosition {
		set {
			gtk_box_set_baseline_position(n_Box, newValue.rawValue)
		}
		get {
			return BaselinePosition(rawValue: gtk_box_get_baseline_position(n_Box))!
		}
	}
	
	internal weak var _centerWidget: Widget?
	
	/// Center widget; that is a child widget that will be centered with respect 
	/// to the full width of the box, even if the children at either side take up 
	/// different amounts of space.
	public var centerWidget: Widget? {
		set {
			if newValue != nil && newValue!.parent != nil {
				return
			}
			
			gtk_box_set_center_widget(n_Box, newValue?.n_Widget)
			
			if let newValue = newValue {
				_children.append(newValue)
			}
			
			_centerWidget = newValue
		}
		get {
			let n_Widget = gtk_box_get_center_widget(n_Box)
			
			if n_Widget == _centerWidget?.n_Widget {
				return _centerWidget
			}
			
			if let n_Widget = n_Widget {
				var widget = _children.filter{ $0.n_Widget == n_Widget}.first
				
				if let widget = widget {
					_centerWidget = widget
					return widget
				}

				widget = Container.correctWidgetForWidget(Widget(n_Widget: n_Widget))
				_children.append(widget!)
				_centerWidget = widget
				return widget
			}
			
			return nil
		}
	}
}
