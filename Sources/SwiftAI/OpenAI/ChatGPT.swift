public extension ChatAI {
    static func gpt_4o(key: AuthenticationKey) -> ChatAI {
        .init(chatCompletionType: OpenAI.GPT_4o.self, key: key)
    }
}

public extension OpenAI {
    enum GPT_4o: ChatCompletionInterface {
        public static func complete(chat: [SwiftAI.Message],
                                    key: AuthenticationKey) async throws -> SwiftAI.Message {
            try await ChatCompletions.complete(chat: chat,
                                               usingModel: "gpt-4o",
                                               key: key)
        }
    }
}

extension OpenAI.ChatCompletions {
    static func complete(chat: [SwiftAI.Message],
                         usingModel model: String,
                         key: AuthenticationKey) async throws -> SwiftAI.Message {
        // prepare OpenAI messages to be sent
        let openAIMessages = chat.map {
            let openAIRole: OpenAI.Message.Role = switch $0.role {
            case .assistant: .assistant
            case .user: .user
            case .system: .system
            }
            
            return OpenAI.Message($0.content, role: openAIRole)
        }

        // send and get response
        let response = try await post(.init(openAIMessages, model: model),
                                      key: key)
        
        // get OpenAI response message
        guard let responseMessage = response.choices.first?.message else {
            throw ChatCompletionError.responseLacksData
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
