import FoundationToolz
import SwiftyToolz

extension OpenAI {
    public enum ChatCompletions {
        @available(macOS 10.15, iOS 13.0, *)
        public static func post(
            _ request: Request,
            key: AuthenticationKey
        ) async throws(HTTP.RequestError) -> Response {
            try await HTTP.sendRequest(
                to: baseURL + "v1/chat/completions",
                using: .POST,
                content: request,
                authorizationValue: "Bearer " + key.value
            )
        }
        
        public struct Request: Codable, Sendable {
            public init(
                _ messages: [Message],
                model: Model,
                store: Bool? = nil,
                metadata: [String: String]? = nil,
                frequency_penalty: Double? = nil,
                logit_bias: [String: Int]? = nil,
                logprobs: Bool? = nil,
                top_logprobs: Int? = nil,
                max_tokens: Int? = nil,
                max_completion_tokens: Int? = nil,
                n: Int? = nil,
                modalities: [String]? = nil,
                presence_penalty: Double? = nil,
                response_format: ResponseFormat? = nil,
                seed: Int? = nil,
                service_tier: String? = nil,
                stop: [String]? = nil,
                stream: Bool? = nil,
                temperature: Double? = nil,
                top_p: Double? = nil,
                tools: [Tool]? = nil,
                tool_choice: ToolChoice? = nil,
                parallel_tool_calls: Bool? = nil,
                user: String? = nil
            ) {
                self.messages = messages
                self.model = model.value
                self.store = store
                self.metadata = metadata
                self.frequency_penalty = frequency_penalty
                self.logit_bias = logit_bias
                self.logprobs = logprobs
                self.top_logprobs = top_logprobs
                self.max_tokens = max_tokens
                self.max_completion_tokens = max_completion_tokens
                self.n = n
                self.modalities = modalities
                self.presence_penalty = presence_penalty
                self.response_format = response_format
                self.seed = seed
                self.service_tier = service_tier
                self.stop = stop
                self.stream = stream
                self.temperature = temperature
                self.top_p = top_p
                self.tools = tools
                self.tool_choice = tool_choice
                self.parallel_tool_calls = parallel_tool_calls
                self.user = user
            }
            
            public let messages: [Message]
            public let model: String
            public let store: Bool?
            public let metadata: [String: String]?
            public let frequency_penalty: Double?
            public let logit_bias: [String: Int]?
            public let logprobs: Bool?
            public let top_logprobs: Int?
            public let max_tokens: Int?
            public let max_completion_tokens: Int?
            public let n: Int?
            public let modalities: [String]?
            public let presence_penalty: Double?
            public let response_format: ResponseFormat?
            public let seed: Int?
            public let service_tier: String?
            public let stop: [String]?
            public let stream: Bool?
            public let temperature: Double?
            public let top_p: Double?
            public let tools: [Tool]?
            public let tool_choice: ToolChoice?
            public let parallel_tool_calls: Bool?
            public let user: String?
            
            public struct ResponseFormat: Codable, Sendable {
                public init(type: String, json_schema: [String: Any]? = nil) {
                    self.type = type
                    // self.json_schema = json_schema
                }
                
                public let type: String
                // public let json_schema: [String: Any]?
            }
            
            public struct Tool: Codable, Sendable {
                public init(
                    type: String,
                    function: Function
                ) {
                    self.type = type
                    self.function = function
                }
                
                public let type: String
                public let function: Function
                
                public struct Function: Codable, Sendable {
                    public init(
                        name: String,
                        description: String? = nil,
                        parameters: [String: Any]? = nil
                    ) {
                        self.name = name
                        self.description = description
                        // self.parameters = parameters
                    }
                    
                    public let name: String
                    public let description: String?
                    // public let parameters: [String: Any]?
                }
            }
            
            public struct ToolChoice: Codable, Sendable {
                public init(
                    type: String,
                    function: Function? = nil
                ) {
                    self.type = type
                    self.function = function
                }
                
                public let type: String
                public let function: Function?
                
                public struct Function: Codable, Sendable {
                    public init(name: String) {
                        self.name = name
                    }
                    
                    public let name: String
                }
            }
        }
    }
}
