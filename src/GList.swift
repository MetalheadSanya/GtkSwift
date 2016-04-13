import CGTK

extension Array {
	init(gList: UnsafeMutablePointer<GList>?) {
		var list = gList
		var data = [Element]()

		if list?.pointee.data != nil {

			repeat {
				data.append(unsafeBitCast(list!.pointee.data, to: Element.self))
				list = list!.pointee.next
			} while list != nil
		}

		self.init(data)
	}
}