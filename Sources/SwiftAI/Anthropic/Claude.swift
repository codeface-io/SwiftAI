public extension Anthropic {
    @available(macOS 10.15, iOS 13.0, *)
    struct Claude: ChatAI {
        public init(_ model: Model, key: AuthenticationKey) {
            self.model = model
            self.key = key
        }
        
        public func complete(chat: [SwiftAI.Message]) async throws -> SwiftAI.Message {
            try await Messages.complete(chat: chat,
                                        using: model,
                                        key: key)
        }
        
        public let model: Model
        let key: AuthenticationKey
    }
}

public extension Anthropic.Messages {
    @available(macOS 10.15, iOS 13.0, *)
    static func complete(chat: [SwiftAI.Message],
                         using model: Anthropic.Model,
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
            throw SwiftAIError.responseLacksData
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
