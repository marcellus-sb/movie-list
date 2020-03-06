//
//  MoviesListController.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 20/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import UIKit

final class MoviesListController: TabBaseController, UITableViewDataSource, UITableViewDelegate {
    
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
    @IBOutlet weak var orderButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.regiterCells()
        self.applyStyle()
        self.loadData()
    }
    
    //MARK: - Private Methods
    
    private func regiterCells() {
        self.tableView.register(MovieCellView.self, forCellReuseIdentifier: MovieCellView.identifier)
        self.tableView.register(MovieLoadingCellView.self, forCellReuseIdentifier: MovieLoadingCellView.identifier)
    }
    
    private func applyStyle() {
        self.tableView.backgroundColor = .clear
        self.orderButton.tintColor = .dsTextPrimary
    }
    
    private func loadData() {
        let group = DispatchGroup()
        self.loadAllGenres(group)
        self.loadMoreMovies(group)
        
        group.notify(queue: DispatchQueue.main) { [weak self] in
            self?.updateGenresText()
            self?.tableView.reloadData()
        }
    }
    
    private func updateGenresText() {
        for movie in self.moviesList.movies {
            movie.loadGenres(self.genresList)
        }
    }
    
    private func loadAllGenres(_ group: DispatchGroup) {
        group.enter()
        self.genresList.loadGenres() { error in
            group.leave()
        }
    }
    
    private func loadMoreMovies(_ group: DispatchGroup? = nil) {
        group?.enter()
        self.isLoading = true
        self.moviesList.loadNextPage(genresList: self.genresList) { [weak self] newResultsCount, error in
            guard let self = self else { return }
            if let err = error {
                self.showError(error: err)
            } else {
                if let dispatchGroup = group {
                    dispatchGroup.leave()
                } else {
                    self.tableView.reloadData()
                }
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: MovieCellView.identifier, for: indexPath) as? MovieCellView {
                cell.setData(self.moviesList.movies[indexPath.row])
                return cell
            }
        } else if let cellLoading = tableView.dequeueReusableCell(withIdentifier: MovieLoadingCellView.identifier, for: indexPath) as? MovieLoadingCellView {
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
            MovieDetail2Controller.loadDetail(movie: movie, fromVC: self)
//            self.performSegue(withIdentifier: R.segue.moviesListController.showDetail, sender: movie)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailController, let movie = sender as? MovieViewModel {
            vc.movie = movie
        }
    }
    
    //MARK: - Actions
    
    @IBAction func orderList() {
        self.moviesList.orderType = self.moviesList.orderType == .ascending ? .descending : .ascending
        self.tableView.reloadData()
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
}
