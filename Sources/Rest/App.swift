import Compute
import Foundation

@main
struct App {
    static func main() async throws {
        try await onIncomingRequest(router.run)
    }

    static let router = Router()
        .get("/status") { req, res in
            try await res.status(200).send("OK")
        }
        .get("/user/:name") { req, res in
            try await res.status(200).send("Your name is \(req.pathParams["name"] ?? "")")
        }
}
