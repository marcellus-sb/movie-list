//
//  GenreListViewModel.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 24/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import Foundation

typealias GenresListLoadPageCompletion = (Error?) -> Void

final class GenresListViewModel {
    private let genreAPI: GenreAPI
    private var list: GenresList?
    
    var genres: [GenreViewModel] = []
    
    init(genreAPI: GenreAPI = GenreAPI()) {
        self.genreAPI = genreAPI
    }
    
    func loadGenres() {
        genreAPI.loadGenres() { [weak self] genresList, error in
            guard error == nil else {
                return
            }
            
            self?.list = genresList
            self?.genres = []
            if let allGenres = genresList?.genres {
                for genre in allGenres {
                    self?.genres.append(GenreViewModel(genre: genre))
                }
            }
        }
    }
}
