//
//  FavoritesController.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 01/12/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import UIKit

final class FavoritesController: TabBaseController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    //MARK: - Private Methods
    
    private func applyStyle() {
        self.tableView.backgroundColor = .clear
    }
    
    private func showEmptyMessage() {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = "Você ainda não tem favoritos"
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieCell, for: indexPath) {
            let movie = Favorites.shared.list[indexPath.row]
            cell.setData(movie)
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
            self.performSegue(withIdentifier: R.segue.favoritesController.showDetail, sender: movie)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailController, let movie = sender as? MovieViewModel {
            vc.movie = movie
        }
    }
}
