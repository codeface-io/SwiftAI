import SwiftAI
import FoundationToolz

@main
struct ExampleApp {
    static func main() async {
        do {
            let answer = try await Grok.complete(prompt: "What is the meaning of life, the universe, and everything?",
                                                 authenticationKey: .xAI)
            
            print(answer)
        } catch {
            print(error)
        }
    }
}

