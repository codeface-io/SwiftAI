public extension API.Key {
    var apiIdentifier: API.Identifier? {
        .init(rawValue: apiIdentifierValue)
    }
}

public extension API {
    public enum Identifier: String, CaseIterable, Identifiable {
        public var displayName: String {
            switch self {
            case .anthropic: "Anthropic"
            case .openAI: "OpenAI"
            case .xAI: "xAI"
            }
        }
        
        public var id: String { rawValue }
        
        case xAI
        case anthropic
        case openAI
    }
}
