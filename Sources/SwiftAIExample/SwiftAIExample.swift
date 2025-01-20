import SwiftAI
import FoundationToolz

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
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

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
func demonstrate() async throws {
    let prompt = "What is the meaning of life? Be concise and to the point."
    
    let chatAIs: [ChatAI] = [
        XAI.Grok(.grokBeta, key: .myKey),
        Anthropic.Claude(.claude_3_5_Sonnet, key: .myKey),
        OpenAI.ChatGPT(.gpt_4o, key: .myKey)
    ]
    
    for chatAI in chatAIs {
        let answer = try await chatAI.complete(chat: [Message(prompt)], systemPrompt: nil)
        print(answer.content)
    }
}
