import Foundation

class favoritesViewModel {
    var movies: [movie] = []
    
    func fetchFavoriteMovies(completion: @escaping () -> Void) {
        let favoriteIDs = FavoritesManager.shared.getfavorites()
        if favoriteIDs.isEmpty {
            self.movies = []
            DispatchQueue.main.async {
                completion()
            }
            return
        }
        movies = []
        for id in favoriteIDs {
            let urlString = "https://www.omdbapi.com/?apikey=fd67c604&i=\(id)"
            let url = URL(string: urlString)!
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decoded = try! JSONDecoder().decode(movieDetail.self, from: data)
                    let movieItem = movie(
                        Title: decoded.Title,
                        Year: decoded.Year,
                        imdbID: decoded.imdbID,
                        Poster: decoded.Poster,
                    )
                    self.movies.append(movieItem)
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }.resume()
        }
    }
}
