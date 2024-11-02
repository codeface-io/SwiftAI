# SwiftAI

AI agents in Swift.

First goal: Easy access to all major LLM APIs:

```swift
import SwiftAI

@main
struct ExampleApp {
    static func main() async {
        let prompt = "What is the meaning of life, the universe, and everything?"
        
        do {
            let answer = try await XAI.Completion.complete(
                prompt: prompt,
                authenticationKey: .xAI
            )
            
            print(answer)
        } catch {
            print(error)
        }
    }
}
```