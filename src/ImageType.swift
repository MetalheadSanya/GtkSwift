//
//  ImageType.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 06.05.16.
//
//

import CGTK

/// Describes the image data representation used by a `Image`. If you want to
/// get the image from the widget, you can only get the currently-stored
/// representation. e.g. if the `Image.storageType` is `Image.Type.Pixbuf`,
/// then you can call `Image.getPixbuf()` but not `Image.getStock()`. For
/// empty images, you can request any storage type (call any of the "get"
/// functions), but they will all return `nil` values.
public enum ImageType: RawRepresentable {
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