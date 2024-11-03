public extension ChatAI {
    static func grokBeta(key: AuthenticationKey) -> ChatAI {
        .init(chatCompletionType: XAI.GrokBeta.self, key: key)
    }
}

public extension XAI {
    enum GrokBeta: ChatCompletionInterface {
        public static func complete(chat: [SwiftAI.Message],
                                    key: AuthenticationKey) async throws -> SwiftAI.Message {
            try await ChatCompletions.complete(chat: chat,
                                               usingModel: "grok-beta",
                                               key: key)
        }
    }
}

public extension XAI.ChatCompletions {
    static func complete(chat: [SwiftAI.Message],
                         usingModel model: String,
                         key: AuthenticationKey) async throws -> SwiftAI.Message {
        // prepare xAI messages to be sent
        let xAIMessages = chat.map { XAI.Message($0) }
        
        // send and get response
        let response = try await post(.init(xAIMessages, model: model),
                                      key: key)
        
        // get xAI response message
        guard let xAIResponseMessage = response.choices.first?.message else {
            throw ChatCompletionError.responseLacksData
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
