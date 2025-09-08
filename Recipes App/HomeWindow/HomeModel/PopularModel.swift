
struct PopularModel: Codable {
    let results: [PopularResult]
}

struct PopularResult: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let maxReadyTime: Int?
}
