import Compute
import Foundation
import CryptoSwift

extension String: Error {}

struct MessagePayload: Codable {
    var text: String?
    var responseType: String?
}

@main
struct App {
    static func main() async throws {
        try await onIncomingRequest(router.run)
    }

    static let router = Router()
        .get("/status") { req, res in
            try await res.status(.ok).send("OK")
        }
    
        .post("/webhook") { req, res in
            let signature = req.headers.get("X-Slack-Signature")
            let timestamp = req.headers.get("X-Slack-Request-Timestamp")
            let version = "v0" // slack version number is always "v0" right now

            print("X-Slack-Request-Timestamp -> \(timestamp ?? "")")
            
            let env = try Compute.Dictionary(name: "env")
            let secret = env.get("SLACK_SIGNING_SECRET")
            let rawBody = try await req.body.text()

            func validateSignature(payload: [UInt8]) async throws -> Bool {
               guard let secret = secret else {
                 // noop for development
                 return false
               }
               let hmac = try HMAC(key: secret, variant: .sha2(.sha256))
               let expected = try "\(version)=" + hmac.authenticate(payload).toHexString()
            
               print("[validateSignature] expected -> \(expected)")
               print("[validateSignature] signature -> \(signature ?? "")")
               return signature == expected
            }
            
            let payload = "\(version):\(timestamp!):\(rawBody)"

            guard try await validateSignature(payload: payload.bytes) else {
                return try await res.status(.unauthorised).send("Invalid request")
            }

            let formDict = try await req.body.formValues()
            
            guard let slackWebhookURL = formDict["response_url"] else {
                return try await res.status(.badRequest).send("Missing response_url")
            }
            
            guard let userName = formDict["user_name"] else {
                return try await res.status(.badRequest).send("Missing user_name")
            }

            print("slackWebhookURL -> \(slackWebhookURL)")
            print("userName -> \(userName)")

            let response = try await fetch(
                slackWebhookURL,
                .options(
                    method: .post,
                    body: .json([
                        "text": "Hello, \(userName.capitalized)",
                        "response_type": "in_channel"
                    ])
                )
            )

            try await res.status(.ok).send()
        }
    
        .get("/test") { req, res in
            let messageBody = MessagePayload(text: "Test", responseType: "ephemeral")
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let encodedMessageBody = try encoder.encode(messageBody)
            try await res.status(.ok).send(messageBody, encoder: encoder)
        }
    
}
