extension Anthropic {
    @frozen public struct Response: Codable, Sendable {
        public init(
            id: String,
            type: String,
            role: String,
            content: [ContentBlock],
            model: String,
            usage: Usage,
            stop_reason: String? = nil,
            stop_sequence: String? = nil
        ) {
            self.id = id
            self.type = type
            self.role = role
            self.content = content
            self.model = model
            self.usage = usage
            self.stop_reason = stop_reason
            self.stop_sequence = stop_sequence
        }
        
        public var id: String
        public var type: String
        public var role: String
        public var content: [ContentBlock]
        public var model: String
        public var usage: Usage
        public var stop_reason: String?
        public var stop_sequence: String?
        
        @frozen public struct ContentBlock: Codable, Sendable {
            public var type: String
            public var text: String?
            
            public init(
                type: String,
                text: String? = nil
            ) {
                self.type = type
                self.text = text
            }
        }

        @frozen public struct Usage: Codable, Sendable {
            public var input_tokens: Int
            public var output_tokens: Int
            
            public init(
                input_tokens: Int,
                output_tokens: Int
            ) {
                self.input_tokens = input_tokens
                self.output_tokens = output_tokens
            }
        }
    }
}
