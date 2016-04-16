//
//  FlowBox.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 16.04.16.
//
//

import CGTK
import gobjectswift

/// A `FlowBox` positions child widgets in sequence according to its
/// orientation.
///
/// For instance, with the horizontal orientation, the widgets will be arranged
/// from left to right, starting a new row under the previous row when
/// necessary. Reducing the width in this case will require more rows, so a
/// larger height will be requested.
///
/// Likewise, with the vertical orientation, the widgets will be arranged from
/// top to bottom, starting a new column to the right when necessary. Reducing
/// the height will require more columns, so a larger width will be requested.
///
/// The children of a `FlowBox` can be dynamically sorted and filtered.
///
/// Although a `FlowBox` must have only `FlowBox.Child` children, you can add
/// any kind of widget to it via `addWidget(_:)`, and a `FlowBox.Child` widget
/// will automatically be inserted between the box and the widget.
///
/// - Seealso: `ListBox`.
///
/// - Version: `FlowBox` was added in GTK+ 3.12.
public class FlowBox: Container {
	public class Child: Bin {
		private var n_FlowBoxChild: UnsafeMutablePointer<GtkFlowBoxChild>
		
		internal init(n_FlowBoxChild: UnsafeMutablePointer<GtkFlowBoxChild>) {
			self.n_FlowBoxChild = n_FlowBoxChild
			super.init(n_Bin: UnsafeMutablePointer<GtkBin>(n_FlowBoxChild))
		}
		
		/// Creates a new FlowBoxChild, to be used as a child of a FlowBox.
		private convenience init() {
			self.init(n_FlowBoxChild:
				UnsafeMutablePointer<GtkFlowBoxChild>(gtk_flow_box_child_new()))
		}
		
		/// Gets the current index of the child in its FlowBox container.
		public var index: Int {
			return Int(gtk_flow_box_child_get_index(n_FlowBoxChild))
		}
		
		/// Whether the child is currently selected in its FlowBox container.
		public var isSelected: Bool {
			return gtk_flow_box_child_is_selected(n_FlowBoxChild) != 0
		}
		
		/// Marks child as changed, causing any state that depends on this to be
		/// updated. This affects sorting and filtering.
		///
		/// Note that calls to this method must be in sync with the data used for
		/// the sorting and filtering functions. For instance, if the list is
		/// mirroring some external data set, and *two* children changed in the
		/// external data set when you call `changed()` on the first child, the sort
		/// function must only read the new data for the first of the two changed
		/// children, otherwise the resorting of the children will be wrong.
		///
		/// This generally means that if you don’t fully control the data model, you
		/// have to duplicate the data that affects the sorting and filtering
		/// functions into the widgets themselves. Another alternative is to call
		/// `FlowBox.invalidateSort()` on any model change, but that is more
		/// expensive.
		public func changed() {
			gtk_flow_box_child_changed(n_FlowBoxChild)
		}
		
		// MARK: - Signals
		
		/// - Parameter box: the `FlowBox` on which the signal is emitted
		public typealias ActivateCallback = (
			box: Child)
			-> Void
		public typealias ActivateNative = (
			UnsafeMutablePointer<Child>,
			UnsafeMutablePointer<gpointer>)
			-> Void
		
		/// The `::activate` signal is emitted when the user activates a child
		/// widget in a `FlowBox`, either by clicking or double-clicking, or by
		/// using the Space or Enter key.
		///
		/// While this signal is used as a keybinding signal, it can be used by
		/// applications for their own purposes.
		public lazy var activateSignal:
			Signal<ActivateCallback, Child, ActivateNative> =
			Signal(obj: self, signal: "activate", c_handler: {
				_, user_data in
				let data = unsafeBitCast(user_data,
				                         to: SignalData<Child,
																	ActivateCallback>.self)
				
				let child = data.obj
				let action = data.function
				
				action(box: child)
			})
	}
	
	internal var n_FlowBox: UnsafeMutablePointer<GtkFlowBox>
	
	internal init(n_FlowBox: UnsafeMutablePointer<GtkFlowBox>) {
		self.n_FlowBox = n_FlowBox
		super.init(n_Container: UnsafeMutablePointer<GtkContainer>(n_FlowBox))
	}
	
	/// Creates a FlowBox.
	public convenience init() {
		self.init(n_FlowBox: UnsafeMutablePointer<GtkFlowBox>(gtk_flow_box_new()))
	}
	
	/// Inserts the `child` into box at `position`.
	///
	/// If a sort function is set, the widget will actually be inserted at the
	/// calculated position and this function has the same effect as
	/// `addWidget(_:)`.
	/// If `position` is -1, or larger than the total number of children in the
	/// box, then the `child` will be appended to the end.
	///
	/// - Parameter child: the `Widget` to add
	/// - Parameter position: the position to insert `child` in
	public func insert(child: Widget, at position: Int) {
		let row: Child
		if child is Child {
			row = child as! Child
		} else {
			row = Child()
			row.show()
			row.addWidget(child)
		}
		
		gtk_flow_box_insert(n_FlowBox, row.n_Widget, gint(position))
		
		_children.append(row)
	}
	
	private func  _childWithPointer(
		_ pointer: UnsafeMutablePointer<GtkFlowBoxChild>) -> Child {
		
		let n_FlowBoxChild = UnsafeMutablePointer<GtkWidget>(pointer)
		
		var row = _children.filter{ $0.n_Widget == n_FlowBoxChild}.first
		
		if row == nil {
			row = Container.correctWidgetForWidget(Widget(n_Widget: n_Widget))
			_children.append(row!)
		}
		
		return row as! Child
	}
	
	/// Gets the nth child in the box.
	///
	/// - Parameter idx: the position of the child
	///
	/// - Returns: The child widget, which will always be a `FlowBox.Child` or
	///   `nil` in case no child widget with the given index exists.
	public func getChild(atIndex idx: Int) -> Child? {
		let n_FlowBoxChild = gtk_flow_box_get_child_at_index(n_FlowBox, gint(idx))
		return _childWithPointer(n_FlowBoxChild)
	}
	
	// TODO: gtk_flow_box_set_hadjustment(), gtk_flow_box_set_vadjustment(),
	// need GtkAdjustment
	
	/// Determines whether all children should be allocated the same size.
	public var homogeneous: Bool {
		set {
			gtk_flow_box_set_homogeneous(n_FlowBox, newValue ? 1 : 0)
		}
		get {
			return gtk_flow_box_get_homogeneous(n_FlowBox) != 0
		}
	}
	
	/// The amount of vertical space between two children.
	public var rowSpacing: UInt {
		set {
			gtk_flow_box_set_row_spacing(n_FlowBox, guint(newValue))
		}
		get {
			return UInt(gtk_flow_box_get_row_spacing(n_FlowBox))
		}
	}
	
	/// The amount of horizontal space between two children.
	public var columnSpacing: UInt {
		set {
			gtk_flow_box_set_column_spacing(n_FlowBox, guint(newValue))
		}
		get {
			return UInt(gtk_flow_box_get_column_spacing(n_FlowBox))
		}
	}
	
	/// The minimum number of children to allocate consecutively in the given
	/// orientation.
	///
	/// Setting the minimum children per line ensures that a reasonably small
	/// height will be requested for the overall minimum width of the box.
	public var minChildrenPerLine: UInt {
		set {
			gtk_flow_box_set_min_children_per_line(n_FlowBox, guint(newValue))
		}
		get {
			return UInt(gtk_flow_box_get_min_children_per_line(n_FlowBox))
		}
	}
	
	/// The maximum amount of children to request space for consecutively in the
	/// given orientation.
	public var maxChildrenPerLine: UInt {
		set {
			gtk_flow_box_set_max_children_per_line(n_FlowBox, guint(newValue))
		}
		get {
			return UInt(gtk_flow_box_get_max_children_per_line(n_FlowBox))
		}
	}
	
	/// Determines whether children can be activated with a single click, or
	/// require a double-click.
	public var activateOnSingleClick: Bool {
		set {
			gtk_flow_box_set_activate_on_single_click(n_FlowBox, newValue ? 1 : 0)
		}
		get {
			return gtk_flow_box_get_activate_on_single_click(n_FlowBox) != 0
		}
	}
	
	/// A function used by `selectedForeach()`. It will be called on every
	/// selected child of the box.
	///
	/// - Parameter child: a `FlowBox.Child`
	public typealias ForeachFunc = (child: Child) -> Void
	
	/// Calls a function for each selected child.
	///
	/// Note that the selection cannot be modified from within this function.
	///
	/// - Parameter f: the function to call for each selected child.
	public func selectedForeach(_ f: ForeachFunc) {
		class Data {
			let f: ForeachFunc
			let box: FlowBox
			
			init(f: ForeachFunc, box: FlowBox) {
				self.f = f
				self.box = box
			}
		}
		
		let data = Data(f: f, box: self)
		
		gtk_flow_box_selected_foreach(n_FlowBox, {
			_, child, user_data in
			let data = unsafeBitCast(user_data, to: Data.self)
			data.f(child: data.box._childWithPointer(child))
			}, unsafeBitCast(data, to: UnsafeMutablePointer<gpointer>.self))
	}
	
	/// Creates a array of all selected children.
	public var selectedChildren: [Child] {
		let n_Children = Array<UnsafeMutablePointer<GtkFlowBoxChild>>(gList:
			gtk_flow_box_get_selected_children(n_FlowBox))
		
		var selectedCildren = [Child]()
		
		for n_Child in n_Children {
			selectedCildren.append(_childWithPointer(n_Child))
		}
		
		return selectedCildren
	}
	
	/// Selects a single child of box, if the selection mode allows it.
	///
	/// - Parameter child: a child of box
	public func select(child: Child) {
		gtk_flow_box_select_child(n_FlowBox, child.n_FlowBoxChild)
	}
	
	/// Unselects a single child of box, if the selection mode allows it.
	///
	/// - Parameter child: a child of box
	public func unselect(child: Child) {
		gtk_flow_box_unselect_child(n_FlowBox, child.n_FlowBoxChild)
	}
	
	/// Select all children of box, if the selection mode allows it.
	public func selectAll() {
		gtk_flow_box_select_all(n_FlowBox)
	}
	
	/// Unselect all children of box, if the selection mode allows it.
	public func unselectAll() {
		gtk_flow_box_unselect_all(n_FlowBox)
	}
	
	/// The selection mode used by the flow box.
	public var selectionMode: SelectionMode {
		set {
			gtk_flow_box_set_selection_mode(n_FlowBox, newValue.rawValue)
		}
		get {
			return SelectionMode(rawValue:
				gtk_flow_box_get_selection_mode(n_FlowBox))!
		}
	}
	
	/// A function that will be called whenrever a child changes or is added. It
	/// lets you control if the child should be visible or not.
	///
	/// - Parameter child: a `FlowBox.Child` that may be filtered
	///
	/// - Returns: `true` if the row should be visible, `false` otherwise
	public typealias FilterFunc = (child: Child) -> Bool
	
	/// By setting a filter function on the box one can decide dynamically which
	/// of the children to show. For instance, to implement a search function that
	/// only shows the children matching the search terms.
	///
	/// The `filterFunc` will be called for each child after the call, and it will
	/// continue to be called each time a child changes (via
	/// `FlowBox.Child.changed()`) or when `invalidateFilter()` is called.
	///
	/// Note that using a filter function is incompatible with using a model (see
	/// gtk_flow_box_bind_model()).
	public var filterFunc: FilterFunc? {
		didSet {
			if filterFunc == nil {
				gtk_flow_box_set_filter_func(n_FlowBox, nil, nil, nil)
			} else {
				gtk_flow_box_set_filter_func(n_FlowBox, {
					n_Child, flowBox in
					let box = unsafeBitCast(flowBox, to: FlowBox.self)
					let child = box._childWithPointer(n_Child)
					return box.filterFunc!(child: child) ? 1 : 0
					}, unsafeBitCast(self, to: UnsafeMutablePointer<gpointer>.self), nil)
			}
		}
	}
	
	/// Updates the filtering for all children.
	///
	/// Call this function when the result of the filter function on the box is
	/// changed due ot an external factor. For instance, this would be used if the
	/// filter function just looked for a specific search term, and the entry with
	/// the string has changed.
	public func invalidateFilter() {
		gtk_flow_box_invalidate_filter(n_FlowBox)
	}
	
	/// A function to compare two children to determine which should come first.
	///
	/// - Parameter child1: the first child
	/// - Parameter child2: the second child
	///
	/// - Returns: < 0 if `child1` should be before `child2`, 0 if the are equal,
	///   and > 0 otherwise
	public typealias SortFunc = (child1: Child, child2: Child) -> Int
	
	/// By setting a sort function on the box , one can dynamically reorder the
	/// children of the box, based on the contents of the children.
	///
	/// The sortFunc will be called for each child after the call, and will
	/// continue to be called each time a child changes (via
	/// `FlowBox.Child.changed()`) and when `invalidateSort()` is called.
	///
	/// Note that using a sort function is incompatible with using a model (see
	/// `gtk_flow_box_bind_model()`).
	public var sortFunc: SortFunc? {
		didSet {
			if sortFunc == nil {
				gtk_flow_box_set_sort_func(n_FlowBox, nil, nil, nil)
			} else {
				gtk_flow_box_set_sort_func(n_FlowBox, {
					n_Child1, n_Child2, listBox in
					let box = unsafeBitCast(listBox, to: FlowBox.self)
					let child1 = box._childWithPointer(n_Child1)
					let child2 = box._childWithPointer(n_Child2)
					return gint(box.sortFunc!(child1: child1, child2: child2))
					}, unsafeBitCast(self, to: UnsafeMutablePointer<gpointer>.self), nil)
			}
		}
	}
	
	/// Updates the sorting for all children.
	///
	/// Call this when the result of the sort function on box is changed due to an
	/// external factor.
	public func invalidateSort() {
		gtk_flow_box_invalidate_sort(n_FlowBox)
	}
	
	// TODO: gtk_list_box_bind_model(), need gio-swift
	
	// MARK: - Overrides
	
	public override func addWidget(_ widget: Widget) {
		insert(child: widget, at: -1)
	}
	
	public override func removeWidget(_ widget: Widget) {
		func remove(widget: Widget) {
			gtk_container_remove(n_Container, widget.n_Widget)
			
			if let index = _children.index(of: widget) {
				_children.remove(at: index)
			}
		}
		
		if widget is Child {
			remove(widget: widget)
		} else {
			if let widget = widget.parent where widget is Child {
				remove(widget: widget)
			} else {
				print("Tried to remove non-child \(widget)")
				return
			}
		}
	}
	
	// MARK: - Signals
	
	/// - Parameter box: the `FlowBox` on which the signal is emitted
	public typealias ActivateCursorChildCallback = (box: FlowBox) -> Void
	public typealias ActivateCursorChildNative =
		(UnsafeMutablePointer<GtkFlowBox>,
		UnsafeMutablePointer<gpointer>)
		-> Void
	
	/// The `::activate-cursor-child` signal is a keybinding signal which gets
	/// emitted when the user activates the box.
	public lazy var activateCursorChildSignal:
		Signal<ActivateCursorChildCallback, FlowBox, ActivateCursorChildNative> =
		Signal(obj: self, signal: "activate-cursor-child", c_handler: {
			_, user_data in
			let data = unsafeBitCast(user_data,
			                         to: SignalData<FlowBox,
																ActivateCursorChildCallback>.self)
			
			let flowBox = data.obj
			let action = data.function
			
			action(box: flowBox)
		})
	
	/// - Parameter box: the `FlowBox` on which the signal is emitted
	/// - Parameter child: the child that is activated
	public typealias ChildActivatedCallback = (box: FlowBox, child: Child) -> Void
	public typealias ChildActivatedNative =
		(UnsafeMutablePointer<GtkFlowBox>,
		UnsafeMutablePointer<GtkFlowBoxChild>,
		UnsafeMutablePointer<gpointer>)
		-> Void
	
	/// The `::child-activated` signal is emitted when a child has been activated
	/// by the user.
	public lazy var childActivated:
		Signal<ChildActivatedCallback, FlowBox, ChildActivatedNative> =
		Signal(obj: self, signal: "child-activated", c_handler: {
			_, n_Child, user_data in
			let data = unsafeBitCast(user_data,
			                         to: SignalData<FlowBox,
																ChildActivatedCallback>.self)
			let flowBox = data.obj
			let action = data.function
			
			let child = flowBox._childWithPointer(n_Child)
			
			action(box: flowBox, child: child)
		})
	
	/// - Parameter box: the `FlowBox` on which the signal is emitted
	/// - Parameter step: the granularity fo the move, as a `MovementStep`
	/// - Parameter count: the number of `step` units to move
	///
	/// - Returns: `true` to stop other handlers from being invoked for the event.
	///   `false` to propagate the event further.
	public typealias MoveCursorCallback = (
		box: FlowBox,
		step: MovementStep,
		count: Int)
		-> Bool
	public typealias MoveCursorNative =
		(UnsafeMutablePointer<GtkFlowBox>,
		GtkMovementStep,
		gint,
		UnsafeMutablePointer<gpointer>)
		-> gboolean
	
	/// The `::move-cursor` signal is a keybinding signal which gets emitted when
	/// the user initiates a cursor movement.
	///
	/// Applications should not connect to it, but may emit it with `emit()` if
	/// they need to control the cursor programmatically.
	///
	/// The default bindings for this signal come in two variants, the variant
	/// with the Shift modifier extends the selection, the variant without the
	/// Shift modifer does not. There are too many key combinations to list them
	/// all here.
	///
	/// * Arrow keys move by individual children
	/// * Home/End keys move to the ends of the box
	/// * PageUp/PageDown keys move vertically by pages
	public lazy var moveCursorSignal:
		Signal<MoveCursorCallback, FlowBox, MoveCursorNative> =
		Signal(obj: self, signal: "move-cursor", c_handler: {
			_, n_Step, count, user_data in
			let data = unsafeBitCast(user_data,
			                         to: SignalData<FlowBox,
																MoveCursorCallback>.self)
			
			let flowBox = data.obj
			let action = data.function
			
			let step = MovementStep(rawValue: n_Step)!
			
			return action(box: flowBox, step: step, count: Int(count)) ? 1 : 0
		})
	
	/// - Parameter box: the `FlowBox` on which the signal is emitted
	public typealias SelectAllCallback = (
		box: FlowBox)
		-> Void
	public typealias SelectAllNative = (
		UnsafeMutablePointer<GtkFlowBox>,
		UnsafeMutablePointer<gpointer>)
		-> Void
	
	/// The `::select-all` signal is a keybinding signal which gets emitted to
	/// select all children of the box, if the selection mode permits it.
	///
	/// The default bindings for this signal is Ctrl-a.
	public lazy var selectAllSignal:
		Signal<SelectAllCallback, FlowBox, SelectAllNative> =
		Signal(obj: self, signal: "select-all", c_handler: {
			_, user_data in
			let data = unsafeBitCast(user_data,
			                         to: SignalData<FlowBox,
																SelectAllCallback>.self)
			
			let flowBox = data.obj
			let action = data.function
			
			action(box: flowBox)
		})
	
	/// - Parameter box: the `FlowBox` on which the signal is emitted
	public typealias SelectedChildrenChangedCallback = (
		box: FlowBox)
		-> Void
	public typealias SelectedChildrenChangedNative = (
		UnsafeMutablePointer<GtkFlowBox>,
		UnsafeMutablePointer<gpointer>)
		-> Void
	
	/// The `::selected-children-changed` signal is emitted when the set of 
	/// selected children changes.
	///
	/// Use `selectedForeach(_:)` or `selectedChildren` to obtain the selected 
	/// children.
	public lazy var selectedChildrenChangedSignal:
		Signal<SelectedChildrenChangedCallback, FlowBox,
		SelectedChildrenChangedNative> =
		Signal(obj: self, signal: "selected-children-changed", c_handler: {
			_, user_data in
			let data = unsafeBitCast(user_data,
			                         to: SignalData<FlowBox,
																SelectedChildrenChangedCallback>.self)
			
			let flowBox = data.obj
			let action = data.function
			
			action(box: flowBox)
		})
	
	/// - Parameter box: the `FlowBox` on which the signal is emitted
	public typealias ToggleCursorChildCallback = (
		box: FlowBox)
		-> Void
	public typealias ToggleCursorChildNative = (
		UnsafeMutablePointer<GtkFlowBox>,
		UnsafeMutablePointer<gpointer>)
		-> Void
	
	/// The `::toggle-cursor-child` signal is a keybinding signal which toggles
	/// the selection of the child that has the focus.
	///
	/// The default binding for this signal is Ctrl-Space.
	public lazy var toggleCursorChildSignal:
		Signal<ToggleCursorChildCallback, FlowBox, ToggleCursorChildNative> =
		Signal(obj: self, signal: "toggle-cursor-child", c_handler: {
			_, user_data in
			let data = unsafeBitCast(user_data,
			                         to: SignalData<FlowBox,
																ToggleCursorChildCallback>.self)
			
			let flowBox = data.obj
			let action = data.function
			
			action(box: flowBox)
		})
	
	/// - Parameter box: the `FlowBox` on which the signal is emitted
	public typealias UnselectAllCallback = (
		box: FlowBox)
		-> Void
	public typealias UnselectAllNative = (
		UnsafeMutablePointer<GtkFlowBox>,
		UnsafeMutablePointer<gpointer>)
		-> Void
	
	/// The `::unselect-all signal` is a keybinding signal which gets emitted to
	/// unselect all children of the box, if the selection mode permits it.
	///
	/// The default bindings for this signal is Ctrl-Shift-a.
	public lazy var unselectAllSignal:
		Signal<UnselectAllCallback, FlowBox, UnselectAllNative> =
		Signal(obj: self, signal: "unselect-all", c_handler: {
			_, user_data in
			let data = unsafeBitCast(user_data,
			                         to: SignalData<FlowBox,
																UnselectAllCallback>.self)
			
			let flowBox = data.obj
			let action = data.function
			
			action(box: flowBox)
		})
}
