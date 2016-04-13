import CGTK

let buttonCallback = { (button: Button, userData: gpointer) in
	print("Hello, World!")
}

let app = Application(applicationId: "org.gtk.example", flags: [])!
app.activateSignal.connect {
	(app) in
	let window = ApplicationWindow(application: app)
	window.title = "Window"
	window.borderWidth = 10

	let grid = Grid()
	window.addWidget(grid)

	let button = Button(label: "Button 1")
	button.clickedSignal.connect {
		_ in
	}
	grid.attachWidget(button, left: 0, top: 0, width: 1, height: 1)

	let button2 = Button(label: "Button 2")
	button2.clickedSignal.connect {
		_ in
		let dialog: MessageDialog = MessageDialog(window: window, flags: [.Modal], type: .Question, buttonsType: .YesNo, message: "Super test")

		for widget in dialog.getChildren() {
			print(String(widget.dynamicType))
		}

		_ = dialog.run()
		dialog.destroy()
	}
	grid.attachWidget(button2, left: 1, top: 0, width: 1, height: 1)

	let quitButton = Button(label: "Quit")
	quitButton.clickedSignal.connect{
		_ in
		window.destroy()
	}
	grid.attachWidget(quitButton, left: 0, top: 1, width: 2, height: 1)

	window.showAll()
}

let _ = app.run(Process.arguments)
