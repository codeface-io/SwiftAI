import Foundation

public struct Message: Equatable, Identifiable, Sendable, Codable {
    public let id = UUID()
    public let content: String
    public let role: Role
    
    public init(_ content: String, role: Role = .user) {
        self.content = content
        self.role = role
    }
    
    private enum CodingKeys: String, CodingKey {
        case content, role
    }
    
    public enum Role: Sendable, Codable { case user, assistant, system }
}
