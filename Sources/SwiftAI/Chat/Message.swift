import Foundation

public struct Message: Equatable, Identifiable, Sendable {
    public init(_ content: String, role: Role = .user) {
        self.content = content
        self.role = role
    }
    
    public let id = UUID()
    public let content: String
    
    public let role: Role
    public enum Role: Sendable { case user, assistant, system }
}