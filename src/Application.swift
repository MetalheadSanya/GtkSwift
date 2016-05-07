import CGTK
import gobjectswift

#if os(Linux)
	import Glibc
#endif

public typealias ApplicationActivateCallback = (Application) -> Void
public typealias ApplicationWindowAddedCallback = (Application, Window!) -> Void
public typealias ApplicationWindowRemovedCallback = (Application, Window!) -> Void

public class Application: Object {
	internal var n_App: UnsafeMutablePointer<GtkApplication>

	internal var _windows = [Window]()

	var windows: [Window] {
		return _windows
	}

	public init?(applicationId: String, flags: [ApplicationFlag]) {
		let totalFlag = flags.reduce(0) { $0 | $1.rawValue }
		
		n_App = gtk_application_new(applicationId, GApplicationFlags(totalFlag))
		super.init(n_Object: unsafeBitCast(n_App, to: UnsafeMutablePointer<GObject>.self))
	}

	deinit {
		g_object_unref (n_App)
	}

	// MARK: - GApplication

	public func run(_ arguments: [String]) -> Int {
		return Int(g_application_run (UnsafeMutablePointer<GApplication> (n_App), Int32(arguments.count), arguments.withUnsafeBufferPointer {
			let buffer = UnsafeMutablePointer<UnsafeMutablePointer<CChar>?>(allocatingCapacity: $0.count + 1)
			buffer.initializeFrom($0.map { $0.withCString(strdup) })
			buffer[$0.count] = nil
			return buffer
		}))
	}

	public typealias ApplicationActivateNative = @convention(c)(UnsafeMutablePointer<GtkApplication>, gpointer) -> Void

	public lazy var activateSignal: Signal<ApplicationActivateCallback, Application, ApplicationActivateNative>
			= Signal(obj: self, signal: "activate", c_handler: {
				(_, user_data) in
				let data = unsafeBitCast(user_data, to: SignalData<Application, ApplicationActivateCallback>.self)

				let application = data.obj
				let action = data.function

				action(application)
			})

	public typealias ApplicationWindowAddedNative = @convention(c)(UnsafeMutablePointer<GtkApplication>,
			UnsafeMutablePointer<GtkWindow>, gpointer) -> Void

	/// Emitted when a Window is added to application through Application.addWindow(_:).
	public lazy var windowAddedSignal: Signal<ApplicationWindowAddedCallback, Application, ApplicationWindowAddedNative>
			= Signal(obj: self, signal: "window-added", c_handler: {
				(_, n_Window, user_data) in
				let data = unsafeBitCast(user_data, to: SignalData<Application, ApplicationWindowAddedCallback>.self)

				let application = data.obj
				let window = application._getWindowForNativeWindow(n_Window)
				let action = data.function

				action(application, window)
			})

	public typealias ApplicationWindowRemovedNative = @convention(c)(UnsafeMutablePointer<GtkApplication>,
			UnsafeMutablePointer<GtkWindow>, gpointer) -> Void

	public lazy var windowRemovedSignal: Signal<ApplicationWindowRemovedCallback, Application, ApplicationWindowRemovedNative>
			= Signal(obj: self, signal: "window-removed", c_handler: {
				(_, n_Window, user_data) in
				let data = unsafeBitCast(user_data, to: SignalData<Application, ApplicationWindowRemovedCallback>.self)

				let application = data.obj
				let window = application._getWindowForNativeWindow(n_Window)
				let action = data.function

				action(application, window)
			})
}

// MARK: - Windows
extension Application {

	internal func _getWindowForNativeWindow(_ n_Window: UnsafeMutablePointer<GtkWindow>) -> Window! {
		for window in _windows {
			if window.n_Window == n_Window {
				return window
			}
		}
		return nil
	}

	internal func _addWindowToApplicationStack(_ window: Window) {
		_windows.append(window)
	}

	public func addWindow(_ window: Window) {
		_windows.append(window)
		gtk_application_add_window(n_App, window.n_Window)
	}

	public func removeWindow(_ window: Window) {
		if let index = _windows.index(of: window) {
			_windows.remove(at: index)
		}
		
		gtk_application_remove_window(n_App, window.n_Window)
	}

	public var activeWindow: Window! {
		let n_Window = gtk_application_get_active_window(n_App)
		return _getWindowForNativeWindow(n_Window)
	}

	// TODO: in future
	// func windowWithId(id: Int) -> Window? {

	// }
}

extension Application: Equatable { }

public func ==(lhs: Application, rhs: Application) -> Bool {
	return lhs.n_App == rhs.n_App
}

public enum ApplicationFlag: UInt32 {
	case None = 0b00000001
	case IsService = 0b00000010
	case IsLauncher = 0b00000100

	case HandlesOpen = 0b00001000
	case HandlesCommandLine = 0b00010000
	case SendEnvironent = 0000100000

	case NonUnique = 0b01000000
}
