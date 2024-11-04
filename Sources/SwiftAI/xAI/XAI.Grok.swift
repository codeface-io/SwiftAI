public extension XAI {
    struct Grok: ChatAI {
        public init(_ model: Model, key: AuthenticationKey) {
            self.model = model
            self.key = key
        }
        
        public func complete(chat: [SwiftAI.Message]) async throws -> SwiftAI.Message {
            try await ChatCompletions.complete(chat: chat,
                                               using: model,
                                               key: key)
        }
        
        public let model: Model
        let key: AuthenticationKey
    }
}

public extension XAI.ChatCompletions {
    static func complete(chat: [Message],
                         using model: XAI.Model,
                         key: AuthenticationKey) async throws -> Message {
        // prepare xAI messages to be sent
        let xAIMessages = chat.map { XAI.Message($0) }
        
        // send and get response
        let response = try await post(.init(xAIMessages, model: model),
                                      key: key)
        
        // get xAI response message
        guard let xAIResponseMessage = response.choices.first?.message else {
            throw SwiftAIError.responseLacksData
        }
        
        // turn xAI response message into regular message
        return xAIResponseMessage.message
    }
}

private extension XAI.Message {
    init(_ message: Message) {
        self = .init(
            message.content,
            role: {
                switch message.role {
                case .user: .user
                case .assistant: .assistant
                case .system: .system
                }
            }()
        )
    }
    
    var message: Message {
        .init(
            content ?? refusal ?? "",
            role: {
                switch role {
                case .assistant: .assistant
                case .user: .user
                case .system: .system
                }
            }()
        )
    }
}
