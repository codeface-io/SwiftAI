extension XAI {
    public struct Message: Codable, Sendable {
        public init(_ content: String, role: Role = .user) {
            self.content = content
            self.refusal = nil
            self.role = role
        }
        
        // there should be either a content or a refusal. exactly one of both should be not null.
        public let content: String?
        public let refusal: String?
        
        public let role: Role
        
        public enum Role: String, Codable, Sendable {
            case user, assistant, system
        }
    }
}
