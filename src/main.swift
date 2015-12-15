import CGTK

let app = Application(applicationId: "org.gtk.example", flags: [])!
app.activateCallbacks.append({ (app: Application, userData: gpointer) -> Void in
	let window = ApplicationWindow(application: app)
	window.title = "Test"
	// window.defaultSize = Size(width: 200, height: 200)

	let buttonBox = ButtonBox(orientation: .Horizontal)
	window.add(buttonBox)

	let button = Button(label: "Hello, World!")

	button.clickedCallbacks.append({ (button: Button, userData: gpointer) in 
		print("Hello, World!")
	})

	button.clickedCallbacks.append({ (button: Button, userData: gpointer) in 
		window.destroy()
	})

	buttonBox.add(button)

	window.showAll()
})

let _ = app.run(Process.arguments)
