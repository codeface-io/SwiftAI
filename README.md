# SwiftAI

AI agents in Swift.

First goal: Easy access to the major LLM APIs (Grok, Claude, ChatGPT):

```swift
import SwiftAI

@main
struct ExampleApp {
    static func main() async {
        let prompt = "What is the meaning of life? Keep your answer super concise and to the point :)"
        
        do {
            let response = try await XAI.ChatCompletions.post(
                XAI.ChatCompletions.Request([.init(prompt)]),
                authenticationKey: .xAI
            )
            
            print(response.choices.first?.message?.content ?? "")
        } catch {
            print(error)
        }
    }
}
```