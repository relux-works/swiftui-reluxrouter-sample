import Foundation

extension Bundle {
    static func readInfoPlistValue<T>(by key: String, from bundle: Bundle) -> T {
        guard let infoDictionary = bundle.infoDictionary,
              let value = infoDictionary[key] as? T else {
            fatalError("Could not read key from \(bundle.description) Info.plist")
        }
        return value
    }

    func readInfoPlistValue<T>(by key: String) -> T {
        Self.readInfoPlistValue(by: key, from: self)
    }
}
