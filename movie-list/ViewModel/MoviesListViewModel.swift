//
//  MoviesListViewModel.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 21/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import Foundation

typealias MoviesListLoadPageCompletion = (Int, Error?) -> Void

final class MoviesListViewModel {
    private let movieListAPI: MovieListAPI
    private var list: MoviesList?
    
    var movies: [MovieViewModel] = []
    
    var page: Int {
        return self.list?.page ?? 0
    }
    
    var totalPages: Int {
        return self.list?.total_pages ?? 0
    }
    
    var hasNextPage: Bool {
        return self.totalPages == 0 || self.page < self.totalPages
    }
    
    init(movieListAPI: MovieListAPI = MovieListAPI()) {
        self.movieListAPI = movieListAPI
    }
    
    func loadNextPage(completion: @escaping MoviesListLoadPageCompletion) {
        let nextPage = self.page + 1
        movieListAPI.loadMovies(page: nextPage) { [weak self] movieList, error in
            guard error == nil else {
                completion(0, error)
                return
            }
            
            self?.list = movieList
            self?.appendNewMoviews(newMovies: movieList?.results)
            completion(movieList?.results?.count ?? 0, nil)
        }
    }
    
    private func appendNewMoviews(newMovies: [Movie]?) {
        if let newMoviesToAdd = newMovies {
            for movie in newMoviesToAdd {
                self.movies.append(MovieViewModel(movie: movie))
            }
        }
    }
}
