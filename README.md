# SwiftAI

🛸 Future: AI agents as declarative Swift?

✨ Now: Easy use of Grok, Claude and ChatGPT:

```swift
import SwiftAI

func demonstrate() async throws {
    let prompt = "What is the meaning of life? Be concise and to the point."
    
    let chatAIs: [ChatAI] = [
        XAI.Grok(.grokBeta, key: .myKey),
        Anthropic.Claude(.claude_3_5_Sonnet, key: .myKey),
        OpenAI.ChatGPT(.gpt_4o, key: .myKey)
    ]
    
    for chatAI in chatAIs {
        let answer = try await chatAI.complete(chat: [Message(prompt)])
        print(answer.content)
    }
}
```
