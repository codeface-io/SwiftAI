import SwiftAI

@main
struct ExampleApp {
    static func main() async {
        let prompt = "What is the meaning of life? Keep your answer super concise and to the point :)"
        
        do {
            let answer = try await demonstrateAnthropic(prompt: prompt)
            print(answer)
        } catch {
            print(error)
        }
    }
    
    static func demonstrateAnthropic(prompt: String) async throws -> String  {
        let response = try await Anthropic.Messages.post(
            Anthropic.Messages.Request([.init(prompt)]),
            authenticationKey: .anthropic
        )
        
        return response.content.first?.text ?? ""
    }
    
    static func demonstrateXAI(prompt: String) async throws -> String  {
        let response = try await XAI.ChatCompletions.post(
            XAI.ChatCompletions.Request([.init(prompt)]),
            authenticationKey: .xAI
        )
        
        return response.choices.first?.message?.content ?? ""
    }
}
