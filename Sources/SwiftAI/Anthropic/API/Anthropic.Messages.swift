import FoundationToolz
import SwiftyToolz

extension Anthropic {
    public enum Messages {
        public static func post(
            _ request: Request,
            key: AuthenticationKey
        ) async throws(HTTP.RequestError) -> Response {
            try await HTTP.sendRequest(
                to: baseURL + "v1/messages",
                using: .POST,
                content: request,
                addingHeaders: [
                    "x-api-key": key.value,
                    "anthropic-version": "2023-06-01"
                ]
            )
        }
        
        public struct Request: Codable, Sendable {
            public var messages: [Message]
            public var model: String
            public var max_tokens: Int
            public var metadata: [String: String]?
            public var stop_sequences: [String]?
            public var stream: Bool?
            public var system: String?
            public var temperature: Double?
            public var tool_choice: ToolChoice?
            public var tools: [Tool]?
            public var top_k: Int?
            public var top_p: Double?
            
            public init(
                _ messages: [Message],
                model: String = "claude-3-5-sonnet-latest",
                max_tokens: Int = 1024,
                metadata: [String: String]? = nil,
                stop_sequences: [String]? = nil,
                stream: Bool? = nil,
                system: String? = nil,
                temperature: Double? = nil,
                tool_choice: ToolChoice? = nil,
                tools: [Tool]? = nil,
                top_k: Int? = nil,
                top_p: Double? = nil
            ) {
                self.messages = messages
                self.model = model
                self.max_tokens = max_tokens
                self.metadata = metadata
                self.stop_sequences = stop_sequences
                self.stream = stream
                self.system = system
                self.temperature = temperature
                self.tool_choice = tool_choice
                self.tools = tools
                self.top_k = top_k
                self.top_p = top_p
            }
            
            public struct ContentBlock: Codable, Sendable {
                public var type: String
                public var text: String?
                public var source: ImageSource?
                public var id: String?
                public var name: String?
//                public var input: [String: Any]?
                public var tool_use_id: String?
                
                public init(
                    _ type: String,
                    text: String? = nil,
                    source: ImageSource? = nil,
                    id: String? = nil,
                    name: String? = nil,
//                    input: [String: Any]? = nil,
                    tool_use_id: String? = nil
                ) {
                    self.type = type
                    self.text = text
                    self.source = source
                    self.id = id
                    self.name = name
//                    self.input = input
                    self.tool_use_id = tool_use_id
                }
            }

            public struct ImageSource: Codable, Sendable {
                public var type: String
                public var media_type: String
                public var data: String
                
                public init(type: String,
                            media_type: String,
                            data: String) {
                    self.type = type
                    self.media_type = media_type
                    self.data = data
                }
            }

            public struct Tool: Codable, Sendable {
                public var name: String
                public var description: String?
//                public var input_schema: [String: Any]
                
                public init(name: String,
//                            input_schema: [String: Any],
                            description: String? = nil) {
                    self.name = name
                    self.description = description
//                    self.input_schema = input_schema
                }
            }

            public struct ToolChoice: Codable, Sendable {
                public var type: String
                public var name: String?
                
                public init(type: String,
                            name: String? = nil) {
                    self.type = type
                    self.name = name
                }
            }
        }
    }
}
