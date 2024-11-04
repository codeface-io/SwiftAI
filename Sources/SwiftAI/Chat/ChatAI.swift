/**
 An interface describing chat completion, which all LLMs can do
 
 Design notes:
 * specific interfaces for specific functionalities (interface seggregation principle)
 * no additional logic or functionality or abstraction beyond just abstracting away from each LLM APIs specifics
    * the interfaces describe an LLM API in general (the commonalities) and are still an I/O model (like a view model) but not an actual domain model
 */
public protocol ChatAI {
    func complete(chat: [Message]) async throws -> Message
}

enum SwiftAIError: Error {
    case responseLacksData
}
