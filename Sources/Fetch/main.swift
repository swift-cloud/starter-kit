import Compute

try await onIncomingRequest { req, res in
    let options: FetchRequest.Options = .options(cachePolicy: .ttl(10), cacheKey: "/index")
    let data = try await fetch("https://httpbin.org/json", options).jsonObject()
    try await res.status(200).send(data)
}
