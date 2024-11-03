import FoundationToolz
import SwiftyToolz

extension XAI {
    public enum ChatCompletions {
        public static func post(
            _ request: Request,
            authenticationKey: AuthenticationKey
        ) async throws(HTTP.RequestError) -> Response {
            try await HTTP.sendRequest(
                to: baseURL + "v1/chat/completions",
                using: .POST,
                content: request,
                authorizationValue: "Bearer " + authenticationKey.value
            )
        }
        
        /// Create a language model response for a given chat conversation. This endpoint is compatible with the OpenAI API.
        public struct Request: Encodable, Sendable {
            public init(
                _ messages: [Message],
                model: String = "grok-beta",
                frequency_penalty: Double? = nil,
                logit_bias: [String : Int]? = nil,
                logprobs: Bool? = nil,
                max_tokens: Int? = nil,
                n: Int? = nil,
                presence_penalty: Double? = nil,
                seed: Int? = nil,
                stop: [String]? = nil,
                stream: Bool? = nil,
                temperature: Double? = nil,
                top_logprobs: Int? = nil,
                top_p: Double? = nil,
                user: String? = nil
            ) {
                self.messages = messages
                self.model = model
                self.frequency_penalty = frequency_penalty
                self.logit_bias = logit_bias
                self.logprobs = logprobs
                self.max_tokens = max_tokens
                self.n = n
                self.presence_penalty = presence_penalty
                self.seed = seed
                self.stop = stop
                self.stream = stream
                self.temperature = temperature
                self.top_logprobs = top_logprobs
                self.top_p = top_p
                self.user = user
            }
            
            /// A list of messages that make up the chat conversation.
            public let messages: [Message]
            
            /// Model name for the model to use.
            public let model: String
            
            /// Positive values penalize new tokens based on their existing frequency.
            public let frequency_penalty: Double?
            
            /// Maps tokens to bias values from -100 to 100.
            public let logit_bias: [String: Int]?
            
            /// Whether to return log probabilities of the output tokens.
            public let logprobs: Bool?
            
            /// The maximum number of tokens that can be generated.
            public let max_tokens: Int?
            
            /// How many chat completion choices to generate for each input message.
            public let n: Int?
            
            /// Positive values penalize new tokens based on presence.
            public let presence_penalty: Double?
            
            /// Response format options
            //       public let response_format: Any?
            
            /// For deterministic sampling attempts.
            public let seed: Int?
            
            /// Up to 4 sequences where the API will stop generating further tokens.
            public let stop: [String]?
            
            /// If set, partial message deltas will be sent.
            public let stream: Bool?
            
            /// Stream options
            //       public let stream_options: Any?
            
            /// Sampling temperature between 0 and 2.
            public let temperature: Double?
            
            /// Tool choice options
            //       public let tool_choice: Any?
            
            /// A list of tools (functions) the model may call.
            //       public let tools: [Any]?
            
            /// Number of most likely tokens to return at each token position (0-20).
            public let top_logprobs: Int?
            
            /// For nucleus sampling, probability mass to consider.
            public let top_p: Double?
            
            /// Unique identifier representing the end-user.
            public let user: String?
        }
    }
}
