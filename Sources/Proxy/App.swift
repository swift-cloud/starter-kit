import Compute
import Foundation

@main
struct App {
    static func main() async throws {
        print("App.main()", Date())
        try await onIncomingRequest(handleIncomingRequest)
    }

    static func handleIncomingRequest(req: IncomingRequest, res: OutgoingResponse) async throws {
//        res.upgradeToHTTP3()
        let data = try await fetch(req, origin: "https://httpbin.org", .options(
            cachePolicy: .ttl(60, staleWhileRevalidate: 60)
        ))
        try await res.proxy(data)
    }
}
