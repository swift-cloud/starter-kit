import Compute

try await onIncomingRequest { req, res in
    let data = try await fetch("https://httpbin.org/json").jsonObject()
    try await res.status(200).send(data)
}
