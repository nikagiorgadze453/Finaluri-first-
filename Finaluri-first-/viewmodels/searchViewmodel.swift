import Foundation

class SearchViewModdel{
    var movies: [movieDetail] = []
    var sorttype: String = "Name"
    
    func searchMovies(query: String, completion: @escaping () -> Void) {
        let urlString = "https://www.omdbapi.com/?apikey=fd67c604&s=\(query)&type=movie&page=1"
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
                    completion()
                    return
                }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                        self.movies = []
                            completion()
                        }
                        return
                    }
            let searchResponse = try? JSONDecoder().decode(movieSearchResponse.self, from: data)
                    if let results = searchResponse?.Search {
                        self.movies = []
                        for result in results {
                            self.fetchMovieDetail(imdbID: result.imdbID, completion: completion)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.movies = []
                            completion()
                        }
                    }
                }.resume()
            }
    func fetchMovieDetail(imdbID: String, completion: @escaping () -> Void) {
                let urlString = "https://www.omdbapi.com/?apikey=fd67c604&i=\(imdbID)"
                let url = URL(string: urlString)!
                
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        let detail = try? JSONDecoder().decode(movieDetail.self, from: data)
                        if let detail = detail {
                            self.movies.append(detail)
                            DispatchQueue.main.async {
                                completion()
                            }
                        }
                    }
                }.resume()
            }
        func sortMovies() {
                switch sorttype {
                case "Name":
                    movies.sort { $0.Title < $1.Title }
                case "Year":
                    movies.sort { $0.Year > $1.Year }
                case "Genre":
                    movies.sort { ($0.Genre ?? "") < ($1.Genre ?? "") }
                default:
                    break
                }
    }
}

