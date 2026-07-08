import SharedConfig

extension Configuration {
    enum Keychain {
        private static let applicationConfiguration = ApplicationConfiguration.current

        static let serviceName = applicationConfiguration.applicationBundleIdentifier
        static let accessGroup = "\(applicationConfiguration.developmentTeamID).\(applicationConfiguration.applicationBundleIdentifier).shared"
    }
}
