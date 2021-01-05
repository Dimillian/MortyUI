// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Codegen",
    dependencies: [
        .package(name: "Apollo",
                 url: "https://github.com/apollographql/apollo-ios.git",
                 .upToNextMinor(from: "0.39.0")),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.2.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Codegen",
            dependencies: [.product(name: "ApolloCodegenLib", package: "Apollo"),
                           .product(name: "ArgumentParser", package: "swift-argument-parser")]),
        .testTarget(
            name: "CodegenTests",
            dependencies: ["Codegen"]),
    ]
)
