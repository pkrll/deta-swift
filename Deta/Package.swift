// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Deta",
    dependencies: [],
    targets: [
        .target(name: "Deta", dependencies: []),
        .testTarget(name: "DetaTests", dependencies: ["Deta"]),
    ]
)
