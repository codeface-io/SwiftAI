import Foundation
import SwiftyToolz

public enum API {
    /// a flexible and future proof way to configure and store api keys. a client does not need to make use of the flexibility and can for instance just assume one key per API without name and description
    public struct Key: Codable, Identifiable {
        public init(_ value: String,
             apiIdentifierValue: String,
             name: String? = nil,
             description: String? = nil,
             id: UUID = UUID()) throws {
            if value.isEmpty { throw "Can not create an \(Self.self) with an empty value" }
            self.id = id
            self.value = value
            self.apiIdentifierValue = apiIdentifierValue
            self.name = name
            self.description = description
        }
        
        public let id: UUID
        public let value: String
        public let apiIdentifierValue: String
        public let name: String?
        public let description: String?
    }
}
