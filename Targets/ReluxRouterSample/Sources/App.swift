@_exported import Relux
import SwiftUI
import SwiftIoC
import SwiftUIRelux

@main
struct ReluxRouterSample: App {
    init() {
        Registry.configure()
    }

    var body: some Scene {
        WindowGroup {
            Relux.Resolver(
                splash: { ReluxRouterSample.Splash() },
                content: { _ in ReluxRouterSample.Content() },
                resolver: { await Registry.resolveAsync(Relux.self) }
            )
        }
    }
}
