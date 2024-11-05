import SwiftAI
import FoundationToolz

@main
struct ExampleApp {
    static func main() async {
        do {
            try await demonstrate()
        } catch {
            print(error)
        }
    }
}

func demonstrate() async throws {
    let prompt = "What is the meaning of life? Be concise and to the point :)"
    
    let chatAIs: [ChatAI] = [
        XAI.Grok(.grokBeta, key: .xAI),
        Anthropic.Claude(.claude_3_5_Sonnet, key: .anthropic),
        OpenAI.ChatGPT(.gpt_4o, key: .openAI)
    ]
    
    for chatAI in chatAIs {
        let answer = try await chatAI.complete(chat: [Message(prompt)])
        print(answer.content)
    }
}
