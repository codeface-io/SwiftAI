public extension OpenAI {
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    struct ChatGPT: ChatAI {
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

extension OpenAI.ChatCompletions {
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    static func complete(chat: [SwiftAI.Message],
                         systemPrompt: String?,
                         using model: OpenAI.Model,
                         key: OpenAI.AuthenticationKey) async throws -> SwiftAI.Message {
        // prepare OpenAI messages to be sent
        var openAIMessages = chat.map {
            let openAIRole: OpenAI.Message.Role = switch $0.role {
            case .assistant: .assistant
            case .user: .user
            case .system: .system
            }
            
            return OpenAI.Message($0.content, role: openAIRole)
        }
        
        if let systemPrompt {
            openAIMessages.insert(.init(systemPrompt, role: .system), at: 0)
        }

        // send and get response
        let response = try await post(.init(openAIMessages, model: model),
                                      key: key)
        
        // get OpenAI response message
        guard let responseMessage = response.choices.first?.message else {
            throw SwiftAIError.responseLacksData
        }
        
        // turn OpenAI response message into regular message
        let regularRole: SwiftAI.Message.Role = switch responseMessage.role {
        case .system: .system
        case .user: .user
        case .assistant: .assistant
        case .tool, .function: .system
        }
        
        return .init(responseMessage.content, role: regularRole)
    }
}
