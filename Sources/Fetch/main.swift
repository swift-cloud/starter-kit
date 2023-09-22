import Compute

try await onIncomingRequest { req, res in
    let data = try await Cache.getOrSet("xxx") {
        let res = try await fetch("https://httpbin.org/json")
        let data = try await res.jsonObject()
        return (data, .ttl(60))
    }
    console.log("state: \(data.state.rawValue) hits: \(data.hits) age: \(data.age) content-length: \(data.contentLength)")
    try await res
        .status(200)
        .header(.contentLength, "\(data.contentLength)")
        .send(data.body)
}
