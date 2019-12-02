//
//  Favorites.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 02/12/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import Foundation

final class Favorites {
    
    //MARK: - Constants
    
    private let FAVORITES_KEY = "favorites"
    
    static let shared = Favorites()
    
    var list: [MovieViewModel] = []
    
    init() {
        
        if let savedFavorites = UserDefaults.standard.object(forKey: FAVORITES_KEY) as? Data {
            let decoder = JSONDecoder()
            if let loadedFavorites = try? decoder.decode([MovieViewModel].self, from: savedFavorites) {
                self.list = loadedFavorites
            }
        }
    }
    
    func addMovie(_ movie: MovieViewModel) {
        self.list.append(movie)
        self.save()
    }
    
    func removeMovie(_ movie: MovieViewModel) {
        self.list.removeAll(where: { $0.id == movie.id })
        self.save()
    }
    
    func isFavorite(movie: MovieViewModel) -> Bool {
        return self.list.first(where: { $0.id == movie.id }) != nil
    }
    
    private func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.list) {
            UserDefaults.standard.set(encoded, forKey: FAVORITES_KEY)
            UserDefaults.standard.synchronize()
        }
    }
}
