//
//  License.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 13.04.16.
//
//

import CGTK

public enum License: RawRepresentable {
	case Unknown, Custom, GPL_2_0, GPL_3_0, LGPL_2_1, LGPL_3_0, BSD, MIT_X11, Artistic, GPL_2_0_Only, GPL_3_0_Only, LGPL_2_1_Only, LGPL_3_0_Only
	
	public typealias RawValue = GtkLicense
	
	public var rawValue: RawValue {
		switch self {
		case .Unknown:
			return GTK_LICENSE_UNKNOWN
		case .Custom:
			return GTK_LICENSE_CUSTOM
		case .GPL_2_0:
			return GTK_LICENSE_GPL_2_0
		case .GPL_3_0:
			return GTK_LICENSE_GPL_3_0
		case .LGPL_2_1:
			return GTK_LICENSE_LGPL_2_1
		case .LGPL_3_0:
			return GTK_LICENSE_LGPL_3_0
		case .BSD:
			return GTK_LICENSE_BSD
		case .MIT_X11:
			return GTK_LICENSE_MIT_X11
		case .Artistic:
			return GTK_LICENSE_ARTISTIC
		case .GPL_2_0_Only:
			return GTK_LICENSE_GPL_2_0_ONLY
		case .GPL_3_0_Only:
			return GTK_LICENSE_GPL_3_0_ONLY
		case .LGPL_2_1_Only:
			return GTK_LICENSE_LGPL_2_1_ONLY
		case .LGPL_3_0_Only:
			return GTK_LICENSE_LGPL_3_0_ONLY
		}
	}
	
	public init?(rawValue: RawValue) {
		switch rawValue {
		case GTK_LICENSE_UNKNOWN:
			self = .Unknown
		case GTK_LICENSE_CUSTOM:
			self = .Custom
		case GTK_LICENSE_GPL_2_0:
			self = .GPL_2_0
		case GTK_LICENSE_GPL_3_0:
			self = .GPL_3_0
		case GTK_LICENSE_LGPL_2_1:
			self = .LGPL_2_1
		case GTK_LICENSE_LGPL_3_0:
			self = .LGPL_3_0
		case GTK_LICENSE_BSD:
			self = .BSD
		case GTK_LICENSE_MIT_X11:
			self = .MIT_X11
		case GTK_LICENSE_ARTISTIC:
			self = .Artistic
		case GTK_LICENSE_GPL_2_0_ONLY:
			self = .GPL_2_0_Only
		case GTK_LICENSE_GPL_3_0_ONLY:
			self = .GPL_3_0_Only
		case GTK_LICENSE_LGPL_2_1_ONLY:
			self = .LGPL_2_1_Only
		case GTK_LICENSE_LGPL_3_0_ONLY:
			self = .LGPL_3_0_Only
		default:
			return nil
		}
	}
}
