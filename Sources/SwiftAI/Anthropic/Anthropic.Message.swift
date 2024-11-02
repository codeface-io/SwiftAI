extension Anthropic {
    public struct Message: Codable, Sendable {
        public init(_ content: String, role: String = "user") {
            self.content = content
            self.role = role
        }
        
        let content: String
        let role: String
    }
}
