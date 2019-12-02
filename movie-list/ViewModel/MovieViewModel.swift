//
//  MovieViewModel.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 20/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import Foundation

final class MovieViewModel: Codable {
    private let IMG_PREFIX_URL = "https://image.tmdb.org/t/p/w185"
    private var movie: Movie
    
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
    
    var genresText: String {
        return self.movie.genresText ?? ""
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
    
    var releaseDate: Date {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let inDate = self.movie.release_date, let date = inputFormatter.date(from: inDate) {
            return date
        } else {
            return Date()
        }
    }
    
    var releaseDateText: String {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yyyy"
        
        return outputFormatter.string(from: self.releaseDate)
    }
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func loadGenres(_ genresList: GenresListViewModel) {
        self.movie.genresText = genresList.getGenresLabelFrom(movie: self)
    }
}
