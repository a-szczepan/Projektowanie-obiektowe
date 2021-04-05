import Fluent

struct CreatePublishers: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("publishers")
            .id()
            .field("name", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("publishers").delete()
    }
}
