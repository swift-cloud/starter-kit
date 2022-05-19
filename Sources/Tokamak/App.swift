import Compute
import Foundation
import TokamakStaticHTML

@main
struct App {
    static func main() async throws {
        try await onIncomingRequest(router.run)
    }

    static let router = Router()
        .get("/") { req, res in
            let html = StaticHTMLRenderer(view(req)).render()
            try await res.status(.ok).send(html, html: true)
        }

    static func view(_ req: IncomingRequest) -> some View {
        VStack(alignment: .leading) {
            Text("Hello, Tokamak")
                .font(.title)
            Text("This is fully dynamic server side swift app powered by Tokamak")
            Text("The current time is: \(DateFormatter().string(from: Date()))")
            Text("Your IP address is \(req.clientIpAddress().stringValue)")
            Text("This page was dynamically rendered by edge node \(Environment.Compute.region)")
            Text("The trace id for this page was \(Environment.Compute.traceId)")
        }
        .padding(24)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
