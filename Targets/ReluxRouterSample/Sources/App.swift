@_exported import Relux
import SwiftUI
import SwiftIoC

@main
struct ReluxRouterSample: App {
    init() {
        Registry.configure()
    }

    var body: some Scene {
        WindowGroup {
            Bootstrap()
        }
    }
}

extension ReluxRouterSample {
    @MainActor
    struct Bootstrap: View {
        @State private var relux: Relux?

        var body: some View {
            Group {
                if let relux {
                    Content(relux: relux)
                        .environmentObject(relux.store.getState(AppRouter.self))
                } else {
                    Splash()
                        .task {
                            relux = await Registry.resolveAsync(Relux.self)
                        }
                }
            }
        }
    }
}
