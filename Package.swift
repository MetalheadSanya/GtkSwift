import PackageDescription

#if os(OSX)
let gtkUrl = "git@gitlab.com:gtk/cgtk-osx.git"
#else
let gtkUrl = "../cgtk"
#endif


let package = Package(dependencies: [
		.Package(url: gtkUrl, majorVersion: 1),
		.Package(url: "git@gitlab.com:gtk/gobject-swift.git", majorVersion: 1)
])
