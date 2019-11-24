//
//  GenreViewModel.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 20/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import Alamofire

final class GenreViewModel {
    private let genre: Genre
    
    var id: Int {
        return self.genre.id ?? 0
    }
    
    var name: String {
        return self.genre.name ?? ""
    }
    
    init(genre: Genre) {
        self.genre = genre
    }
}
