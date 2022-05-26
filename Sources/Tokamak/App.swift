import Compute
import Foundation
import TokamakStaticHTML

@main
struct App {
    static func main() async throws {
        try await onIncomingRequest(router.run)
    }

    static let router = Router()
        .use { req, res in
            res.cors()
        }
        .get("/") { req, res in
            let html = StaticHTMLRenderer(view(req)).render()
            try await res.status(.ok).send(html: html)
        }

    static func view(_ req: IncomingRequest) -> some View {
        VStack(alignment: .leading) {
            HTMLTitle("Hello, Tokamak")
            HTMLMeta(charset: "utf-8")
            Text("Hello, Tokamak")
                .font(.title)
                .padding(.bottom, 10)
            Text("This is a fully dynamic server side swift app powered by Tokamak")
            Text("The current time is \(DateFormatter().string(from: Date()))")
            Text("Your IP address is \(req.clientIpAddress().stringValue)")
            Text("This page was dynamically rendered by edge node \(Environment.Compute.region)")
            Text("The trace id for this page was \(Environment.Compute.traceId)")
            Spacer().frame(height: 20)
            HStack(spacing: 5) {
                Text("Try it yourself on")
                Link(destination: .init(string: "https://swift.cloud")!) {
                    Text("swift.cloud").underline().foregroundColor(.blue)
                }
            }
            .font(.caption)
        }
        .padding(22)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
