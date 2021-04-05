import Fluent

struct CreateAuthors: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("authors")
            .id()
            .field("first_name", .string, .required)
            .field("last_name", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("authors").delete()
    }
}
