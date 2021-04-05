import Fluent
import Vapor

func routes(_ app: Application) throws {
    let bookController = BookController()
    app.get("books", use: bookController.list)
    app.post("book", "create", use: bookController.create)
    app.post("book", "update", ":id", use: bookController.update)
    app.post("book", "delete", ":id", use: bookController.delete)
    
    let authorController = AuthorController()
    app.get("authors", use: authorController.list)
    app.post("author", "create", use: authorController.create)
    app.post("author", "update", ":id", use: authorController.update)
    app.post("author", "delete", ":id", use: authorController.delete)

    let publisherController = PublisherController()
    app.get("publishers", use: publisherController.list)
    app.post("publisher", "create", use: publisherController.create)
    app.post("publisher", "update", ":id", use: publisherController.update)
    app.post("publisher", "delete", ":id", use: publisherController.delete)
}
