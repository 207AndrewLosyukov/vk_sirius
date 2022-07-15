import Foundation

/// С помощью этой структуры мы храним информацию о конкретном сервисе.
struct Service: Codable, Hashable {
    let name: String
    let icon_url: String
    let description: String
    let link: String
}

/// С помощью этой структуры мы  храним декодированный данные.
struct JSONDecode: Decodable, Hashable {
    let body: Services
    struct Services: Decodable, Hashable {
        let services: [Service]
    }
}
