extension XAI {
    public struct Response: Decodable, Sendable {
        public let id: String
        public let object: String
        public let created: Int
        public let model: String
        public let choices: [Choice]
        public let usage: Usage
        public let system_fingerprint: String
        
        public struct Choice: Decodable, Sendable {
            public let index: Int
            public let message: Message? // for chat comnpletion
            public let text: String? // for simple completion
            public let finish_reason: String
            
            public struct Message: Decodable, Sendable {
                public let role: String
                public let content: String
                public let refusal: String?
            }
        }
        
        public struct Usage: Decodable, Sendable {
            public let prompt_tokens: Int
            public let completion_tokens: Int
            public let total_tokens: Int
        }
    }
}
