extension OpenAI {
    public struct Message: Codable, Sendable {
        public init(_ content: String,
                    role: Role = .user,
                    name: String? = nil) {
            self.content = content
            self.role = role
            self.name = name
        }
        
        public let content: String
        
        public let role: Role
        
        public enum Role: String, Codable, Sendable {
            case system, user, assistant, tool, function
        }
        
        public let name: String?
    }
}
