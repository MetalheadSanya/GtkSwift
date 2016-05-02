//
//  Image.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 01.05.16.
//
//

import CGTK

/// The `Image` widget displays an image. Various kinds of object can be 
/// displayed as an image; most typically, you would load a `Pixbuf` ("pixel 
/// buffer") from a file, and then display that. There’s a initializer to do
/// this, `Image.init(fileName:)`, used as follows:
///
/// 	let image = Image(fileName: "myfile.png")
///
/// If the file isn’t loaded successfully, the image will contain a “broken
/// image” icon similar to that used in many web browsers. If you want to handle
/// errors in loading the file yourself, for example by displaying an error
/// message, then load the image with `Pixbuf.init(fromFile:)`, then create the
/// `Image` with `Image.init(pixbuf:)`.
///
/// The image file may contain an animation, if so the `Image` will display an
/// animation (`PixbufAnimation`) instead of a static image.
///
/// `Image` is a subclass of `Misc`, which implies that you can align it
/// (center, left, right) and add padding to it, using `Misc` methods.
///
/// `Image` is a “no window” widget (has no `Window` of its own), so by default
/// does not receive events. If you want to receive events on the image, such as
/// button clicks, place the image inside a `EventBox`, then connect to the
/// event signals on the event box.
///
public class Image: Misc {
	internal var n_Image: UnsafeMutablePointer<GtkImage>
	
	internal init(n_Image: UnsafeMutablePointer<GtkImage>) {
		self.n_Image = n_Image
		super.init(n_Misc: UnsafeMutablePointer<GtkMisc>(n_Image))
	}
	
	/// Describes the image data representation used by a `Image`. If you want to
	/// get the image from the widget, you can only get the currently-stored
	/// representation. e.g. if the `Image.storageType` is `Image.Type.Pixbuf`,
	/// then you can call `Image.getPixbuf()` but not `Image.getStock()`. For
	/// empty images, you can request any storage type (call any of the "get"
	/// functions), but they will all return `nil` values.
	public enum `Type`: RawRepresentable {
		/// There is no image displayed by the widget
		case Empty
		/// The widget contains a `Pixbuf`
		case Pixbuf
		/// The widget contains a stock item name
		case Stock
		/// the widget contains a `PixbufAnimation`
		case PixbufAnimation
		/// The widget contains a named icon. This image type was added in GTK+ 2.6
		case IconName
		/// The widget contains a GIcon. This image type was added in GTK+ 2.14
		case Icon
		/// The widget contains a `Surface`. This image type was added in GTK+ 3.10
		case Surface
		
		public typealias RawValue = GtkImageType
		
		public var rawValue: RawValue {
			switch self {
			case .Empty:
				return GTK_IMAGE_EMPTY
			case .Pixbuf:
				return GTK_IMAGE_PIXBUF
			case .Stock:
				return GTK_IMAGE_STOCK
			case .PixbufAnimation:
				return GTK_IMAGE_ANIMATION
			case .IconName:
				return GTK_IMAGE_ICON_NAME
			case .Icon:
				return GTK_IMAGE_GICON
			case .Surface:
				return GTK_IMAGE_SURFACE
			}
		}
		
		public init?(rawValue: RawValue) {
			switch rawValue {
			case GTK_IMAGE_EMPTY:
				self = .Empty
			case GTK_IMAGE_PIXBUF:
				self = .Pixbuf
			case GTK_IMAGE_STOCK:
				self = .Stock
			case GTK_IMAGE_ANIMATION:
				self = .PixbufAnimation
			case GTK_IMAGE_ICON_NAME:
				self = .IconName
			case GTK_IMAGE_GICON:
				self = .Icon
			case GTK_IMAGE_SURFACE:
				self = .Surface
			default:
				return nil
			}
		}
	}
	
	// MARK: - Initializers
	
	/// Creates a new empty `Image` widget.
	public convenience init() {
		self.init(n_Image: UnsafeMutablePointer<GtkImage>(gtk_image_new()))
	}
	
	/// Creates a new `Image` displaying the file `fileName`. If the file isn’t
	/// found or can’t be loaded, the resulting `Image` will display a “broken
	/// image” icon. It always returns a valid `Image` widget.
	///
	/// If the file contains an animation, the image will contain an animation.
	///
	/// If you need to detect failures to load the file, use
	/// `Pixbuf.init(fromFile:)` to load the file yourself, then create the
	/// `Image` from the pixbuf. (Or for animations, use
	/// `PixbufAnimation.init(fromFile:)`.
	///
	/// The storage type (`Image.storageType`) of the returned image is not
	/// defined, it will be whatever is appropriate for displaying the file.
	///
	/// - Parameter filename: a filename.
	public convenience init(fileName: String) {
		self.init(n_Image:
			UnsafeMutablePointer<GtkImage>(gtk_image_new_from_file(fileName)))
	}
	
	/// Creates a `Image` displaying an icon from the current icon theme. If the
	/// icon name isn’t known, a “broken image” icon will be displayed instead. If
	/// the current icon theme is changed, the icon will be updated appropriately.
	///
	/// - Parameter iconName: an icon name
	/// - Parameter size: a stock icon size.
	public convenience init(iconName: String, iconSize size: IconSize) {
		self.init(n_Image:
			UnsafeMutablePointer<GtkImage>(
				gtk_image_new_from_icon_name(iconName, size.rawValue)))
	}
	
	/// Creates a new `Image` displaying the resource file `path` . If the
	/// file isn’t found or can’t be loaded, the resulting `Image` will display a
	/// “broken image” icon. It always returns a valid `Image` widget.
	///
	/// If the file contains an animation, the image will contain an animation.
	///
	/// If you need to detect failures to load the file, use
	/// `Pixbuf.init(fromFile:)` to load the file yourself, then create the
	/// `Image` from the pixbuf. (Or for animations, use
	/// `PixbufAnimation.init(fromFile:)`.
	///
	/// The storage type (`Image.storageType`) of the returned image is not
	/// defined, it will be whatever is appropriate for displaying the file.
	///
	/// - Parameter path: a resource path
	public convenience init(resourcePath path: String) {
		self.init(n_Image:
			UnsafeMutablePointer<GtkImage>(gtk_image_new_from_resource(path)))
	}
	
	// MARK: Getters
	
	public func getIconName() -> (iconName: String?, iconSize: IconSize?) {
		var n_IconName: UnsafePointer<gchar>? = nil
		var n_IconSize = GTK_ICON_SIZE_INVALID
		
		gtk_image_get_icon_name(n_Image, &n_IconName, &n_IconSize)
		
		let iconName: String?
		
		if let n_IconName = n_IconName {
			iconName = String(cString: n_IconName)
		} else {
			iconName = nil
		}
		
		return (iconName, IconSize(rawValue: n_IconSize))
	}
	
	// MARK: - Setters
	
	/// See `Image.init(fileName:) for details.
	///
	/// - Parameter fileName: a filename or `nil`.
	public func setFrom(fileName: String?) {
		gtk_image_set_from_file(n_Image, fileName)
	}
	
	/// See `Image.init(iconName:iconSize:) for details.
	///
	/// - Parameter iconName: an icon name
	/// - Parameter size: an icon size.
	public func setFrom(iconName: String, iconSize size: IconSize) {
		gtk_image_set_from_icon_name(n_Image, iconName, size.rawValue)
	}
	
	/// See `Image.init(resourcePath:)` for details.
	///
	/// - Parameter path: a resource path
	public func setFrom(resourcePath path: String) {
		gtk_image_set_from_resource(n_Image, path)
	}
	
	/// Resets the image to be empty.
	public func clear() {
		gtk_image_clear(n_Image)
	}
	
	// MARK: - Properties
	
	/// Gets the type of representation being used by the `Image` to store image
	/// data. If the `Image` has no image data, the value is `Image.Type.Empty`.
	public var storageType: Type {
		return Type(rawValue: gtk_image_get_storage_type(n_Image))!
	}
	
	/// The pixel size to use for named icons. If the pixel size is value != -1,
	/// it is used instead of the icon size set by
	/// `Image.setFrom(iconName:iconSize:)`.
	public var pixelSize: Int {
		get {
			return Int(gtk_image_get_pixel_size(n_Image))
		}
		set {
			gtk_image_set_pixel_size(n_Image, gint(newValue))
		}
	}
	
}
