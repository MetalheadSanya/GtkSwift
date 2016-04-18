//
//  HeaderBar.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 18.04.16.
//
//

import CGTK

/// `HeaderBar` is similar to a horizontal GtkBox. It allows children to be
/// placed at the start or the end. In addition, it allows a title and subtitle
/// to be displayed. The title will be centered with respect to the width of the
/// box, even if the children at either side take up different amounts of space.
/// The height of the titlebar will be set to provide sufficient space for the
/// subtitle, even if none is currently set. If a subtitle is not needed, the
/// space reservation can be turned off with `hasSubtitle` property.
///
/// HeaderBar can add typical window frame controls, such as minimize, maximize
/// and close buttons, or the window icon.
public class HeaderBar: Container {
	internal var n_HeaderBar: UnsafeMutablePointer<GtkHeaderBar>
	
	internal init(n_HeaderBar: UnsafeMutablePointer<GtkHeaderBar>) {
		self.n_HeaderBar = n_HeaderBar
		super.init(n_Container: UnsafeMutablePointer<GtkContainer>(n_HeaderBar))
	}
	
	/// Creates a new `HeaderBar` widget.
	public convenience init() {
		self.init(n_HeaderBar:
			UnsafeMutablePointer<GtkHeaderBar>(gtk_header_bar_new()))
	}
	
	/// The title should help a user identify the current view. A good title 
	/// should not include the application name.
	public var title: String {
		set {
			gtk_header_bar_set_title(n_HeaderBar, newValue)
		}
		get {
			return String(cString: gtk_header_bar_get_title(n_HeaderBar))
		}
	}
	
	/// The title should give a user an additional detail to help him identify the
	/// current view.
	///
	/// - Note: `HeaderBar` by default reserves room for the subtitle, even if 
	/// none is currently set. If this is not desired, set the `hasSubtitle`
	/// property to `false`.
	public var subtitle: String {
		set {
			gtk_header_bar_set_subtitle(n_HeaderBar, subtitle)
		}
		get {
			return String(cString: gtk_header_bar_get_subtitle(n_HeaderBar))
		}
	}

	/// Whether the header bar should reserve space for a subtitle, even if none
	/// is currently set.
	public var hasSubtitle: Bool {
		set {
			gtk_header_bar_set_has_subtitle(n_HeaderBar, newValue ? 1 : 0)
		}
		get {
			return gtk_header_bar_get_has_subtitle(n_HeaderBar) != 0
		}
	}
	
	internal weak var _customTitle: Widget?
	
	/// Center widget; that is a child widget that will be centered with respect
	/// to the full width of the box, even if the children at either side take up
	/// different amounts of space.
	public var customTitle: Widget? {
		set {
			gtk_header_bar_set_custom_title(n_HeaderBar, newValue?.n_Widget)
			
			_customTitle = newValue
		}
		get {
			let n_Widget = gtk_header_bar_get_custom_title(n_HeaderBar)
			
			if n_Widget == _customTitle?.n_Widget {
				return _customTitle
			}
			
			if let n_Widget = n_Widget {
				print("WARNING: [HeaderBar.customTitle] generate widget from pointer")
				let widget =
					Container.correctWidgetForWidget(Widget(n_Widget: n_Widget))
				_customTitle = widget
				return widget
			}
			
			return nil
		}
	}

	/// Adds `child` to bar, packed with reference to the start of the bar.
	///
	/// - Parameter child: the `Widget` to be added to bar
	public func packStart(child: Widget) {
		guard child.parent == nil else { return }
		
		gtk_header_bar_pack_start(n_HeaderBar, child.n_Widget)
		
		if !_children.contains(child) {
			_children.append(child)
		}
	}
	
	/// Adds `child` to bar, packed with reference to the end of the bar.
	///
	/// Parameter child: the `Widget` to be added to bar
	public func packEnd(child: Widget) {
		guard child.parent == nil else { return }
		
		gtk_header_bar_pack_end(n_HeaderBar, child.n_Widget)
		
		if !_children.contains(child) {
			_children.append(child)
		}
	}
	
	/// Whether this header bar shows the standard window decorations, including
	/// close, maximize, and minimize.
	public var showCloseButton: Bool {
		set {
			gtk_header_bar_set_show_close_button(n_HeaderBar, newValue ? 1 : 0)
		}
		get {
			return gtk_header_bar_get_show_close_button(n_HeaderBar) != 0
		}
	}
	
	/// The decoration layout for this header bar, overriding the
	/// `DecorationLayout` setting.
	///
	/// There can be valid reasons for overriding the setting, such as a header
	/// bar design that does not allow for buttons to take room on the right, or
	/// only offers room for a single close button. Split header bars are another
	/// example for overriding the setting.
	///
	/// The format of the string is button names, separated by commas. A colon
	/// separates the buttons that should appear on the left from those on the
	/// right. Recognized button names are minimize, maximize, close, icon (the
	/// window icon) and menu (a menu button for the fallback app menu).
	///
	/// For example, `“menu:minimize,maximize,close”` specifies a menu on the
	/// left, and minimize, maximize and close buttons on the right.
	public var decorationLayout: String {
		set {
			gtk_header_bar_set_decoration_layout(n_HeaderBar, newValue)
		}
		get {
			return String(cString: gtk_header_bar_get_decoration_layout(n_HeaderBar))
		}
	}
}
