// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Deta",
    products: [.library(name: "Deta", targets: ["Deta"])],
    dependencies: [
        .package(url: "https://github.com/pkrll/Network", from: "0.1.0")
    ],
    targets: [
        .target(name: "Deta", dependencies: ["Network"]),
        .testTarget(name: "DetaTests", dependencies: ["Deta"]),
    ]
)
