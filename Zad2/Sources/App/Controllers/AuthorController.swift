import Fluent
import Vapor

struct AuthorController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {}

    func list(_ req: Request) throws -> EventLoopFuture<View> {
        let allAuthors = Author.query(on: req.db).all()
        return allAuthors.flatMap { authors in
            let data = ["authorList": authors]
            return req.view.render("authors", data)
        }
    }

    func create(req: Request) throws -> EventLoopFuture<Response> {
        let author = try req.content.decode(Author.self)
        return author.save(on: req.db).map { _ in
            return req.redirect(to: "/authors")
        }
    }

    func update(req: Request) throws -> EventLoopFuture<Response> {
        let input = try req.content.decode(Author.self)
        return Author.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { author in
                author.first_name = input.first_name
                author.last_name = input.last_name
                return author.save(on: req.db).map { _ in
                    return req.redirect(to: "/authors")
                }
            }
    }

    func delete(req: Request) throws -> EventLoopFuture<Response> {
        return Author.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in
                return req.redirect(to: "/authors")
            }
    }
}
