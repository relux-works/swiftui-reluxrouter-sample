import ProjectDescription
import ProjectDescriptionHelpers

let appName = "ReluxRouterSample"
let bundleID = "com.reluxworks.reluxroutersample"
let developmentTeam = "262RZ595FP"
let marketingVersion = "1.0.0"
let currentProjectVersion = "1"
let minTarget = "17.0"
let configurations: [Configuration] = [
    .debug(name: "Debug"),
    .release(name: "Release"),
]

let project = Project(
    name: appName,
    organizationName: "Relux Works",
    settings: .settings(
        configurations: configurations
    ),
    targets: [
        .target(
            name: appName,
            destinations: .iOS,
            product: .app,
            bundleId: bundleID,
            deploymentTargets: .iOS(minTarget),
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleDisplayName": .string(appName),
                    "CFBundleShortVersionString": .string(marketingVersion),
                    "CFBundleVersion": .string(currentProjectVersion),
                    "CFBundleURLTypes": .array([
                        .dictionary([
                            "CFBundleURLName": .string(bundleID),
                            "CFBundleTypeRole": .string("Editor"),
                            "CFBundleURLSchemes": .array([
                                .string("reluxroutersample")
                            ])
                        ])
                    ]),
                    "ApplicationConfiguration": .dictionary([
                        "appName": .string("ReluxRouterSample"),
                        "applicationBundleIdentifier": .string("com.reluxworks.reluxroutersample"),
                        "developmentTeamID": .string("262RZ595FP"),
                        "urlScheme": .string("reluxroutersample"),
                    ]),
                    "UILaunchScreen": .dictionary([:]),
                ]
            ),
            sources: ["Targets/ReluxRouterSample/Sources/**"],
            resources: ["Targets/ReluxRouterSample/Resources/**"],
            entitlements: EntitlementsFactory.make(hostBundleId: bundleID, destinations: .iOS, capabilities: AppCapabilities.app),
            dependencies: [
                .external(name: "SharedConfig"),
                .external(name: "SwiftIoC"),
                .external(name: "Relux"),
                .external(name: "ReluxRouter"),
                .external(name: "SwiftUIRelux"),
            ],
            settings: .settings(
                base: [
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
                    "IPHONEOS_DEPLOYMENT_TARGET": .string(minTarget),
                    "DEVELOPMENT_TEAM": .string(developmentTeam),
                    "MARKETING_VERSION": .string(marketingVersion),
                    "CURRENT_PROJECT_VERSION": .string(currentProjectVersion),
                    "CODE_SIGN_ALLOW_ENTITLEMENTS_MODIFICATION": "YES",
                ]
            )
        ),
        .target(
            name: "ReluxRouterSampleUITests",
            destinations: .iOS,
            product: .uiTests,
            bundleId: "\(bundleID).ui-tests",
            deploymentTargets: .iOS(minTarget),
            infoPlist: .default,
            sources: ["Targets/ReluxRouterSampleUITests/Sources/**"],
            dependencies: [
                .target(name: appName),
            ],
            settings: .settings(
                base: [
                    "SWIFT_APPROACHABLE_CONCURRENCY": "NO",
                    "SWIFT_DEFAULT_ACTOR_ISOLATION": "nonisolated",
                    "SWIFT_STRICT_CONCURRENCY": "complete",
                    "SWIFT_STRICT_CONCURRENCY_DEFAULT": "complete",
                    "SWIFT_STRICT_MEMORY_SAFETY": "YES",
                    "SWIFT_UPCOMING_FEATURE_CONCISE_MAGIC_FILE": "YES",
                    "SWIFT_UPCOMING_FEATURE_DISABLE_OUTWARD_ACTOR_ISOLATION": "YES",
                    "SWIFT_UPCOMING_FEATURE_EXISTENTIAL_ANY": "YES",
                    "SWIFT_UPCOMING_FEATURE_GLOBAL_ACTOR_ISOLATED_TYPES_USABILITY": "YES",
                    "SWIFT_UPCOMING_FEATURE_GLOBAL_CONCURRENCY": "YES",
                    "SWIFT_UPCOMING_FEATURE_INFER_ISOLATED_CONFORMANCES": "YES",
                    "SWIFT_UPCOMING_FEATURE_INFER_SENDABLE_FROM_CAPTURES": "YES",
                    "SWIFT_UPCOMING_FEATURE_MEMBER_IMPORT_VISIBILITY": "YES",
                    "SWIFT_UPCOMING_FEATURE_NONFROZEN_ENUM_EXHAUSTIVITY": "YES",
                    "SWIFT_UPCOMING_FEATURE_NONISOLATED_NONSENDING_BY_DEFAULT": "YES",
                    "SWIFT_UPCOMING_FEATURE_REGION_BASED_ISOLATION": "YES",
                    "SWIFT_VERSION": "6.0",
                    "IPHONEOS_DEPLOYMENT_TARGET": .string(minTarget),
                    "DEVELOPMENT_TEAM": .string(developmentTeam),
                ]
            )
        ),
    ]
)
