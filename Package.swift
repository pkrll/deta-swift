// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "deta-swift",
    products: [.library(name: "Deta", targets: ["Deta"])],
    dependencies: [],
    targets: [
        .target(name: "Deta", dependencies: [""])
    ]
)
