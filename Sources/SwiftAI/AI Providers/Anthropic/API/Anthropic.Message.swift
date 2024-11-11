extension Anthropic {
    public struct Message: Codable, Sendable {
        public init(_ content: String, role: Role = .user) {
            self.content = content
            self.role = role
        }
        
        let content: String
        let role: Role
    }
}
