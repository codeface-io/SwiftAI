public extension Anthropic {
    struct Model: Sendable {
        public static let claude_3_5_Sonnet = Model(value: "claude-3-5-sonnet-latest")
        
        public let value: String
    }
}
