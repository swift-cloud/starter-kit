import Compute

try await onIncomingRequest { req, res in
    let data = try await Cache.getOrSet("xxx") {
        let res = try await fetch("https://httpbin.org/json")
        return (res, .ttl(60))
    }
    console.log("hits:", data.hits)
    console.log("age:", data.age)
    console.log("content-length:", data.contentLength)
    try await res.status(200).send(data.body)
}
