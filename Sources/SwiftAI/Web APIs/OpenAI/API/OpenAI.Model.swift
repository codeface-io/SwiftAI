public extension OpenAI {
    struct Model: Sendable {
        public static let gpt_4o = Model(value: "gpt-4o")
        
        public let value: String
    }
}
