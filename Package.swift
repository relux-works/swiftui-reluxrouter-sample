// swift-tools-version: 6.2
import PackageDescription

let modulesPath = "Packages"

let package = Package(
    name: "ReluxRouterSampleDependencies",
    dependencies: [
        .package(path: "Packages/SharedConfig"),
        .package(url: "https://github.com/relux-works/swiftui-reluxrouter.git", from: "12.1.0"),
        .package(name: "SwiftIoC", url: "https://github.com/relux-works/swift-ioc.git", .upToNextMajor(from: "1.0.3")),
        .package(name: "swiftui-relux", url: "https://github.com/relux-works/swiftui-relux.git", .upToNextMajor(from: "9.0.0")),
    ],
    targets: []
)


#if TUIST
import ProjectDescription

let swiftPackageTargetSettings: Settings = .settings(base: [
    "SWIFT_VERSION": "6.0",
    "SWIFT_STRICT_MEMORY_SAFETY": "YES",
    "SWIFT_APPROACHABLE_CONCURRENCY": "NO",
    "SWIFT_DEFAULT_ACTOR_ISOLATION": "nonisolated",
    "SWIFT_STRICT_CONCURRENCY_DEFAULT": "complete",
    "SWIFT_STRICT_CONCURRENCY": "complete",
    "SWIFT_UPCOMING_FEATURE_CONCISE_MAGIC_FILE": "YES",
    "SWIFT_UPCOMING_FEATURE_DISABLE_OUTWARD_ACTOR_ISOLATION": "YES",
    "SWIFT_UPCOMING_FEATURE_GLOBAL_ACTOR_ISOLATED_TYPES_USABILITY": "YES",
    "SWIFT_UPCOMING_FEATURE_INFER_ISOLATED_CONFORMANCES": "YES",
    "SWIFT_UPCOMING_FEATURE_INFER_SENDABLE_FROM_CAPTURES": "YES",
    "SWIFT_UPCOMING_FEATURE_GLOBAL_CONCURRENCY": "YES",
    "SWIFT_UPCOMING_FEATURE_MEMBER_IMPORT_VISIBILITY": "YES",
    "SWIFT_UPCOMING_FEATURE_NONFROZEN_ENUM_EXHAUSTIVITY": "YES",
    "SWIFT_UPCOMING_FEATURE_REGION_BASED_ISOLATION": "YES",
    "SWIFT_UPCOMING_FEATURE_EXISTENTIAL_ANY": "YES",
    "SWIFT_UPCOMING_FEATURE_NONISOLATED_NONSENDING_BY_DEFAULT": "YES",
])

let packageSettings = PackageSettings(
    productTypes: [
        "SwiftIoC": .framework,
        "Relux": .framework,
        "ReluxRouter": .framework,
        "swiftui-relux": .framework,
        "SwiftUIRelux": .framework,
    ],
    targetSettings: [
        "SharedConfig": swiftPackageTargetSettings,
    ]
)
#endif
