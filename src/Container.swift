import CGTK

public class Container: Widget {

	internal var n_Container: UnsafeMutablePointer<GtkContainer>

	internal var _children = [Widget]()
	internal var _internalChildren = [Widget]()

	override class var n_Type: UInt {
		return gtk_container_get_type()
	}

	internal init(n_Container: UnsafeMutablePointer<GtkContainer>) {
		self.n_Container = n_Container
		super.init(n_Widget:
			unsafeBitCast(n_Container, to: UnsafeMutablePointer<GtkWidget>.self))
	}

	public func addWidget(_ widget: Widget) {
		guard widget.parent == nil else { 
			print("Attempting to add a widget to a container, but the widget is " +
				"already inside a container, please remove the widget from its " +
				"existing container first.")
			return 
		}

		gtk_container_add(n_Container, widget.n_Widget)
		
		if !_children.contains(widget) {
			_children.append(widget)
		}
		
		widget.parent = self
	}

	internal func outsideGtkAddWidget(_ widget: Widget) {
		guard widget.parent == nil else {
			print("Attempting to add a widget to a container, but the widget is " +
				"already inside a container, please remove the widget from its " +
				"existing container first.")
			return
		}

		_children.append(widget)
//		widget.parent = self
	}

	public func removeWidget(_ widget: Widget) {
		guard widget != self else { return }

		gtk_container_remove(n_Container, widget.n_Widget)

		guard let index = _children.index(of: widget) else { return }
		_children.remove(at: index)
		widget.parent = nil
	}
	
	internal func _clearChildren() {
		var children = [Widget]()
		
		let n_Children = Array<UnsafeMutablePointer<GtkWidget>>(
			gList: gtk_container_get_children(n_Container))
		
		for n_Child in n_Children {
			var child = _children.filter{ $0.n_Widget == n_Child }.first
			
			if child == nil {
				child = Container.correctWidgetForWidget(Widget(n_Widget: n_Child))
			}
			
			children.append(child!)
		}
		
		_children = children
	}

	// TODO: some for gtk_container_add_with_properties, vardic func

	public func checkResize() {
		gtk_container_check_resize(n_Container)
	}

	public func forEach(_ f: (Widget) -> Void) {
		_ = _children.map(f)
	}

	public func getChildren() -> [Widget] {
		return _children
	}

	// TODO: some for gtk_container_get_path_for_child(), need GtkWidgetPath class

	public var focusChild: Widget? {
		get {
			let pWidget = gtk_container_get_focus_child(n_Container)

			for widget in _children {
				guard widget.n_Widget == pWidget else { continue }

				return widget
			}

			for widget in _internalChildren {
				guard widget.n_Widget == pWidget else { continue }

				return widget
			}

			return nil
		}
		set(value) {
			if let value = value {
				guard _children.contains(value) || _internalChildren.contains(value)
					else { return }
			}

			let pWidget = value?.n_Widget ?? nil

			gtk_container_set_focus_child(n_Container, pWidget)
		}
	}

	// TODO: some for gtk_container_get_focus_vadjustment(), 
	//       gtk_container_set_focus_vadjustment(), need GtkAdjustment class
	// TODO: some for gtk_container_get_focus_hadjustment(), 
	//       gtk_container_set_focus_hadjustment(), need GtkAdjustment class

	public func childType() -> AnyObject.Type? {
		return GTypeHelper.convertToClass(gtk_container_child_type(n_Container))
	}

	// TODO: some for gtk_container_child_get(), gtk_container_child_set(), 
	//       need vardic

	// TODO: some for gtk_container_child_get_property(), 
	//       gtk_container_child_set_property(), realy need?

	// TODO: some for gtk_container_child_get_valist(), 
	//       gtk_container_child_set_valist(), need valist

	// TODO: some for gtk_container_child_notify(), idea about signal

	public func forAll(_ f: (Widget) -> Void) {
		_ = _children.map(f)

		_ = _internalChildren.map(f)
	}

	public var borderWidth: Int {
		get {
			return Int(gtk_container_get_border_width(n_Container))
		}
		set(value) {
			gtk_container_set_border_width(n_Container, UInt32(value))
		}
	}

	// TODO: some for gtk_container_propagate_draw(), use cario-swift

	// TODO: finish class
}