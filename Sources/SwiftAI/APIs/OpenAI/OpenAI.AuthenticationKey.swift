public extension OpenAI {
    struct AuthenticationKey: Sendable {
        public init(_ value: String) { self.value = value }
        let value: String
    }
}
