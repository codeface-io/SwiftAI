# SwiftAI

🛸 Future: AI agents as declarative Swift.

✨ Now: Easy use of Grok, Claude and ChatGPT:

```swift
import SwiftAI

func demonstrate() async throws {
    let prompt = "What is the meaning of life? Be concise and to the point :)"
    
    // Grok
    let grok = ChatAI.grokBeta(key: .xAI)
    let grokAnswer = try await grok.complete(chat: [Message(prompt)])
    print(grokAnswer.content)
    
    // Claude
    let claude = ChatAI.claude_3_5_Sonnet(key: .anthropic)
    let claudeAnswer = try await claude.complete(chat: [Message(prompt)])
    print(claudeAnswer.content)
    
    // ChatGPT
    let chatGPTResponse = try await OpenAI.ChatCompletions.post(
        OpenAI.ChatCompletions.Request([.init(prompt)]),
        key: .openAI
    )
    
    let chatGPTAnswer = chatGPTResponse.choices.first?.message.content ?? ""
    
    print(chatGPTAnswer)
}
```
