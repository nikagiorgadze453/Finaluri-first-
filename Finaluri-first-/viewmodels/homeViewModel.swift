import Foundation
class homeViewModel {
    var movies: [movie] = []
    func fetchMovies(completion: @escaping () -> Void) {
        let urlString = "https://www.omdbapi.com/?apikey=5b5df070&s=man&type=movie"
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            let decodedResponse = try! JSONDecoder().decode(movieSearchResponse.self, from: data!)
            if let searchResults = decodedResponse.Search {
                self.movies = searchResults
            }
            DispatchQueue.main.async {
                completion()
            }
        }.resume()
    }
}
