import Foundation

struct movieSearchResponse: Codable {
    let Search: [movie]?
    let totalResults: String?
    let Response: String
}

struct movie: Codable {
    let Title: String
    let Year: String
    let imdbID: String
    let Poster: String
}

