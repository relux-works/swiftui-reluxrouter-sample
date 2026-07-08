import Foundation

public enum ReluxRouterSampleSharedConfigError: Error, LocalizedError, Equatable {
    case missingInfoPlistDictionary(key: String, bundleIdentifier: String?)
    case missingInfoPlistValue(key: String, dictionaryKey: String, bundleIdentifier: String?)

    public var errorDescription: String? {
        switch self {
        case let .missingInfoPlistDictionary(key, bundleIdentifier):
            "Missing Info.plist dictionary \(key) in bundle \(bundleIdentifier ?? "<unknown>")"
        case let .missingInfoPlistValue(key, dictionaryKey, bundleIdentifier):
            "Missing Info.plist value \(key).\(dictionaryKey) in bundle \(bundleIdentifier ?? "<unknown>")"
        }
    }
}

public extension Bundle {
    func reluxRouterSampleString(for key: String, dictionaryKey: String) throws -> String {
        guard let value = try reluxRouterSampleOptionalString(for: key, dictionaryKey: dictionaryKey) else {
            throw ReluxRouterSampleSharedConfigError.missingInfoPlistValue(
                key: key,
                dictionaryKey: dictionaryKey,
                bundleIdentifier: bundleIdentifier
            )
        }

        return value
    }

    func reluxRouterSampleOptionalString(for key: String, dictionaryKey: String) throws -> String? {
        let values = try reluxRouterSampleDictionary(for: key)
        guard let value = values[dictionaryKey] else {
            return nil
        }

        let trimmedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedValue.isEmpty ? nil : trimmedValue
    }

    func reluxRouterSampleDictionary(for key: String) throws -> [String: String] {
        if let value = object(forInfoDictionaryKey: key) as? [String: String] {
            return value
        }

        if let rawValue = object(forInfoDictionaryKey: key) as? [String: Any] {
            var value: [String: String] = [:]
            for (dictionaryKey, dictionaryValue) in rawValue {
                if let stringValue = dictionaryValue as? String {
                    value[dictionaryKey] = stringValue
                }
            }
            return value
        }

        throw ReluxRouterSampleSharedConfigError.missingInfoPlistDictionary(
            key: key,
            bundleIdentifier: bundleIdentifier
        )
    }
}
