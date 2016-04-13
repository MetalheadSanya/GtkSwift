//
// Created by Alexander Zalutskiy on 13.01.16.
// Copyright (c) 2016 Metalhead. All rights reserved.
//

import CGTK

struct Rectangle {
	var origin: Point
	var size: Size

	// TODO: use gdk-swift
	internal var gdkRectangle: UnsafeMutablePointer<GtkAllocation> {
		let allocation = UnsafeMutablePointer<Int32>(allocatingCapacity: 4)

		allocation.pointee = Int32(origin.x)
		allocation.advanced(by: 1).pointee = Int32(origin.y)
		allocation.advanced(by: 2).pointee = Int32(size.width)
		allocation.advanced(by: 3).pointee = Int32(size.height)

		return unsafeBitCast(allocation, to: UnsafeMutablePointer<GtkAllocation>.self)
	}
}
