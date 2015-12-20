import CGTK

let buttonCallback = { (button: Button, userData: gpointer) in
	print("Hellow, World!")
}

let app = Application(applicationId: "org.gtk.example", flags: [])!
app.activateCallbacks.append({ (app: Application, userData: gpointer) -> Void in
	let window = ApplicationWindow(application: app)
	window.title = "Window"
	window.borderWidth = 10

	let grid = Grid()
	window.add(grid)

	let button = Button(label: "Button 1")
	button.clickedCallbacks.append(buttonCallback)
	grid.attachWidget(button, left: 0, top: 0, width: 1, height: 1)

	let button2 = Button(label: "Button 2")
	button2.clickedCallbacks.append(buttonCallback)
	grid.attachWidget(button2, left: 1, top: 0, width: 1, height: 1)

	let quitButton = Button(label: "Quit")
	quitButton.clickedCallbacks.append({ (button: Button, userData: gpointer) in
		window.destroy()
	})
	grid.attachWidget(quitButton, left: 0, top: 1, width: 2, height: 1)

	window.showAll()
})

let _ = app.run(Process.arguments)
