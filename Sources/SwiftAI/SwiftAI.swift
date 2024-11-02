import FoundationToolz
import Foundation

public enum Grok {
    public static func complete(prompt: String,
                                authenticationKey: AuthenticationKey) async throws(HTTP.RequestError) -> String {
        let response: Response = try await HTTP.sendRequest(
            to: "https://api.x.ai/v1/completions",
            using: .POST,
            content: CompletionRequest(model: "grok-beta", prompt: prompt),
            authorizationValue: "Bearer " + authenticationKey.value
        )
        
        return response.choices.first?.text ?? ""
    }
    
    struct Response: Decodable {
        let id: String
        let object: String
        let created: Int
        let model: String
        let choices: [Choice]
        let usage: Usage
        let system_fingerprint: String
        
        struct Choice: Decodable {
            let index: Int
            let message: Message? // for chat comnpletion
            let text: String? // for simple completion
            let finish_reason: String
            
            struct Message: Decodable {
                let role: String
                let content: String
                let refusal: String?
            }
        }
        
        struct Usage: Decodable {
            let prompt_tokens: Int
            let completion_tokens: Int
            let total_tokens: Int
        }
    }
    
    /// Create a language model response for a given chat conversation. This endpoint is compatible with the OpenAI API.
    struct ChatCompletionRequest: Encodable {
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
    
    /// Create a language model response for a given prompt. This endpoint is compatible with the OpenAI API.
    struct CompletionRequest: Encodable {
        init(model: String,
             prompt: String,
             best_of: Int? = nil,
             echo: Bool? = nil,
             frequency_penalty: Double? = nil,
             logit_bias: [String : Int]? = nil,
             logprobs: Bool? = nil,
             max_tokens: Int? = nil,
             n: Int? = nil,
             presence_penalty: Double? = nil,
             seed: Int? = nil,
             stop: [String]? = nil,
             stream: Bool? = nil,
             suffix: String? = nil,
             temperature: Double? = nil,
             top_p: Double? = nil,
             user: String? = nil) {
            self.model = model
            self.prompt = prompt
            self.best_of = best_of
            self.echo = echo
            self.frequency_penalty = frequency_penalty
            self.logit_bias = logit_bias
            self.logprobs = logprobs
            self.max_tokens = max_tokens
            self.n = n
            self.presence_penalty = presence_penalty
            self.seed = seed
            self.stop = stop
            self.stream = stream
            self.suffix = suffix
            self.temperature = temperature
            self.top_p = top_p
            self.user = user
        }
        
        /// Specifies the model to be used for the request.
        let model: String
        
        /// The prompt for completion.
        let prompt: String
        
        /// Generates multiple completions internally and returns the top-scoring one. Not functional yet.
        let best_of: Int?
        
        /// Option to include the original prompt in the response along with the generated completion.
        let echo: Bool?
        
        /// Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency.
        let frequency_penalty: Double?
        
        /// Maps tokens to bias values from -100 to 100.
        let logit_bias: [String: Int]?
        
        /// Include log probabilities of output tokens.
        let logprobs: Bool?
        
        /// Limits the number of tokens that can be produced in the output.
        let max_tokens: Int?
        
        /// Number of completion sequences to produce for each prompt.
        let n: Int?
        
        /// Number between -2.0 and 2.0. Positive values penalize new tokens based on presence.
        let presence_penalty: Double?
        
        /// For deterministic sampling attempts.
        let seed: Int?
        
        /// Up to 4 sequences where the API will stop generating further tokens.
        let stop: [String]?
        
        /// Whether to stream back partial progress.
        let stream: Bool?
        
        /// Stream options
        //       let stream_options: Any?
        
        /// Optional string to append after the generated text.
        let suffix: String?
        
        /// Sampling temperature between 0 and 2.
        let temperature: Double?
        
        /// For nucleus sampling, probability mass to consider.
        let top_p: Double?
        
        /// Unique identifier representing the end-user.
        let user: String?
    }
}

public struct AuthenticationKey {
    public init(_ value: String) { self.value = value }
    let value: String
}
