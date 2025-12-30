import Foundation

class detailsViewModel {
    var movieDetail: movieDetail?
    
    func fetchMovieDetails(imdbID: String, completion: @escaping () -> Void) {
        let urlString = "https://www.omdbapi.com/?apikey=fd67c604&i=\(imdbID)&plot=full"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            let decoded = try! JSONDecoder().decode(Finaluri_first_.movieDetail.self, from: data!)
            self.movieDetail = decoded
            
            DispatchQueue.main.async {
                completion()
            }
        }.resume()
    }
}
