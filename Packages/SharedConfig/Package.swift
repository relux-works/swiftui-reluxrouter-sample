// swift-tools-version: 6.2
import PackageDescription

// Interface package
let package = Package(
    name: "SharedConfig",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "SharedConfig", type: .dynamic, targets: ["SharedConfig"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SharedConfig",
            dependencies: [
            ],
            path: "Sources",
            swiftSettings: [
                .swiftLanguageMode(.v6),
                .enableUpcomingFeature("StrictConcurrency"),
                .enableUpcomingFeature("ConciseMagicFile"),
                .enableUpcomingFeature("DisableOutwardActorInference"),
                .enableUpcomingFeature("GlobalActorIsolatedTypesUsability"),
                .enableUpcomingFeature("InferIsolatedConformances"),
                .enableUpcomingFeature("InferSendableFromCaptures"),
                .enableUpcomingFeature("GlobalConcurrency"),
                .enableUpcomingFeature("MemberImportVisibility"),
                .enableUpcomingFeature("NonfrozenEnumExhaustivity"),
                .enableUpcomingFeature("RegionBasedIsolation"),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
            ]
        ),
    ]
)
