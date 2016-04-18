//
//  Overlay.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 18.04.16.
//
//

import CGTK

/// `Overlay` is a container which contains a single main child, on top of which
/// it can place `overlay` widgets. The position of each overlay widget is
/// determined by its `halign` and `valign` properties. E.g. a widget with both
/// alignments set to `.Start` will be placed at the top left corner of the
/// `Overlay` container, whereas an overlay with halign set to `.Center` and
/// valign set to `.End` will be placed a the bottom edge of the `Overlay`,
/// horizontally centered. The position can be adjusted by setting the margin
/// properties of the child to non-zero values.
///
/// More complicated placement of overlays is possible by connecting to the
/// `getChildPositionSignal`.
public class Overlay: Bin {
	internal var n_Overlay: UnsafeMutablePointer<GtkOverlay>
	
	internal init(n_Overlay: UnsafeMutablePointer<GtkOverlay>) {
		self.n_Overlay = n_Overlay
		super.init(n_Bin: UnsafeMutablePointer<GtkBin>(n_Overlay))
	}
	
	/// Creates a new `Overlay`.
	public convenience init() {
		self.init(n_Overlay: UnsafeMutablePointer<GtkOverlay>(gtk_overlay_new()))
	}
	
	/// Adds `widget` to overlay.
	///
	/// The widget will be stacked on top of the main widget added with 
	/// `addWidget(_:)`.
	///
	/// The position at which `widget` is placed is determined from its `halign`
	/// and `valign` properties.
	///
	/// - Parameter widget: a `Widget` to be added to the container
	public func addOverlay(_ widget: Widget) {
		gtk_overlay_add_overlay(n_Overlay, widget.n_Widget)
		
		if !_children.contains(widget) {
			_children.append(widget)
		}
	}
	
	/// Moves `child` to a new index in the list of overlay children. The list
	/// contains overlays in the order that these were added to overlay.
	///
	/// A widget’s index in the overlay children list determines which order the
	/// children are drawn if they overlap. The first child is drawn at the
	/// bottom. It also affects the default focus chain order.
	/// 
	/// - Parameter child: the overlaid `Widget` to move
	/// - Parameter position: the new index for child in the list of overlay
	///   children of overlay , starting from 0. If negative, indicates the end of
	///    the list
	public func reorderOverlay(_ child: Widget, toPosition position: Int) {
		gtk_overlay_reorder_overlay(n_Overlay, child.n_Widget, gint(position))
	}
	
	/// Convenience function to get the value of the `passThrough` child property
	/// for `widget`.
	///
	/// - Parameter widget: an overlay child of `Overlay`
	///
	/// - Returns: Whether the widget is a pass through child.
	public func getOverlayPassThrough(_ widget: Widget) -> Bool {
		return gtk_overlay_get_overlay_pass_through(n_Overlay, widget.n_Widget) != 0
	}
	
	/// Convenience function to set the value of the `passThrough` child property
	/// for `widget`.
	/// 
	/// - Parameter widget: an overlay child of `Overlay`
	/// - Parameter passThrough: whether the child should pass the input through
	public func setOverlay(_ widget: Widget, isPassThrough pathThrough: Bool) {
		return gtk_overlay_set_overlay_pass_through(n_Overlay,
		                                            widget.n_Widget,
		                                            pathThrough ? 1 : 0)
	}
	
	// MARK: - Signals
	
	// TODO: need gdk-swift
	
}
