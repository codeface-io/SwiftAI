# SwiftAI

🚀 Future: AI agents in Swift.

🏁 Now: Easy use of Grok, Claude and ChatGPT:

```swift
import SwiftAI

func demonstrate() async throws {
    let prompt = "What is the meaning of life? Be concise and to the point :)"
    
    // Grok
    let grokResponse = try await XAI.ChatCompletions.post(
        XAI.ChatCompletions.Request([.init(prompt)]),
        authenticationKey: .xAI
    )
    
    let grokAnswer = grokResponse.choices.first?.message?.content ?? ""
    
    print(grokAnswer)
    
    // Claude
    let claudeResponse = try await Anthropic.Messages.post(
        Anthropic.Messages.Request([.init(prompt)]),
        authenticationKey: .anthropic
    )
    
    let claudeAnswer = claudeResponse.content.first?.text ?? ""
    
    print(claudeAnswer)
    
    // ChatGPT
    let chatGPTResponse = try await OpenAI.ChatCompletions.post(
        OpenAI.ChatCompletions.Request([.init(prompt)]),
        authenticationKey: .openAI
    )
    
    let chatGPTAnswer = chatGPTResponse.choices.first?.message.content ?? ""
    
    print(chatGPTAnswer)
}
```