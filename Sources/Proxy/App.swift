import Compute
import Foundation

@main
struct App {
    static func main() async throws {
        try await onIncomingRequest(handleIncomingRequest)
    }

    static func handleIncomingRequest(req: IncomingRequest, res: OutgoingResponse) async throws {
        print(req.method.rawValue, req.url.path, req.searchParams)
        let data = try await fetch(req, origin: "https://httpbin.org", .options(
            cachePolicy: .ttl(60, staleWhileRevalidate: 60)
        ))
        try await res
            .upgradeToHTTP3()
            .proxy(data)
    }
}
