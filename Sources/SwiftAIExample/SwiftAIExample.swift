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

func demonstrate() async throws(HTTP.RequestError) {
    let prompt = "What is the meaning of life? Be concise and to the point :)"
    
    let grokResponse = try await XAI.ChatCompletions.post(
        XAI.ChatCompletions.Request([.init(prompt)]),
        authenticationKey: .xAI
    )
    
    let grokAnswer = grokResponse.choices.first?.message?.content ?? ""
    
    print(grokAnswer)
    
    let claudeResponse = try await Anthropic.Messages.post(
        Anthropic.Messages.Request([.init(prompt)]),
        authenticationKey: .anthropic
    )
    
    let claudeAnswer = claudeResponse.content.first?.text ?? ""
    
    print(claudeAnswer)
    
    let chatGPTResponse = try await OpenAI.ChatCompletions.post(
        OpenAI.ChatCompletions.Request([.init(prompt)]),
        authenticationKey: .openAI
    )
    
    let chatGPTAnswer = chatGPTResponse.choices.first?.message.content ?? ""
    
    print(chatGPTAnswer)
}
