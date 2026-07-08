import ReluxRouter
import SwiftUI

extension ReluxRouterSample {
    enum SampleA11y {
        static let rootScreen = "sample.root.screen"
        static let appAboutScreen = "sample.app.about.screen"
        static let catalogScreen = "sample.catalog.screen"
        static let catalogSpecsScreen = "sample.catalog.specs.screen"
        static let profileScreen = "sample.profile.screen"
        static let openAppAboutRelux = "sample.action.open-app-about-relux"
        static let openCatalogRelux = "sample.action.open-catalog-relux"
        static let openCatalogNative = "sample.action.open-catalog-native"
        static let openProfileReluxFromRoot = "sample.action.open-profile-relux-from-root"
        static let openProfileNativeFromCatalog = "sample.action.open-profile-native-from-catalog"
        static let removeLast = "sample.action.remove-last"
        static let projectionCount = "sample.projection.count"
        static let projectionEmpty = "sample.projection.empty"

        static func projectionRow(_ index: Int) -> String {
            "sample.projection.row.\(index)"
        }
    }

    enum AppPage: Hashable, Sendable, Relux.Navigation.PathComponent {
        case about
    }

    typealias AppRouter = Relux.Navigation.ProjectingRouter<AppPage>

    struct NavigationModule: Relux.Module {
        let router: AppRouter
        let sagas: [any Relux.Saga] = []

        var states: [any Relux.AnyState] {
            [router]
        }
    }

    @MainActor
    struct Content: View {
        let relux: Relux
        @EnvironmentObject private var router: AppRouter

        var body: some View {
            NavigationStack(path: $router.path) {
                CatalogModule.Container {
                    ProfileModule.Container {
                        RootContainer()
                            .navigationDestination(for: AppPage.self, destination: appDestination)
                    }
                }
            }
        }

        @ViewBuilder
        private func appDestination(for page: AppPage) -> some View {
            switch page {
            case .about:
                AppAboutPage()
            }
        }
    }

    @MainActor
    struct RootContainer: View {
        var body: some View {
            List {
                Section("App navigation") {
                    Relux.NavigationLink(page: AppPage.about) {
                        Label("Open App About via Relux", systemImage: "app.connected.to.app.below.fill")
                    }
                    .accessibilityIdentifier(SampleA11y.openAppAboutRelux)
                }

                CatalogModule.LinksSection()
                ProfileModule.LinksSection()
                ProjectionSection()
            }
            .accessibilityIdentifier(SampleA11y.rootScreen)
            .navigationTitle("ReluxRouter")
        }
    }

    @MainActor
    struct AppAboutPage: View {
        var body: some View {
            List {
                Section("App") {
                    Text("This page is resolved by the app-level destination handler.")
                }

                ProjectionSection()
            }
            .accessibilityIdentifier(SampleA11y.appAboutScreen)
            .navigationTitle("App About")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    RemoveLastButton()
                }
            }
        }
    }

    enum CatalogModule {
        enum Page: Hashable, Sendable {
            case detail(id: String)
            case specs(id: String, openedBy: String)
        }

        typealias NavigationLink<Label: View> = Relux.NavigationLink<Page, Label>

        @MainActor
        struct Container<Content: View>: View {
            @ViewBuilder let content: () -> Content

            var body: some View {
                content()
                    .navigationDestination(for: Page.self, destination: Self.handleDestination)
            }

            @ViewBuilder
            static func handleDestination(for page: Page) -> some View {
                switch page {
                case let .detail(id):
                    DetailPage(id: id)
                case let .specs(id, openedBy):
                    SpecsPage(id: id, openedBy: openedBy)
                }
            }
        }

        @MainActor
        struct LinksSection: View {
            var body: some View {
                Section("Catalog module") {
                    NavigationLink(page: .detail(id: "item-42")) {
                        Label("Open Catalog Detail via Relux", systemImage: "shippingbox")
                    }
                    .accessibilityIdentifier(SampleA11y.openCatalogRelux)

                    SwiftUI.NavigationLink(value: Page.specs(id: "native-specs", openedBy: "root")) {
                        Label("Open Catalog Specs via native NavigationLink", systemImage: "doc.text.magnifyingglass")
                    }
                    .accessibilityIdentifier(SampleA11y.openCatalogNative)
                }
            }
        }

        @MainActor
        struct DetailPage: View {
            let id: String

            var body: some View {
                ProfileModule.Container {
                    List {
                        Section("Catalog detail") {
                            LabeledContent("Item", value: id)
                            NavigationLink(page: .specs(id: "relux-specs", openedBy: id)) {
                                Label("Open Specs via Relux", systemImage: "doc.text")
                            }
                        }

                        ProfileModule.NativeProfileLink(
                            id: "native-7",
                            source: id
                        )

                        ProjectionSection()
                    }
                    .accessibilityIdentifier(SampleA11y.catalogScreen)
                    .navigationTitle("Catalog \(id)")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            RemoveLastButton()
                        }
                    }
                }
            }
        }

        @MainActor
        struct SpecsPage: View {
            let id: String
            let openedBy: String

            var body: some View {
                List {
                    Section("Catalog specs") {
                        LabeledContent("Specs", value: id)
                        LabeledContent("Opened by", value: openedBy)
                    }

                    ProjectionSection()
                }
                .accessibilityIdentifier(SampleA11y.catalogSpecsScreen)
                .navigationTitle("Catalog Specs")
            }
        }
    }

    enum ProfileModule {
        enum Page: Hashable, Sendable {
            case details(id: String, source: String)
        }

        typealias NavigationLink<Label: View> = Relux.NavigationLink<Page, Label>

        @MainActor
        struct Container<Content: View>: View {
            @ViewBuilder let content: () -> Content

            var body: some View {
                content()
                    .navigationDestination(for: Page.self, destination: Self.handleDestination)
            }

            @ViewBuilder
            static func handleDestination(for page: Page) -> some View {
                switch page {
                case let .details(id, source):
                    DetailsPage(id: id, source: source)
                }
            }
        }

        @MainActor
        struct LinksSection: View {
            var body: some View {
                Section("Profile module") {
                    NavigationLink(page: .details(id: "relux-root", source: "root-profile-module")) {
                        Label("Open Profile via Relux", systemImage: "person.crop.circle")
                    }
                    .accessibilityIdentifier(SampleA11y.openProfileReluxFromRoot)
                }
            }
        }

        @MainActor
        struct NativeProfileLink: View {
            let id: String
            let source: String

            var body: some View {
                Section("Profile module embedded in Catalog") {
                    SwiftUI.NavigationLink(value: Page.details(id: id, source: source)) {
                        Label("Open Profile Native", systemImage: "person.crop.circle.badge.arrow.forward")
                    }
                    .accessibilityIdentifier(SampleA11y.openProfileNativeFromCatalog)
                }
            }
        }

        @MainActor
        struct DetailsPage: View {
            let id: String
            let source: String

            var body: some View {
                List {
                    Section("Profile") {
                        LabeledContent("Profile", value: id)
                        LabeledContent("Source", value: source)
                    }

                    ProjectionSection()
                }
                .accessibilityIdentifier(SampleA11y.profileScreen)
                .navigationTitle("Profile")
            }
        }
    }

    @MainActor
    struct ProjectionSection: View {
        @EnvironmentObject private var router: AppRouter

        var body: some View {
            Section("Navigation Path") {
                LabeledContent("Count", value: "\(router.path.count)")
                    .accessibilityIdentifier(SampleA11y.projectionCount)

                if router.projectedPathStrings.isEmpty {
                    Text("Empty")
                        .foregroundStyle(.secondary)
                        .accessibilityIdentifier(SampleA11y.projectionEmpty)
                } else {
                    ForEach(Array(router.projectedPathStrings.enumerated()), id: \.offset) { index, projection in
                        Text(projection)
                            .font(.system(.footnote, design: .monospaced))
                            .lineLimit(3)
                            .textSelection(.enabled)
                            .accessibilityIdentifier(SampleA11y.projectionRow(index))
                    }
                }
            }
        }
    }

    @MainActor
    struct RemoveLastButton: View {
        @EnvironmentObject private var router: AppRouter

        var body: some View {
            Button {
                performAsync {
                    AppRouter.Action.removeLast()
                }
            } label: {
                Image(systemName: "arrow.uturn.backward")
            }
            .accessibilityLabel("Remove Last")
            .accessibilityIdentifier(SampleA11y.removeLast)
            .disabled(router.path.isEmpty)
        }
    }
}
