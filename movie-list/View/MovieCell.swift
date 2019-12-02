//
//  MovieCell.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 20/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    private var movieVM: MovieViewModel?
    
    //MARK: - Outlets
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyStyle()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coverImageView.image = nil
    }
    
    private func applyStyle() {
        self.backgroundColor = .clear
        self.titleLabel.textColor = .dsTextPrimary
        self.genresLabel.textColor = .dsTextPrimary
        self.overviewLabel.textColor = .dsTextSecondary
        self.releaseDateLabel.textColor = .dsTextPrimary
        self.ratingLabel.textColor = .dsHighlight
        self.ratingImageView.tintColor = .dsHighlight
        
        self.coverImageView.layer.cornerRadius = 6.0
    }
    
    func setData(_ movieVM: MovieViewModel) {
        self.movieVM = movieVM
        self.titleLabel.text = movieVM.title
        self.genresLabel.text = movieVM.genresText
        self.overviewLabel.text = movieVM.overview
        self.releaseDateLabel.text = movieVM.releaseDateText
        self.ratingLabel.text = "\(movieVM.voteAverage) (\(movieVM.voteCount))"
        self.ratingImageView.image = R.image.star()?.withRenderingMode(.alwaysTemplate)
        
        ImageWorker.downloadImage(url: movieVM.posterPath) { [weak self] img, url in
            guard let self = self else { return }
            if self.movieVM?.posterPath == url {
                self.coverImageView.image = img
            }
        }
    }
}
