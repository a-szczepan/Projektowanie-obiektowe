import Fluent
import Vapor

struct PublisherController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        //routes builder
    }

    let publisherRout = "/publishers"

    func list(_ req: Request) throws -> EventLoopFuture<View> {
        let allPublishers = Publisher.query(on: req.db).all()
        return allPublishers.flatMap { publishers in
            let data = ["publisherList": publishers]
            return req.view.render("publishers", data)
        }
    }

    func create(req: Request) throws -> EventLoopFuture<Response> {
        let publisher = try req.content.decode(Publisher.self)
        return publisher.save(on: req.db).map { _ in
            return req.redirect(to: self.publisherRout)
        }
    }

    func update(req: Request) throws -> EventLoopFuture<Response> {
        let input = try req.content.decode(Publisher.self)
        return Publisher.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { publisher in
                publisher.name = input.name
                return publisher.save(on: req.db).map { _ in
                    return req.redirect(to: self.publisherRout)
                }
            }
    }

    func delete(req: Request) throws -> EventLoopFuture<Response> {
        return Publisher.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in
                return req.redirect(to: self.publisherRout)
            }
    }
}
