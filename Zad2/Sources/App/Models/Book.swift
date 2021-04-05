import Fluent
import Vapor

final class Book: Model, Content {
    static let schema = "books"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "author_id")
    var author_id: UUID

    @Field(key: "publisher_id")
    var publisher_id: UUID

    @Field(key: "title")
    var title: String

    init() { }

    init(id: UUID? = nil, author_id: String, publisher_id: String, title: String) {
        self.id = id
        self.author_id = UUID(uuidString: author_id)!
        self.publisher_id = UUID(uuidString: publisher_id)!
        self.title = title
    }
}
