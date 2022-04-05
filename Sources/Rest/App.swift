import Compute
import Foundation

@main
struct App {
    static func main() async throws {
        try await onIncomingRequest(router.run)
    }

    static let router = Router()
        .get("/status") { req, res in
            try await res.status(.ok).send("OK")
        }
        .get("/user/:name") { req, res in
            try await res.status(.ok).send("Your name is \(req.pathParams["name"] ?? "")")
        }
        .post("/message") { req, res in
            let body = try await req.body.jsonObject()
            if let message = body["message"] as? String {
                try await res.status(.created).send("Message sent: \(message)")
            } else {
                try await res.status(.badRequest).send("Missing required param: message")
            }
        }
}
