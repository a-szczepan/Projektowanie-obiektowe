import Fluent
import FluentSQLiteDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    app.migrations.add(CreateBooks())
    app.migrations.add(CreatePublishers())
    app.migrations.add(CreateAuthors())

    app.views.use(.leaf)

    try app.autoMigrate().wait()

    // register routes
    try routes(app)
}