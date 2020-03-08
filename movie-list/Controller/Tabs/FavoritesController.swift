//
//  FavoritesController.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 01/12/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import UIKit

final class FavoritesController: TabBaseController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Views
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addViews()
        self.regiterCells()
        self.applyStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    // MARK: - Lifecycle
    private func addViews() {
        self.view.addSubview(self.tableView)
        
        self.applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
    }
    
    //MARK: - Private Methods
    private func regiterCells() {
        self.tableView.register(MovieCellView.self, forCellReuseIdentifier: MovieCellView.identifier)
    }
    
    private func applyStyle() {
        self.title = R.string.common.favorites()
        self.tableView.backgroundColor = .clear
    }
    
    private func showEmptyMessage() {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = R.string.favorites.emptyState()
        messageLabel.textColor = .dsTextPrimary
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.sizeToFit()
        
        self.tableView.backgroundView = messageLabel
    }
    
    //MARK: - TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let favorites = Favorites.shared.list
        if favorites.count > 0 {
            self.tableView.backgroundView = nil
            return favorites.count
        } else {
            self.showEmptyMessage()
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieCellView.identifier, for: indexPath) as? MovieCellView {
            let movie = Favorites.shared.list[indexPath.row]
            cell.loadData(movie)
            return cell
        }
        
        return UITableViewCell()
    }
    
    //MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < Favorites.shared.list.count {
            let movie = Favorites.shared.list[indexPath.row]
            MovieDetailController.loadDetail(movie: movie, fromVC: self)
        }
    }
}
