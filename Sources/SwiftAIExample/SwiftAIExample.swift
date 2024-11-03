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
    let grok = ChatBot.grokBeta(key: .xAI)
    let grokAnswer = try await grok.complete(chat: [Message(prompt)])
    print(grokAnswer.content)
    
    // Claude
    let claudeResponse = try await Anthropic.Messages.post(
        Anthropic.Messages.Request([.init(prompt)]),
        key: .anthropic
    )
    
    let claudeAnswer = claudeResponse.content.first?.text ?? ""
    
    print(claudeAnswer)
    
    // ChatGPT
    let chatGPTResponse = try await OpenAI.ChatCompletions.post(
        OpenAI.ChatCompletions.Request([.init(prompt)]),
        key: .openAI
    )
    
    let chatGPTAnswer = chatGPTResponse.choices.first?.message.content ?? ""
    
    print(chatGPTAnswer)
}
