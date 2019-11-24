//
//  MovieViewModel.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 20/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import Foundation

final class MovieViewModel {
    private let IMG_PREFIX_URL = "https://image.tmdb.org/t/p/w185"
    private let movie: Movie
    
    var id: Int {
        return self.movie.id ?? 0
    }
    
    var adult: Bool {
        return self.movie.adult ?? false
    }
    
    var video: Bool {
        return self.movie.video ?? false
    }
    
    var popularity: Double {
        return self.movie.popularity ?? 0.0
    }
    
    var voteCount: Int {
        return self.movie.vote_count ?? 0
    }
    
    var posterPath: String {
        if let path = self.movie.poster_path, !path.isEmpty {
            return "\(IMG_PREFIX_URL)\(path)"
        }
        
        return  ""
    }
    
    var backdropPath: String {
        if let path = self.movie.backdrop_path, !path.isEmpty {
            return "\(IMG_PREFIX_URL)\(path)"
        }
        
        return  ""
    }
    
    var originalLanguage: String {
        return self.movie.original_language ?? ""
    }
    
    var originalTitle: String {
        return self.movie.original_title ?? ""
    }
    
    var genreIds: [Int] {
        return self.movie.genre_ids ?? []
    }
    
    var title: String {
        return self.movie.title ?? ""
    }
    
    var voteAverage: Double {
        return self.movie.vote_average ?? 0.0
    }
    
    var overview: String {
        return self.movie.overview ?? ""
    }
    
    var releaseDate: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yyyy"
        
        if let inDate = self.movie.release_date, let date = inputFormatter.date(from: inDate) {
            return outputFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    init(movie: Movie) {
        self.movie = movie
    }
}
