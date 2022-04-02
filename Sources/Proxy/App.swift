import Compute
import Foundation

@main
struct App {
    static func main() async throws {
        console.log("App.main()", Date().description)
        try await onIncomingRequest(handleIncomingRequest)
    }

    static func handleIncomingRequest(req: IncomingRequest, res: OutgoingResponse) async throws {
        let data = try await fetch(req, origin: "https://httpbin.org", .options(
            cachePolicy: .ttl(60, staleWhileRevalidate: 60)
        ))
        try await res
            .upgradeToHTTP3()
            .header(.contentType, data.headers[.contentType])
            .header(.contentLength, data.headers[.contentLength])
            .append(data.body)
            .end()
    }
}
