import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    private let key = "savedFavorites"
    
    private init() {}
    
    func savefavorite(movieID: String) {
        var favorites = getfavorites()
        if !favorites.contains(movieID) {
            favorites.append(movieID)
            UserDefaults.standard.set(favorites, forKey: key)
        }
    }
    
    func removefavorite(movieID: String) {
        var favorites = getfavorites()
        favorites.removeAll { $0 == movieID }
        UserDefaults.standard.set(favorites, forKey: key)
    }
    
    func isfavorite(movieID: String) -> Bool {
        let favorites = getfavorites()
        return favorites.contains(movieID)
    }
    
    func getfavorites() -> [String] {
        return UserDefaults.standard.array(forKey: key) as? [String] ?? []
    }
}

