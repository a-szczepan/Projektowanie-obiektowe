import Fluent
import Vapor

final class Book: Model, Content {
    static let schema = "books"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "authorId")
    var authorId: UUID

    @Field(key: "publisherId")
    var publisherId: UUID

    @Field(key: "title")
    var title: String

    init() {
        //init
     }

    init(id: UUID? = nil, authorId: String, publisherId: String, title: String) {
        self.id = id
        self.authorId = UUID(uuidString: authorId)!
        self.publisherId = UUID(uuidString: publisherId)!
        self.title = title
    }
}
