import Foundation
struct movieDetail: Codable {
    let Title: String
    let Year: String
    let Runtime: String?
    let Genre: String?
    let Plot: String?
    let Poster: String
    let imdbRating: String?
    let imdbID: String
}
