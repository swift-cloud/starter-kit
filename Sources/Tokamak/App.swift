import Compute
import TokamakStaticHTML

@main
struct App {
    static func main() async throws {
        try await onIncomingRequest(router.run)
    }

    static let router = Router()
        .get("/") { req, res in
            let html = StaticHTMLRenderer(view).render()
            try await res.status(.ok).send(html, html: true)
        }

    static var view: some View {
        Text("Hello, World")
    }
}
