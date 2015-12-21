import CGTK
import Glibc

typealias ApplicationActivateCallback = (Application, gpointer) -> Void

class Application {
	internal var n_App: UnsafeMutablePointer<GtkApplication>

	internal var _windows = [Window]()

	var windows: [Window] {
		return _windows
	}

	init?(applicationId: String, flags: [ApplicationFlag]) {
		let totalFlag = flags.reduce(0) { $0 | $1.rawValue }
		
		n_App = gtk_application_new(applicationId, GApplicationFlags(totalFlag))

		if n_App != nil {
			ApplicationNotificationCenter.sharedInstance.registerForActivate(self, fromNativeApp: n_App)

			g_signal_connect (n_App, "activate", unsafeBitCast(activate, UnsafePointer<Void>.self), nil)			
		} else {
			return nil
		}
	}

	deinit {
		ApplicationNotificationCenter.sharedInstance.unregisterForActivate(self)
		g_object_unref (n_App)
	}

	// MARK: - GApplication

	func run(arguments: [String]) -> Int{
		return Int(g_application_run (UnsafeMutablePointer<GApplication> (n_App), Int32(arguments.count), arguments.withUnsafeBufferPointer {
			let buffer = UnsafeMutablePointer<UnsafeMutablePointer<CChar>>.alloc($0.count + 1)
			buffer.initializeFrom($0.map { $0.withCString(strdup) })
			buffer[$0.count] = nil
			return buffer
		}))
	}

	private let activate: @convention(c) (app: UnsafeMutablePointer<GtkApplication>,
                               user_data: gpointer) -> Void = {
		ApplicationNotificationCenter.sharedInstance.activateFromApp($0, userData: $1)
	}

	var activateCallbacks = [ApplicationActivateCallback]()
}

// MARK: - Windows
extension Application { 
	
	func addWindow(window: Window) {
		_windows.append(window)
		gtk_application_add_window(n_App, window.n_Window)
	}

	func removeWindow(window: Window) {
		if let index = _windows.indexOf(window) {
			_windows.removeAtIndex(index)
		}
		
		gtk_application_remove_window(n_App, window.n_Window)
	}

	var activeWindow: Window! {
		let n_Window = gtk_application_get_active_window(n_App)
		for window in _windows {
			if window.n_Window == n_Window {
				return window
			}
		}
		return nil
	}

	// TODO: in future
	// func windowWithId(id: Int) -> Window? {
		
	// }
}

extension Application: Equatable { }

func ==(lhs: Application, rhs: Application) -> Bool {
	return lhs.n_App == rhs.n_App
}

private class ApplicationNotificationCenter {
	static let sharedInstance = ApplicationNotificationCenter()

	private var registers = [(app: Application, gtkApp: UnsafeMutablePointer<GtkApplication>)]()

	func registerForActivate(obj: Application, fromNativeApp app: UnsafeMutablePointer<GtkApplication>) {
		registers.append((obj, app))
	}

	func unregisterForActivate(obj: Application) {
		registers = registers.filter { $0.app == obj }
	}

	func activateFromApp(app: UnsafeMutablePointer<GtkApplication>, userData: gpointer) {
		let forPerform = registers.filter { $0.gtkApp == app }

		for (obj, _) in forPerform {
			let _ = obj.activateCallbacks.map { $0(obj, userData) }
		}
	}
}

enum ApplicationFlag: UInt32 {
	case None = 0b00000001
	case IsService = 0b00000010
	case IsLauncher = 0b00000100

	case HandlesOpen = 0b00001000
	case HandlesCommandLine = 0b00010000
	case SendEnvironent = 0000100000

	case NonUnique = 0b01000000
}
