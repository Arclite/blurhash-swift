// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "blurhash-swift",
    products: [
        .library(
            name: "BlurHash",
            targets: ["BlurHash"]
        ),
    ],
    targets: [
        .target(name: "BlurHash"),
        .testTarget(
            name: "BlurHashTests",
            dependencies: [
                .byName(name: "BlurHash"),
            ],
            resources: [
                .copy("./TestResources"),
            ]
        )
    ]
)
