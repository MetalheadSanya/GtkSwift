import PackageDescription

let package = Package(
    dependencies: [
        .Package(url: "../cgtk", majorVersion: 1),
        .Package(url: "../gobject-swift", majorVersion: 1)
    ]
)
