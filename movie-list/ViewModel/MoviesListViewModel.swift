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
    
    enum OrderType {
        case ascending
        case descending
        case none
    }
    
    private let movieListAPI: MovieListAPI
    private var list: MoviesList?
    
    var movies: [MovieViewModel] = []
    
    var orderType: OrderType = .none {
        didSet {
            self.orderChanged()
        }
    }
    
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
    
    func loadNextPage(genresList: GenresListViewModel?, completion: @escaping MoviesListLoadPageCompletion) {
        let nextPage = self.page + 1
        movieListAPI.loadMovies(page: nextPage) { [weak self] movieList, error in
            guard error == nil else {
                completion(0, error)
                return
            }
            
            self?.list = movieList
            self?.appendNewMoviews(newMovies: movieList?.results, genresList: genresList)
            completion(movieList?.results?.count ?? 0, nil)
        }
    }
    
    private func orderChanged() {
        self.movies = self.orderList(movies: self.movies)
    }
    
    private func orderList(movies: [MovieViewModel]) -> [MovieViewModel]{
        return movies.sorted(by: { [weak self] movie1, movie2 in
            guard let self = self else { return false }
            switch self.orderType {
            case .ascending:
                return movie1.releaseDate < movie2.releaseDate
            case .descending:
                return movie1.releaseDate > movie2.releaseDate
            case .none:
                return false
            }
        })
    }
    
    private func appendNewMoviews(newMovies: [Movie]?, genresList: GenresListViewModel?) {
        if let newMoviesToAdd = newMovies {
            var listMovies: [MovieViewModel] = []
            for movie in newMoviesToAdd {
                let movieVM = MovieViewModel(movie: movie)
                if let genres = genresList {
                    movieVM.loadGenres(genres)
                }
                listMovies.append(movieVM)
            }
            
            self.movies.append(contentsOf: self.orderList(movies: listMovies))
        }
    }
}
