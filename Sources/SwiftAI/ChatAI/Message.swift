import Foundation

public struct Message: Equatable, Identifiable, Sendable, Codable {
    public let id: UUID
    public let content: String
    public let role: Role
    
    public init(_ content: String, role: Role = .user) {
        self.id = UUID()
        self.content = content
        self.role = role
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        content = try container.decode(String.self, forKey: .content)
        role = try container.decode(Role.self, forKey: .role)
    }
    
    private enum CodingKeys: CodingKey {
        case id, content, role
    }
    
    public enum Role: Sendable, Codable { case user, assistant, system }
}
