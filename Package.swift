// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIViews",
    
    platforms: [
      .iOS(.v13),
      .watchOS(.v6),
      .tvOS(.v13),
      .macOS(.v10_15)
    ],
    
    products: [
        .library(
            name: "SwiftUIViews",
            targets: ["SwiftUIViews"]),
    ],
        
    targets: [
        .target(
            name: "SwiftUIViews",
            dependencies: []),
    ]
)
