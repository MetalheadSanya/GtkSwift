//
//  PackType.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 15.04.16.
//
//

import CGTK

public enum PackType: RawRepresentable {
	case Start, End
	
	public typealias RawValue = GtkPackType
	
	public var rawValue: RawValue {
		switch self {
		case .Start:
			return GTK_PACK_START
		case .End:
			return GTK_PACK_END
		}
	}
	
	public init?(rawValue: RawValue) {
		switch rawValue {
		case GTK_PACK_START:
			self = .Start
		case GTK_PACK_END:
			self = .End
		default:
			return nil
		}
	}
}
