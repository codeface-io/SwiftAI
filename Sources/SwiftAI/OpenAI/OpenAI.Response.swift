extension OpenAI {
    public struct Response: Codable, Sendable {
        public let id: String
        public let object: String
        public let created: Int
        public let model: String
        public let usage: Usage
        public let choices: [Choice]
        public let system_fingerprint: String?
        
        public struct Usage: Codable, Sendable {
            public let prompt_tokens: Int
            public let completion_tokens: Int
            public let total_tokens: Int
        }
        
        public struct Choice: Codable, Sendable {
            public let index: Int
            public let message: Message
            public let finish_reason: String
            public let logprobs: [String: Double]?
        }
    }
}
