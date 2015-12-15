import PackageDescription

let package = Package(
    dependencies: [
        .Package(url: "../CGTK", majorVersion: 1)
    ]
)
