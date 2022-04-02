import Compute

@main
struct App {
    static func main() async throws {
        try await onIncomingRequest(handleIncomingRequest)
    }

    static func handleIncomingRequest(req: IncomingRequest, res: OutgoingResponse) async throws {
        let data = try await fetch(req, origin: "https://httpbin.org")
        try await res.proxy(data)
    }
}
