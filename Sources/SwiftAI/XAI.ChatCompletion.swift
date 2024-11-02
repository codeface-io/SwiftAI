import FoundationToolz

extension XAI {
    enum ChatCompletion {
        /// Create a language model response for a given chat conversation. This endpoint is compatible with the OpenAI API.
        struct Request: Encodable {
            init(messages: [Message],
                 model: String,
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
                 user: String? = nil) {
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
            let messages: [Message]
            
            /// Model name for the model to use.
            let model: String
            
            /// Positive values penalize new tokens based on their existing frequency.
            let frequency_penalty: Double?
            
            /// Maps tokens to bias values from -100 to 100.
            let logit_bias: [String: Int]?
            
            /// Whether to return log probabilities of the output tokens.
            let logprobs: Bool?
            
            /// The maximum number of tokens that can be generated.
            let max_tokens: Int?
            
            /// How many chat completion choices to generate for each input message.
            let n: Int?
            
            /// Positive values penalize new tokens based on presence.
            let presence_penalty: Double?
            
            /// Response format options
            //       let response_format: Any?
            
            /// For deterministic sampling attempts.
            let seed: Int?
            
            /// Up to 4 sequences where the API will stop generating further tokens.
            let stop: [String]?
            
            /// If set, partial message deltas will be sent.
            let stream: Bool?
            
            /// Stream options
            //       let stream_options: Any?
            
            /// Sampling temperature between 0 and 2.
            let temperature: Double?
            
            /// Tool choice options
            //       let tool_choice: Any?
            
            /// A list of tools (functions) the model may call.
            //       let tools: [Any]?
            
            /// Number of most likely tokens to return at each token position (0-20).
            let top_logprobs: Int?
            
            /// For nucleus sampling, probability mass to consider.
            let top_p: Double?
            
            /// Unique identifier representing the end-user.
            let user: String?
            
            struct Message: Encodable {
                let role: String
                let content: String
            }
        }
    }
}
