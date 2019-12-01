//
//  MoviesListController.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 20/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import UIKit

final class MoviesListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Constants
    
    private let LOADING_CELL_COUNT = 3
    
    //MARK: - Public
    
    var genresList = GenresListViewModel()
    var moviesList = MoviesListViewModel()
    
    //MARK: - Private
    
    private var page: Int = 1
    private var genres: [GenreViewModel]?
    private var isLoading = false
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyStyle()
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - Private Methods
    
    private func applyStyle() {
        //Navigation Bar
        self.navigationController?.navigationBar.barTintColor = .dsNavbarBG
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.dsTextPrimary]
        
        //Controller
        self.view.backgroundColor = .dsBGPrimary
        self.tableView.backgroundColor = .clear
    }
    
    private func loadData() {
        self.genresList.loadGenres()
        self.loadMoreMovies()
    }
    
    private func loadMoreMovies() {
        self.isLoading = true
        self.moviesList.loadNextPage() { [weak self] newResultsCount, error in
            guard let self = self else { return }
            if let err = error {
                self.showError(error: err)
            } else {
                self.tableView.reloadData()
                self.isLoading = false
            }
        }
    }
    
    private func showError(error: Error) {
        //TODO: handle error
    }
    
    //MARK: - TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let loadingCells = self.moviesList.hasNextPage ? self.LOADING_CELL_COUNT : 0
        return self.moviesList.movies.count + loadingCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.moviesList.movies.count > indexPath.row {
            if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieCell, for: indexPath) {
                cell.setData(self.moviesList.movies[indexPath.row])
                return cell
            }
        } else if let cellLoading = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieLoadingCell, for: indexPath) {
            cellLoading.startAnimation()
            return cellLoading
        }
        
        
        return UITableViewCell()
    }
    
    //MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > self.moviesList.movies.count-1 && !self.isLoading {
            self.loadMoreMovies()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < self.moviesList.movies.count {
            let movie = self.moviesList.movies[indexPath.row]
            self.performSegue(withIdentifier: R.segue.moviesListController.showDetail, sender: movie)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailController, let movie = sender as? MovieViewModel {
            vc.movie = movie
            vc.genresList = self.genresList
        }
    }
}
