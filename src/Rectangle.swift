//
// Created by Alexander Zalutskiy on 13.01.16.
// Copyright (c) 2016 Metalhead. All rights reserved.
//

import CGTK

struct Rectangle {
	var origin: Point
	var size: Size

	// TODO: use gdk-swift
	internal var gdkRectangle: UnsafeMutablePointer<﻿_cairo_rectangle_int> {
		let allocation = UnsafeMutablePointer<Int32>.alloc(4)

		allocation.memory = Int32(origin.x)
		allocation.advancedBy(1).memory = Int32(origin.y)
		allocation.advancedBy(2).memory = Int32(size.width)
		allocation.advancedBy(3).memory = Int32(size.height)

		return unsafeBitCast(allocation, UnsafeMutablePointer<﻿_cairo_rectangle_int>.self)
	}
}
