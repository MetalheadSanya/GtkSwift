GtkSwift
=======

This is a GTK+ language binding project for Swift programming language.

## Code Example

```swift
import gtkswift

let buttonCallback = { (button: Button, userData: gpointer) in
	print("Hello, World!")
}

let app = Application(applicationId: "org.gtk.example", flags: [])!
app.activateSignal.connect {
	(app) in
	let window = ApplicationWindow(application: app)
	window.title = "Window"
	window.borderWidth = 10

	let listBox = ListBox()
	window.addWidget(listBox)

	let button = Button(label: "Button 1")
	button.clickedSignal.connect {
		_ in
	}

	let button2 = Button(label: "Button 2")
	button2.clickedSignal.connect {
		_ in
		let dialog = AboutDialog()
		dialog.programName = "Test"
		dialog.version = "1.0.0"

		_ = dialog.run()
		dialog.destroy()
	}

	let quitButton = Button(label: "Quit")
	quitButton.clickedSignal.connect{
		_ in
		window.destroy()
	}
	
	listBox.prepend(child: quitButton)
	listBox.prepend(child: button2)
	listBox.prepend(child: button)

	window.showAll()
}

let _ = app.run(Process.arguments)

```

## Motivation

This project help creates cross-platform UI application using Swift programming language.

## Installation

For integrate GtkSwift into your project append 
```swift
.Package(url: "git@gitlab.com:gtk/gtk-swift.git", majorVersion: 1)
```
into your `Package.swift` file

## API Reference

You can find API on https://gtk.gitlab.io/gtk-swift/

## Contributors

Please create issues and pull request on main repository of project on https://gitlab.com/gtk/gtk-swift

## License

GtkSwift is available under the BSD3 license. See the LICENSE file for more info.