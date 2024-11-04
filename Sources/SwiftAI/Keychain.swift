import Foundation
import Security

@propertyWrapper
public struct Keychain {
    public init(key: String,
                service: String = Bundle.main.bundleIdentifier!) {
        self.key = key
        self.service = service
    }
    
    public var wrappedValue: String? {
        get {
            KeychainAccess.load(forKey: key, service: service)
        }
        set {
            if let newValue {
                KeychainAccess.save(newValue, forKey: key, service: service)
            } else {
                KeychainAccess.delete(forKey: key, service: service)
            }
        }
    }
    
    private let key: String
    private let service: String
}

public class KeychainAccess {
    public static func save(_ item: String,
                            forKey key: String,
                            service: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrService as String: service,
            kSecValueData as String: item.data(using: .utf8)!
        ]
        
        SecItemDelete(query as CFDictionary) // Delete any existing items with the same key
        SecItemAdd(query as CFDictionary, nil)
    }
    
    public static func load(forKey key:
                            String,
                            service: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrService as String: service,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            if let existingItem = item as? Data {
                return String(data: existingItem, encoding: .utf8)
            }
        }
        return nil
    }
    
    public static func delete(forKey key: String,
                              service: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrService as String: service
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
