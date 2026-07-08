@_exported import Relux
import ReluxRouter
import SwiftIoC

extension ReluxRouterSample {
    @MainActor
    enum Registry {
        static let ioc = IoC()

        static func configure() {

            // MARK: - Infrastructure (scaffolding anchor: infra)
            ioc.register(AppRouter.self, lifecycle: .container, resolver: Self.buildAppRouter)
            ioc.register(NavigationModule.self, lifecycle: .container, resolver: Self.buildNavigationModule)
            ioc.register(Relux.self, lifecycle: .container, resolver: Self.buildRelux)
            ioc.register(Relux.Store.self, lifecycle: .container, resolver: Self.buildReluxStore)
            ioc.register(Relux.RootSaga.self, lifecycle: .container, resolver: Self.buildReluxRootSaga)
            ioc.register((any Relux.Logger).self, lifecycle: .container, resolver: Self.buildReluxLogger)

            // MARK: - Foundation (scaffolding anchor: foundation)

            // MARK: - Features (scaffolding anchor: features)

            // MARK: - Network (scaffolding anchor: network)

            // MARK: - Utils (scaffolding anchor: utils)
        }

        static func resolve<T>(_ type: T.Type) -> T {
            ioc.get(by: type)!
        }

        static func resolveAsync<T>(_ type: T.Type) async -> T {
            await ioc.getAsync(by: type)!
        }
    }
}

// MARK: - Infrastructure Builders (scaffolding anchor: infra-builders)
extension ReluxRouterSample.Registry {
    private static func buildRelux() async -> Relux {
        await Relux.init(
            logger: resolve((any Relux.Logger).self),
            appStore: resolve(Relux.Store.self),
            rootSaga: resolve(Relux.RootSaga.self)
        )
        .register { @MainActor in
            resolve(ReluxRouterSample.NavigationModule.self)
        }
    }

    private static func buildReluxStore() -> Relux.Store {
        Relux.Store()
    }

    private static func buildReluxRootSaga() -> Relux.RootSaga {
        Relux.RootSaga()
    }

    private static func buildReluxLogger() -> any Relux.Logger {
        ReluxRouterSample.ReluxLogger()
    }

    private static func buildAppRouter() -> ReluxRouterSample.AppRouter {
        ReluxRouterSample.AppRouter()
    }

    private static func buildNavigationModule() -> ReluxRouterSample.NavigationModule {
        ReluxRouterSample.NavigationModule(router: resolve(ReluxRouterSample.AppRouter.self))
    }
}

// MARK: - Foundation Builders (scaffolding anchor: foundation-builders)
extension ReluxRouterSample.Registry {}

// MARK: - Feature Builders (scaffolding anchor: feature-builders)
extension ReluxRouterSample.Registry {}

// MARK: - Network Builders (scaffolding anchor: network-builders)
extension ReluxRouterSample.Registry {}

// MARK: - Utils Builders (scaffolding anchor: utils-builders)
extension ReluxRouterSample.Registry {}
