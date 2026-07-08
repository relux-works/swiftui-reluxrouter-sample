import Foundation

import SharedConfig

extension Configuration {
    enum ApplicationConfiguration {
        static let current: ReluxRouterSampleApplicationConfiguration = {
            do {
                return try ReluxRouterSampleApplicationConfiguration.read(from: .main)
            } catch {
                fatalError("Could not read ApplicationConfiguration from Info.plist: \(error.localizedDescription)")
            }
        }()
    }
}
