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
    
    // Grok
    let grok = XAI.Grok(.grokBeta, key: .xAI)
    let grokAnswer = try await grok.complete(chat: [Message(prompt)])
    print(grokAnswer.content)
    
    // Claude
    let claude = Anthropic.Claude(.claude_3_5_Sonnet, key: .anthropic)
    let claudeAnswer = try await claude.complete(chat: [Message(prompt)])
    print(claudeAnswer.content)
    
    // ChatGPT
    let chatGPT = OpenAI.ChatGPT(.gpt_4o, key: .openAI)
    let chatGPTAnswer = try await chatGPT.complete(chat: [Message(prompt)])
    print(chatGPTAnswer.content)
}
