import SwiftAI

@main
struct ExampleApp {
    static func main() async {
        let prompt = "What is the meaning of life, the universe, and everything?"
        
        do {
            let response = try await XAI.Completions.post(
                XAI.Completions.Request(prompt: prompt),
                authenticationKey: .xAI
            )
            
            print(response.choices.first?.text ?? "")
        } catch {
            print(error)
        }
    }
}
