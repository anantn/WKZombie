// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "WKZombie",
    products: [
        .library(name: "WKZombie", targets: ["WKZombie"]),
    ],
    dependencies: [
        .package(url: "https://github.com/cezheng/Fuzi.git", from: "3.1.3"),
    ],
    targets: [
        .target(
            name: "WKZombie",
            dependencies: ["Fuzi"]
        ),
        .target(
            name: "Example",
            dependencies: ["WKZombie"]
        ),
        .testTarget(
            name: "WKZombieTests",
            dependencies: ["WKZombie"],
            resources: [.copy("Resources")]
        ),
    ]
)
