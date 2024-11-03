extension Anthropic {
    public struct Response: Codable, Sendable {
        public var id: String
        public var type: String
        public var role: Role
        public var content: [ContentBlock]
        public var model: String
        public var usage: Usage
        public var stop_reason: String?
        public var stop_sequence: String?
        
        public struct ContentBlock: Codable, Sendable {
            public var type: String
            public var text: String?
        }

        public struct Usage: Codable, Sendable {
            public var input_tokens: Int
            public var output_tokens: Int
        }
    }
}
