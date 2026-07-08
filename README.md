# ReluxRouter Sample

This iOS sample demonstrates `Relux.Navigation.ProjectingRouter` as an app-level
`NavigationPath` harness with module-local route resolution:

- The app owns and registers one `AppRouter` in Relux/IoC.
- App startup follows the `ios-app-manager` IoC + Relux scaffold: `App.init`
  configures `Registry`, and `Relux.Resolver` resolves/injects the runtime.
- The root `NavigationStack` binds to `AppRouter.path`.
- `CatalogModule` and `ProfileModule` own only their local `Page` enums.
- Each module has a `Container<Content>` scope that attaches its own
  `navigationDestination(for: Module.Page.self)` around content inside the
  outer stack hierarchy.
- Module pages enter the shared path both through `Relux.NavigationLink` actions
  and native SwiftUI `NavigationLink(value:)`.
- The visible projection is computed from the live `NavigationPath`, so it sees
  app pages, Relux-driven module pages, and native module pages.

The important pattern is that route handling is resolved against the concrete
module page type. The app-level stack does not register every module page type
up front, and modules do not share one common page enum or protocol.

## Development Tools

- ios-app-manager: maintains the Tuist scaffold.
  - Setup: `ios-app-manager ioc setup && ios-app-manager relux setup`
  - Build: `make build`
  - Test: `xcodebuild test -workspace ReluxRouterSample.xcworkspace -scheme ReluxRouterSample -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.5' -derivedDataPath DerivedData -resultBundlePath ../.temp/sample-ui-test-02.xcresult`
  - Artifacts: `DerivedData/`, generated `*.xcworkspace`, generated `*.xcodeproj`
- Tuist: installs package dependencies and generates the Xcode workspace.
  - Install dependencies: `tuist install`
  - Generate workspace: `tuist generate --no-open`
- Xcode/XCUITest: runs the sample UI tests.
  - Screenshots are stored inside the `.xcresult` bundle.
  - Extract screenshots: `swift run --package-path ~/src/swift-ui-testing-tools extract-screenshots ../.temp/sample-ui-test-02.xcresult ../.temp/sample-ui-test-screenshots-02`
