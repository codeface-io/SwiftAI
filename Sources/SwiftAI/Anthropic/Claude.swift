public extension ChatAI {
    static func claude_3_5_Sonnet(key: AuthenticationKey) -> ChatAI {
        .init(chatCompletionType: Anthropic.Claude_3_5_Sonnet.self, key: key)
    }
}

public extension Anthropic {
    enum Claude_3_5_Sonnet: ChatCompletionInterface {
        public static func complete(chat: [SwiftAI.Message],
                                    key: AuthenticationKey) async throws -> SwiftAI.Message {
            try await Messages.complete(chat: chat,
                                        usingModel: "claude-3-5-sonnet-latest",
                                        key: key)
        }
    }
}

public extension Anthropic.Messages {
    static func complete(chat: [SwiftAI.Message],
                         usingModel model: String,
                         key: AuthenticationKey) async throws -> SwiftAI.Message {
        // prepare Anthropic messages to be sent
        let anthropicMessages = chat.map {
            let anthropicRole: Anthropic.Role = switch $0.role {
            case .user: .user
            case .assistant: .assistant
            case .system: .system
            }
            
            return Anthropic.Message($0.content, role: anthropicRole)
        }
        
        // send and get response
        let response = try await post(.init(anthropicMessages, model: model),
                                      key: key)
        
        // get Anthropic response content
        guard let anthropicResponseText = response.content.first?.text else {
            throw ChatCompletionError.responseLacksData
        }
        
        // turn Anthropic response into regular message
        let regularRole: SwiftAI.Message.Role = switch response.role {
        case .user: .user
        case .assistant: .assistant
        case .system: .system
        }
        
        return .init(anthropicResponseText, role: regularRole)
    }
}
