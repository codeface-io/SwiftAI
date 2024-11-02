import FoundationToolz

extension XAI {
    public enum Completion {
        public static func complete(prompt: String,
                                    authenticationKey: AuthenticationKey) async throws(HTTP.RequestError) -> String {
            let response: Response = try await HTTP.sendRequest(
                to: baseURL + "v1/completions",
                using: .POST,
                content: Request(model: "grok-beta", prompt: prompt),
                authorizationValue: "Bearer " + authenticationKey.value
            )
            
            return response.choices.first?.text ?? ""
        }
        
        /// Create a language model response for a given prompt. This endpoint is compatible with the OpenAI API.
        struct Request: Encodable {
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
}
