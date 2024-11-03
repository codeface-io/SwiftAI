public enum Grok {
    public enum Beta: ChatCompletionInterface {
        public static func complete(chat messages: [Message],
                                    authenticationKey: AuthenticationKey) async throws -> Message {
            try await Grok.complete(chat: messages,
                                    usingModel: "grok-beta",
                                    authenticationKey: authenticationKey)
        }
    }
    
    static func complete(chat messages: [Message],
                         usingModel model: String,
                         authenticationKey: AuthenticationKey) async throws -> Message {
        // prepare xAI messages to be sent
        let xAIMessages = messages.map { XAI.Message($0) }
        
        // send and get response
        let response = try await XAI.ChatCompletions.post(.init(xAIMessages, model: model),
                                                          authenticationKey: authenticationKey)
        
        // get xAI response message
        guard let xAIResponseMessage = response.choices.first?.message else {
            throw ChatCompletionError.responseContainsNoChoice
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
