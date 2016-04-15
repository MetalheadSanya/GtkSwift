//
// Created by Alexander Zalutskiy on 21.12.15.
// Copyright (c) 2015 Metalhead. All rights reserved.
//

import CGTK

/// `Grid` is a container which arranges its child widgets in rows and columns. 
/// It is a very similar to `Table` and `Box`, but it consistently uses 
/// `Widget`’s `margin` and `expand` properties instead of custom child 
/// properties, and it fully supports height-for-width geometry management.
///
/// Children are added using `attach(child:left:top:width:height:)`. They can 
/// span multiple rows or columns. It is also possible to add a child next to an 
/// existing child, using `attach(child:nextTo:side:width:height:)`. The 
/// behaviour of `Grid` when several children occupy the same grid cell is 
/// undefined.
///
/// `Grid` can be used like a `Box` by just using `addWidget(_:)`, which will 
/// place children next to each other in the direction determined by the 
/// `orientation` property.
public class Grid: Container {
	internal var n_Grid: UnsafeMutablePointer<GtkGrid>

	internal init(n_Grid: UnsafeMutablePointer<GtkGrid>) {
		self.n_Grid = n_Grid
		super.init(n_Container: UnsafeMutablePointer<GtkContainer>(n_Grid))
	}

	/// Creates a new grid widget.
	public convenience init() {
		self.init(n_Grid: UnsafeMutablePointer<GtkGrid>(gtk_grid_new()))
	}

	/// Adds a widget to the grid.
	///
	/// The position of `child` is determined by `left` and `top`. The number of 
	/// “cells” that `child` will occupy is determined by `width` and `height`.
	///
	/// - Parameter child: the widget to add
	/// - Parameter left: the column number to attach the left side of `child` to
	/// - Parameter top: the row number to attach the top side of `child` to
	/// - Parameter width: the number of columns that `child` will span
	/// - Parameter height: the number of rows that `child` will span
	public func attach(child: Widget, left: Int, top: Int,
	                   width: Int, height: Int) {
		
		guard child.parent == nil else { return }
		guard width > 0 else { return }
		guard height > 0 else { return }
		
		gtk_grid_attach(n_Grid, child.n_Widget, gint(left), gint(top),
		                gint(width), gint(height))
		
		if !_children.contains(child) {
			_children.append(child)
		}
	}
	
	/// Adds a widget to the grid.
	///
	/// The widget is placed next to `sibling`, on the side determined by side. 
	/// When `sibling` is `nil`, the widget is placed in row (for left or right 
	/// placement) or column 0 (for top or bottom placement), at the end indicated 
	/// by `side`.
	///
	/// Attaching widgets labeled [1], [2], [3] with `sibling` == `nil` and `side` 
	/// == `.Left` yields a layout of 3[1].
	///
	/// - Parameter child: the widget to add
	/// - Parameter sibling: the child of grid that `child` will be placed next 
	///   to, or `nil` to place `child` at the beginning or end.
	/// - Parameter side: the side of `sibling` that `child` is positioned next to
	/// - Parameter width: the number of columns that `child` will span
	/// - Parameter height: the number of rows that 'child' will span
	public func attach(child: Widget, nextTo sibling: Widget?, side: PositionType,
	                   width: Int, height: Int) {
		
		guard child.parent == nil else { return }
		guard sibling == nil || sibling?.parent == self else { return }
		guard width > 0 else { return }
		guard height > 0 else { return }
		
		gtk_grid_attach_next_to(n_Grid, child.n_Widget, sibling?.n_Widget,
		                        side.rawValue, gint(width), gint(height))
		
		if !_children.contains(child) {
			_children.append(child)
		}
	}
	
	/// Gets the child of grid whose area covers the grid cell whose upper left
	/// corner is at `left`, `top`.
	///
	/// - Parameter left: the left edge of the cell
	/// - Parameter top: the top edge of the cell
	///
	/// - Returns: The child at the given position, or `nil`.
	public func child(atLeft left: Int, andTop top: Int) -> Widget? {
		let n_Widget = gtk_grid_get_child_at(n_Grid, gint(left), gint(top))
		
		if n_Widget == nil {
			return nil
		}
		
		var widget = _children.filter{ $0.n_Widget == n_Widget }.first
		
		if let widget = widget {
			return widget
		}
		
		widget = Container.correctWidgetForWidget(Widget(n_Widget: n_Widget))
		_children.append(widget!)
		return widget
	}
	
	/// Inserts a row at the specified position.
	///
	/// Children which are attached at or below this position are moved one row 
	/// down. Children which span across this position are grown to span the new 
	/// row.
	///
	/// - Parameter position: the position to insert the row at
	public func insert(row position: Int) {
		gtk_grid_insert_row(n_Grid, gint(position))
	}
	
	/// Inserts a column at the specified position.
	///
	/// Children which are attached at or to the right of this position are moved 
	/// one column to the right. Children which span across this position are 
	/// grown to span the new column.
	///
	/// - Parameter position: the position of the row to remove
	public func insert(column position: Int) {
		gtk_grid_insert_column(n_Grid, gint(position))
	}
	
	/// Removes a row from the grid.
	///
	/// Children that are placed in this row are removed, spanning children that 
	/// overlap this row have their height reduced by one, and children below the 
	/// row are moved up.
	///
	/// - Parameter position: the position of the row to remove
	public func remove(row position: Int) {
		gtk_grid_remove_row(n_Grid, gint(position))
		_clearChildren()
	}
	
	/// Removes a column from the grid.
	///
	/// Children that are placed in this column are removed, spanning children 
	/// that overlap this column have their width reduced by one, and children 
	/// after the column are moved to the left.
	///
	/// - Parameter position: the position of the column to remove
	public func remove(column position: Int) {
		gtk_grid_remove_column(n_Grid, gint(position))
		_clearChildren()
	}
	
	/// Inserts a row or column at the specified position.
	///
	/// The new row or column is placed next to `sibling`, on the side determined 
	/// by `side`. If `side` is `.Top` or `.Bottom`, a row is inserted. If `side`
 	/// is `.Left` of `.Right`, a column is inserted.
	///
	/// - Parameter sibling: the child of grid that the new row or column will be 
	///   placed next to
	/// - Parameter side: he `side` of sibling that `child` is positioned next to
	public func insert(nextTo sibling: Widget, side: PositionType) {
		gtk_grid_insert_next_to(n_Grid, sibling.n_Widget, side.rawValue)
	}
	
	/// Whether all rows of grid have the same height.
	public var rowHomogeneous: Bool {
		set {
			gtk_grid_set_row_homogeneous(n_Grid, newValue ? 1 : 0)
		}
		get {
			return gtk_grid_get_row_homogeneous(n_Grid) != 0
		}
	}
	
	/// The amount of space between rows of grid.
	public var rowSpacing: UInt {
		set {
			gtk_grid_set_row_spacing(n_Grid, guint(newValue))
		}
		get {
			return UInt(gtk_grid_get_row_spacing(n_Grid))
		}
	}
	
	/// Whether all columns of grid have the same height.
	public var columnHomogeneous: Bool {
		set {
			gtk_grid_set_column_homogeneous(n_Grid, newValue ? 1 : 0)
		}
		get {
			return gtk_grid_get_column_homogeneous(n_Grid) != 0
		}
	}
	
	/// The amount of space between column of grid.
	public var columnSpacing: UInt {
		set {
			gtk_grid_set_column_spacing(n_Grid, guint(newValue))
		}
		get {
			return UInt(gtk_grid_get_column_spacing(n_Grid))
		}
	}
	
	/// Which row defines the global baseline for the entire grid. Each row in the
	/// grid can have its own local baseline, but only one of those is global, 
	/// meaning it will be the baseline in the parent of the grid .
	public var baselineRow: Int {
		set {
			gtk_grid_set_baseline_row(n_Grid, gint(newValue))
		}
		get {
			return Int(gtk_grid_get_baseline_row(n_Grid))
		}
	}
	
	/// Returns the baseline position of `row` as set by
	/// `setBaselinePosition(_:forRow:)` or the default value `.Center`.
	///
	/// - Parameter row: a row index
	///
	/// - Returns: The baseline position of `row`
	public func baselinePosition(forRow row: Int) -> BaselinePosition {
		return BaselinePosition(rawValue:
			gtk_grid_get_row_baseline_position(n_Grid, gint(row)))!
	}
	
	/// Sets how the baseline should be positioned on `row` of the grid, in case 
	/// that row is assigned more space than is requested.
	///
	/// - Parameter baseline: a `BaselinePosition`
	/// - Parameter row: a row index
	public func setBaselinePosition(_ baseline: BaselinePosition,
	                                forRow row: Int) {
		gtk_grid_set_row_baseline_position(n_Grid, gint(row),
		                                   baseline.rawValue)
	}
}
