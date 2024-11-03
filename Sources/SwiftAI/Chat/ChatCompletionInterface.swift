/**
 An interface describing chat completion, which all LLMs can do
 
 Design notes:
 * no instances but keeping the LLM abstraction just a bunch of pure/global/free service functions
 * specific interfaces for specific functionalities (interface seggregation principle)
 * no additional logic or functionality or abstraction beyond just abstracting away from each LLM APIs specifics
    * the interfaces describe an LLM API in general (the commonalities) and are still an I/O model (like a view model) but not an actual domain model
 */
public protocol ChatCompletionInterface { // only static properties and functions! no instantiation required
    static func complete(chat: [Message],
                         key: AuthenticationKey) async throws -> Message
}

enum ChatCompletionError: Error {
    case responseLacksData
}
