// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Deta",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [.library(name: "Deta", targets: ["Deta"])],
    dependencies: [],
    targets: [
        .target(name: "Deta"),
        .testTarget(name: "DetaTests", dependencies: ["Deta"])
    ]
)
