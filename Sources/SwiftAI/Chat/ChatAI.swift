public struct ChatAI: Sendable {
    public init(chatCompletionType: ChatCompletionInterface.Type,
                key: AuthenticationKey) {
        self.chatCompletionType = chatCompletionType
        self.key = key
    }
    
    public func complete(chat: [Message]) async throws -> Message {
        try await chatCompletionType.complete(chat: chat, key: key)
    }
    
    let chatCompletionType: ChatCompletionInterface.Type
    let key: AuthenticationKey
}
