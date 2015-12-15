import CGTK

extension Array {
	init(gList: UnsafeMutablePointer<GList>) {
		var list = gList
		var data = [Element]()

		if list.memory.data != nil {

			repeat {
				data.append(unsafeBitCast(list.memory.data, Element.self))
				list = list.memory.next
			} while list != nil
		}

		self.init(data)
	}
}