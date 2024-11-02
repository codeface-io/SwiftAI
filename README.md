# SwiftAI

AI agents in Swift.

First goal: Easy access to the major LLM APIs (Grok, Claude, ChatGPT):

```swift
import SwiftAI

func demonstrate() async throws {
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
}
```