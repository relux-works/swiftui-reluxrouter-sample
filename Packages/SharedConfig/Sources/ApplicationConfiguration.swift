import Foundation

public enum ReluxRouterSampleApplicationConfigurationField: String, Sendable {
    case appName
    case applicationBundleIdentifier
    case developmentTeamID
    case urlScheme

    public var infoPlistKey: String {
        "ApplicationConfiguration"
    }

    public var dictionaryKey: String {
        rawValue
    }
}

public struct ReluxRouterSampleApplicationConfiguration: Equatable, Sendable {
    public let appName: String
    public let applicationBundleIdentifier: String
    public let developmentTeamID: String
    public let urlScheme: String?

    public init(
        appName: String,
        applicationBundleIdentifier: String,
        developmentTeamID: String,
        urlScheme: String?
    ) {
        self.appName = appName
        self.applicationBundleIdentifier = applicationBundleIdentifier
        self.developmentTeamID = developmentTeamID
        self.urlScheme = urlScheme
    }

    public static func read(from bundle: Bundle = .main) throws -> Self {
        try Self(
            appName: bundle.reluxRouterSampleString(for: Field.appName.infoPlistKey, dictionaryKey: Field.appName.dictionaryKey),
            applicationBundleIdentifier: bundle.reluxRouterSampleString(for: Field.applicationBundleIdentifier.infoPlistKey, dictionaryKey: Field.applicationBundleIdentifier.dictionaryKey),
            developmentTeamID: bundle.reluxRouterSampleString(for: Field.developmentTeamID.infoPlistKey, dictionaryKey: Field.developmentTeamID.dictionaryKey),
            urlScheme: bundle.reluxRouterSampleOptionalString(for: Field.urlScheme.infoPlistKey, dictionaryKey: Field.urlScheme.dictionaryKey)
        )
    }
}

private typealias Field = ReluxRouterSampleApplicationConfigurationField
