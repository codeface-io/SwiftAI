extension XAI {
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
}
