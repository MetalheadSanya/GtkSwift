import CGTK

internal class GTypeHelper {
	private static let widgetType: GType = gtk_widget_get_type()
	private static let containerType = gtk_container_get_type()
	private static let binType = gtk_bin_get_child_type()

	class func convertToClass(type: GType) -> AnyObject.Type? {
		

		if type == widgetType {
			return Widget.self
		} else if type == containerType {
			return Container.self
		} else if type == binType {
			return Bin.self
		} else {
			return nil
		}
	}
}