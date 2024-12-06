// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MMLanScan",
    products: [
        .library(
            name: "MMLanScan",
            targets: ["MMLanScan"]),
    ],
    targets: [
        .target(
            name: "MMLanScan",
            dependencies: ["MMLanScanInternal"]
        ),
        .target(
            name: "MMLanScanInternal",
            dependencies: [
                "MacFinder",
                "SimplePing"
            ],
            resources: [
                .process("Data")
            ]
        ),
        .target(name: "MacFinder"),
        .target(name: "SimplePing")
    ]
)
