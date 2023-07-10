// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "MuVisit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "MuVisit",
            targets: ["MuVisit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMajor(from: "1.0.0")
                )
    ],
    targets: [

        .target(
            name: "MuVisit",
            dependencies: [
                .product(name: "Collections", package: "swift-collections")
            ]),
        .testTarget(
            name: "MuVisitTests",
            dependencies: ["MuVisit"]),
    ]
)
