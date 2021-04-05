import Fluent
import Vapor

final class Author: Model, Content {
    static let schema = "authors"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "first_name")
    var first_name: String
    
    @Field(key: "last_name")
    var last_name: String

    init() { }

    init(id: UUID? = nil, first_name: String, last_name: String) {
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
    }
}
