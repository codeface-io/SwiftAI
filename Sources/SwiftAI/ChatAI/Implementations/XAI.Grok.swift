public extension XAI {
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    struct Grok: ChatAI {
        public init(_ model: Model, key: AuthenticationKey) {
            self.model = model
            self.key = key
        }
        
        public func complete(chat: [SwiftAI.Message],
                             systemPrompt: String?) async throws -> SwiftAI.Message {
            try await ChatCompletions.complete(chat: chat,
                                               systemPrompt: systemPrompt,
                                               using: model,
                                               key: key)
        }
        
        public let model: Model
        let key: AuthenticationKey
    }
}

public extension XAI.ChatCompletions {
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    static func complete(chat: [Message],
                         systemPrompt: String?,
                         using model: XAI.Model,
                         key: XAI.AuthenticationKey) async throws -> Message {
        // prepare xAI messages to be sent
        var xAIMessages = chat.map { XAI.Message($0) }
        
        if let systemPrompt {
            xAIMessages.insert(.init(systemPrompt, role: .system), at: 0)
        }
        
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
