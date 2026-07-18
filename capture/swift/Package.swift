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

        .systemLibrary(
            name: "CZMQ",
            path: "CZMQ",
            pkgConfig: "libzmq"
        ),

        .executableTarget(
            name: "CaptureBridge",
            dependencies: [
                "CZMQ"
            ]
        )
    ]
)