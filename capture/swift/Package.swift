// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "CaptureBridge",

    platforms: [
        .macOS(.v15)
    ],

    products: [
        .executable(
            name: "CaptureBridge",
            targets: ["CaptureBridge"]
        )
    ],

    targets: [
        .executableTarget(
            name: "CaptureBridge"
        )
    ]
)