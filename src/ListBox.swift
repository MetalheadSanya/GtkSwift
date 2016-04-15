//
//  ListBox.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 15.04.16.
//
//

import CGTK

public class ListBox: Container {
	public class Row: Bin {
		internal var n_ListBoxRow: UnsafeMutablePointer<GtkListBoxRow>
		
		internal init(n_ListBoxRow: UnsafeMutablePointer<GtkListBoxRow>) {
			self.n_ListBoxRow = n_ListBoxRow
			super.init(n_Bin: UnsafeMutablePointer<GtkBin>(n_ListBoxRow))
		}
		
		/// Creates a new `ListBoxRow`, to be used as a child of a `ListBox`.
		public convenience init() {
			self.init(n_ListBoxRow:
				UnsafeMutablePointer<GtkListBoxRow>(gtk_list_box_row_new()))
		}
		
		/// Marks row as changed, causing any state that depends on this to be
		/// updated. This affects sorting, filtering and headers.
		///
		/// Note that calls to this method must be in sync with the data used for
		/// the row functions. For instance, if the list is mirroring some external
		/// data set, and *two* rows changed in the external data set then when you
		/// call `changed()` on the first row the sort function must only read the
		/// new data for the first of the two changed rows, otherwise the resorting
		/// of the rows will be wrong.
		///
		/// This generally means that if you don’t fully control the data model you
		/// have to duplicate the data that affects the listbox row functions into
		/// the row widgets themselves. Another alternative is to call
		/// `ListBox.invalidateSort()` on any model change, but that is more
		/// expensive.
		public func changed() {
			gtk_list_box_row_changed(n_ListBoxRow)
		}
		
		/// Whether the child is currently selected in its `ListBox` container
		var isSelected: Bool {
			return gtk_list_box_row_is_selected(n_ListBoxRow) != 0
		}
		
		private var _header: Widget?
		
		/// The current header 
		///
		/// This can be used in a `ListBoxUpdateHeaderFunc` to see if there is a
		/// header set already, and if so to update the state of it.
		///
		/// Changing property replace any existing header in the row, and be shown 
		/// in front of the row in the listbox.
		public var header: Widget? {
			set {
				gtk_list_box_row_set_header(n_ListBoxRow, header?.n_Widget)
			}
			get {
				let n_Widget = gtk_list_box_row_get_header(n_ListBoxRow)
				
				if _header?.n_Widget == n_Widget {
					return _header
				}
				
				if n_Widget == nil {
					_header = nil
					return nil
				}
				
				_header = Container.correctWidgetForWidget(Widget(n_Widget: n_Widget))
				return _header
			}
		}
		
		public var index: Int {
			return Int(gtk_list_box_row_get_index(n_ListBoxRow))
		}
		
		/// The `activatable` property for this row.
		public var activatable: Bool {
			set {
				gtk_list_box_row_set_activatable(n_ListBoxRow, newValue ? 1 : 0)
			}
			get {
				return gtk_list_box_row_get_activatable(n_ListBoxRow) != 0
			}
		}
		
		/// The value of the `selectable` property for this row.
		public var selectable: Bool {
			set {
				gtk_list_box_row_set_selectable(n_ListBoxRow, newValue ? 1 : 0)
			}
			get {
				return gtk_list_box_row_get_selectable(n_ListBoxRow) != 0
			}
		}
	}
	
	internal var n_ListBox: UnsafeMutablePointer<GtkListBox>
	
	internal init(n_ListBox: UnsafeMutablePointer<GtkListBox>) {
		self.n_ListBox = n_ListBox
		super.init(n_Container: UnsafeMutablePointer<GtkContainer>(n_ListBox))
	}
	
	/// Creates a new `ListBox` container.
	public convenience init() {
		self.init(n_ListBox: UnsafeMutablePointer<GtkListBox>(gtk_list_box_new()))
	}
	
	/// Prepend a widget to the list. If a sort function is set, the widget will
	/// actually be inserted at the calculated position and this function has the
	/// same effect of `addWidget(_:)`.
	///
	/// - Parameter child: the `Widget` to add
	public func prepend(child: Widget) {
		insert(child: child, to: 0)
	}
	
	
	/// Insert the `child` into the box at `position`. If a sort function is set,
	/// the widget will actually be inserted at the calculated position and this
	/// function has the same effect of `addWidget(_:)`.
	///
	/// If `position` is -1, or larger than the total number of items in the box,
	/// then the `child` will be appended to the end.
	///
	/// - Parameter child: the `Widget` to add
	/// - Parameter position: the position to insert `child` in
	public func insert(child: Widget, to position: Int) {
		let row: Row
		if child is Row {
			row = child as! Row
		} else {
			row = Row()
			row.show()
			row.addWidget(child)
		}
		
		gtk_list_box_insert(n_ListBox,
		                    UnsafeMutablePointer<GtkWidget>(row.n_ListBoxRow),
		                    gint(position))
		
		_children.append(row)
	}
	
	/// Make `row` the currently selected row.
	///
	/// - Parameter row: the row to select or `nil`.
	public func select(row: Row?) {
		gtk_list_box_select_row(n_ListBox, row?.n_ListBoxRow)
	}
	
	/// Unselects a single row of box, if the selection mode allows it.
	///
	/// - Parameter row: the row to unselected
	public func unselect(row: Row) {
		gtk_list_box_unselect_row(n_ListBox, row.n_ListBoxRow)
	}
	
	///	Select all children of box, if the selection mode allows it.
	public func selectAll() {
		gtk_list_box_select_all(n_ListBox)
	}
	
	/// Unselect all children of box, if the selection mode allows it.
	public func unselectAll() {
		gtk_list_box_unselect_all(n_ListBox)
	}
	
	private func _rowWithPointer(
		_ pointer: UnsafeMutablePointer<GtkListBoxRow>) -> Row {
		
		let n_ListBoxRow = UnsafeMutablePointer<GtkWidget>(pointer)
		
		var row = _children.filter{ $0.n_Widget == n_ListBoxRow}.first
		
		if row == nil {
			row = Container.correctWidgetForWidget(Widget(n_Widget: n_Widget))
			_children.append(row!)
		}
		
		return row as! Row
	}
	
	/// Gets the selected row.
	///
	/// Note that the box may allow multiple selection, in which case you should
	/// use `selectedForeach(_:)` to find all selected rows.
	///
	/// - Returns: The selected row.
	public func getSelectedRow() -> Row {
		let n_ListBoxRow = gtk_list_box_get_selected_row(n_ListBox)
		
		return _rowWithPointer(n_ListBoxRow)
	}
	
	/// A function used by `selectedForeach(_:)`. It will be called on every
	/// selected child of the box.
	///
	/// Parameter row: a `ListBox.Row`
	public typealias ListBoxForeachFunc = (row: Row) -> Void
	
	/// Calls a function for each selected child.
	///
	/// - note: The selection cannot be modified from within this function.
	public func selectedForeach(_ f: ListBoxForeachFunc) {
		class Data {
			let f: ListBoxForeachFunc
			let list: ListBox
			
			init(f: ListBoxForeachFunc, list: ListBox) {
				self.f = f
				self.list = list
			}
		}
		
		let data = Data(f: f, list: self)
		
		gtk_list_box_selected_foreach(n_ListBox, {
			_, row, user_data in
			let data = unsafeBitCast(user_data, to: Data.self)
			data.f(row: data.list._rowWithPointer(row))
			}, unsafeBitCast(data, to: UnsafeMutablePointer<gpointer>.self))
	}
	
	/// Creates a array of all selected children.
	public var selectedRows: [Row] {
		let n_Rows = Array<UnsafeMutablePointer<GtkListBoxRow>>(gList:
			gtk_list_box_get_selected_rows(n_ListBox))
		
		var selectedRows = [Row]()
		
		for n_Row in n_Rows {
			selectedRows.append(_rowWithPointer(n_Row))
		}
		
		return selectedRows
	}
	
	/// The selection mode of the listbox.
	/// - seealso: `SelectionMode` for details.
	public var selectionMode: SelectionMode {
		set {
			gtk_list_box_set_selection_mode(n_ListBox, newValue.rawValue)
		}
		get {
			return SelectionMode(rawValue:
				gtk_list_box_get_selection_mode(n_ListBox))!
		}
	}
	
	/// Whether rows activate on single clicks.
	///
	/// If `activateOnSingleClick` is `true`, rows will be activated when you
	/// click on them, otherwise you need to double-click.
	public var activateOnSingleClick: Bool {
		set {
			gtk_list_box_set_activate_on_single_click(n_ListBox, newValue ? 1 : 0)
		}
		get {
			return gtk_list_box_get_activate_on_single_click(n_ListBox) != 0
		}
	}
	
	// TODO: gtk_list_box_get_adjustment(), gtk_list_box_set_adjustment(),
	// need GtkAdjustment
	
	/// Sets the placeholder widget that is shown in the list when it doesn't
	/// display any visible children.
	///
	/// - Parameter placeholder: a `Widget` or `nil`.
	public func setPlaceholder(_ placeholder: Widget) {
		gtk_list_box_set_placeholder(n_ListBox, placeholder.n_Widget)
	}
	
	/// Gets the n-th child in the list (not counting headers). If `index` is
	/// negative or larger than the number of items in the list, `nil` is
	/// returned.
	///
	/// - Parameter index: the index of the row
	///
	/// - Returns: The child `Widget` or `nil`.
	public func getRow(atIndex index: Int) -> Row? {
		let n_Row = gtk_list_box_get_row_at_index(n_ListBox, gint(index))
		
		if let n_Row = n_Row {
			return _rowWithPointer(n_Row)
		}
		
		return nil
	}
	
	/// Gets the row at the `y` position.
	///
	/// - Parameter y: position
	///
	/// - Returns: The row or 'nil' in case no row exists for the given y
	///   coordinate.
	public func getRow(atY y: Int) -> Row? {
		let n_Row = gtk_list_box_get_row_at_y(n_ListBox, gint(y))
		
		if let n_Row = n_Row {
			return _rowWithPointer(n_Row)
		}
		
		return nil
	}
	
	/// Update the filtering for all rows. Call this when result of the filter
	/// function on the box is changed due to an external factor. For instance,
	/// this would be used if the filter function just looked for a specific
	/// search string and the entry with the search string has changed.
	public func invalidateFilter() {
		gtk_list_box_invalidate_filter(n_ListBox)
	}
	
	/// Update the separators for all rows. Call this when result of the header
	/// function on the box is changed due to an external factor.
	public func invalidateHeaders() {
		gtk_list_box_invalidate_headers(n_ListBox)
	}
	
	/// Update the sorting for all rows. Call this when result of the sort
	/// function on the box is changed due to an external factor.
	public func invalidateSort() {
		gtk_list_box_invalidate_sort(n_ListBox)
	}
	
	/// Will be called whenever the row changes or is added and lets you control 
	/// if the row should be visible or not.
	///
	/// - Parameter row: the row that may be filtered
	///
	/// - Returns: `true` if the row should be visible, `false` otherwise
	public typealias ListBoxFilterFunc = (row: Row) -> Bool
	
	/// By setting a filter function on the box one can decide dynamically which 
	/// of the rows to show. For instance, to implement a search function on a 
	/// list that filters the original list to only show the matching rows.
	/// 
	/// The `filterFunc` will be called for each row after the call, and it will 
	/// continue to be called each time a row changes (via 
	/// `ListBox.Row.changed()`) or when `invalidateFilter()` is called.
	///
	/// Note that using a filter function is incompatible with using a model (see 
	/// gtk_list_box_bind_model()).
	public var filterFunc: ListBoxFilterFunc? {
		didSet {
			if filterFunc == nil {
				gtk_list_box_set_filter_func(n_ListBox, nil, nil, nil)
			} else {
				gtk_list_box_set_filter_func(n_ListBox, {
					n_Row, listBox in
					let list = unsafeBitCast(listBox, to: ListBox.self)
					let row = list._rowWithPointer(n_Row)
					return list.filterFunc!(row: row) ? 1 : 0
					}, unsafeBitCast(self, to: UnsafeMutablePointer<gpointer>.self), nil)
			}
		}
	}
	
	/// Whenever `row` changes or which row is before `row` changes this is 
	/// called, which lets you update the header on `row`. You may remove or set a 
	/// new one via `ListBox.Row.header` property or just change the state of the 
	/// current header widget.
	///
	/// - Parameter row: the row to update
	/// - Parameter before: the row before `row`, or `nil` if it is first.
	public typealias ListBoxUpdateHeaderFunc = (row: Row, before: Row?) -> Void
	
	/// By setting a header function on the box one can dynamically add headers in 
	/// front of rows, depending on the contents of the row and its position in 
	/// the list. For instance, one could use it to add headers in front of the 
	/// first item of a new kind, in a list sorted by the kind.
	///
	/// The `headerFunc` can look at the current header widget using
	/// `ListBox.Row.header` property and either update the state of the widget as 
	/// needed, or set a new one using `ListBox.Row.header`. If no header is 
	/// needed, set the header to `nil`.
	///
	/// Note that you may get many calls headerFunc to this for a particular row 
	/// when e.g. changing things that don’t affect the header. In this case it is 
	/// important for performance to not blindly replace an existing header with 
	/// an identical one.
	///
	/// The `headerFunc` function will be called for each row after the call, and 
	/// it will continue to be called each time a row changes (via 
	/// `ListBox.Row.changed()`) and when the row before changes (either by 
	/// `ListBox.Row.changed()` on the previous row, or when the previous row 
	/// becomes a different row). It is also called for all rows when 
	/// `invalidateHeaders()` is called.
	public var headerFunc: ListBoxUpdateHeaderFunc? {
		didSet {
			if headerFunc == nil {
				gtk_list_box_set_header_func(n_ListBox, nil, nil, nil)
			} else {
				gtk_list_box_set_header_func(n_ListBox, {
					n_Row, n_RowBefore, listBox in
					let list = unsafeBitCast(listBox, to: ListBox.self)
					let row = list._rowWithPointer(n_Row)
					var before: Row? = nil
					if n_RowBefore != nil {
						before = list._rowWithPointer(n_RowBefore)
					}
					list.headerFunc!(row: row, before: before)
					}, unsafeBitCast(self, to: UnsafeMutablePointer<gpointer>.self), nil)
			}
		}
	}
	
	/// Compare two rows to determine which should be first.
	///
	/// Parameter row1: the first row
	/// Parameter row2: the second row
	/// 
	/// Returns: < 0 if `row1` should be before `row2`, 0 if they are equal and 
	/// > 0 otherwise
	public typealias ListBoxSortFunc = (row1: Row, row2: Row) -> Int
	
	/// By setting a sort function on the box one can dynamically reorder the rows 
	/// of the list, based on the contents of the rows.
	///
	/// The sortFunc will be called for each row after the call, and will continue 
	/// to be called each time a row changes (via `ListBox.Row.changed()`) and 
	/// when `invalidateSort()` is called.
	/// 
	/// Note that using a sort function is incompatible with using a model (see 
	/// `gtk_list_box_bind_model()`).
	public var sortFunc: ListBoxSortFunc? {
		didSet {
			if sortFunc == nil {
				gtk_list_box_set_sort_func(n_ListBox, nil, nil, nil)
			} else {
				gtk_list_box_set_sort_func(n_ListBox, {
					n_Row1, n_Row2, listBox in
					let list = unsafeBitCast(listBox, to: ListBox.self)
					let row1 = list._rowWithPointer(n_Row1)
					let row2 = list._rowWithPointer(n_Row2)
					return gint(list.sortFunc!(row1: row1, row2: row2))
					}, unsafeBitCast(self, to: UnsafeMutablePointer<gpointer>.self), nil)
			}
		}
	}
	
	/// This is a helper function for implementing DnD onto a `ListBox`. The 
	/// passed in `row` will be highlighted via `dragHighlight()`, and any
	/// previously highlighted row will be unhighlighted.
	///
	/// The row will also be unhighlighted when the widget gets a drag leave 
	/// event.
	public func dragHighlight(row: Row) {
		gtk_list_box_drag_highlight_row(n_ListBox, row.n_ListBoxRow)
	}
	
	/// If a row has previously been highlighted via `dragHighlight(row:)` it will 
	/// have the highlight removed.
	public func dragUnhighlight() {
		gtk_list_box_drag_unhighlight_row(n_ListBox)
	}
	
	// TODO: gtk_list_box_bind_model(), need gio-swift
}
