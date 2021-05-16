import Fluent
import Vapor

struct BookController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        //routes builder
    }

    let bookRout = "/books"

    func list(_ req: Request) throws -> EventLoopFuture<View> {
        let allBooks = Book.query(on: req.db).all()
        return allBooks.flatMap { books in
            let data = ["bookList": books]
            return req.view.render("books", data)
        }
    }

    func create(req: Request) throws -> EventLoopFuture<Response> {
        let book = try req.content.decode(Book.self)
        return book.save(on: req.db).map { _ in
            return req.redirect(to: self.bookRout)
        }
    }

    func update(req: Request) throws -> EventLoopFuture<Response> {
        let input = try req.content.decode(Book.self)
        return Book.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { book in
                book.author_id = input.author_id
                book.publisher_id = input.publisher_id
                book.title = input.title
                return book.save(on: req.db).map { _ in
                    return req.redirect(to: self.bookRout)
                }
            }
    }

    func delete(req: Request) throws -> EventLoopFuture<Response> {
        return Book.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in
                return req.redirect(to: self.bookRout)
            }
    }
}
