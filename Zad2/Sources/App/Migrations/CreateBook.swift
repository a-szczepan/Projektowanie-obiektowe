import Fluent

struct CreateBooks: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("books")
            .id()
            .field("author_id", .uuid, .required, .references("authors", "id"))
            .foreignKey("author_id", references: "authors", "id", onDelete: .cascade)
            .field("publisher_id", .uuid, .required, .references("publishers", "id"))
            .foreignKey("publisher_id", references: "publishers", "id", onDelete: .cascade)
            .field("title", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("books").delete()
    }
}
