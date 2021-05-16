import Fluent

struct CreateBooks: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("books")
            .id()
            .field("authorId", .uuid, .required, .references("authors", "id"))
            .foreignKey("authorId", references: "authors", "id", onDelete: .cascade)
            .field("publisherId", .uuid, .required, .references("publishers", "id"))
            .foreignKey("publisherId", references: "publishers", "id", onDelete: .cascade)
            .field("title", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("books").delete()
    }
}
