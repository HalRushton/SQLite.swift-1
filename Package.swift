// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "SQLite.swift",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
        .watchOS(.v4),
        .tvOS(.v11)
    ],
    products: [
        .library(
            name: "SQLite",
            targets: ["SQLite"]
        )
    ],
    dependencies: [
        .package(url: "git@github.com:HalRushton/SQLCipher.git", from: "0.0.4"),
    ],
    targets: [
        .target(
            name: "SQLite",
            dependencies: [
                "SQLCipher",
            ],
            exclude: [
                "Info.plist"
            ],
            swiftSettings: [
                .define("SQLITE_SWIFT_SQLCIPHER"),
            ]
        ),
        .testTarget(
            name: "SQLiteTests",
            dependencies: [
                "SQLite",
            ],
            path: "Tests/SQLiteTests",
            exclude: [
                "Info.plist"
            ],
            resources: [
                .copy("Resources")
            ]
        )
    ]
)

#if os(Linux)
package.dependencies = [
    .package(url: "https://github.com/stephencelis/CSQLite.git", from: "0.0.3")
]
package.targets.first?.dependencies += [
    .product(name: "CSQLite", package: "CSQLite")
]
#endif
