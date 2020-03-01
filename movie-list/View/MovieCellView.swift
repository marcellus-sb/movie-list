//
//  MovieCellView.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 29/02/20.
//  Copyright © 2020 Marcellus Selga Batista. All rights reserved.
//

import UIKit

class MovieCellView: UITableViewCell {
    // MARK: - Constants
    static let identifier: String = "movieCell"
    
    // MARK: - Properties
    private var movieVM: MovieViewModel?
    
    // MARK: - Views
    lazy var coverImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6.0
        view.clipsToBounds = true
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .dsTextPrimary
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .dsTextPrimary
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .dsTextSecondary
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var ratingImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = R.image.star()?.withRenderingMode(.alwaysTemplate)
        view.contentMode = .scaleAspectFit
        view.tintColor = .dsHighlight
        return view
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .dsHighlight
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .dsTextPrimary
        label.font = .systemFont(ofSize: 11)
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.applyStyles()
        self.addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coverImageView.image = nil
    }
    
    // MARK: - Public Methods
    func setData(_ movieVM: MovieViewModel) {
        self.movieVM = movieVM
        self.titleLabel.text = movieVM.title
        self.genresLabel.text = movieVM.genresText
        self.overviewLabel.text = movieVM.overview
        self.releaseDateLabel.text = movieVM.releaseDateText
        self.ratingLabel.text = "\(movieVM.voteAverage) (\(movieVM.voteCount))"
        
        ImageWorker.downloadImage(url: movieVM.posterPath) { [weak self] img, url in
            guard let self = self else { return }
            if self.movieVM?.posterPath == url {
                self.coverImageView.image = img
            }
        }
    }
    
    // MARK: - Layout Methods
    private func applyStyles() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    private func addViews() {
        self.addSubview(self.coverImageView)
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.genresLabel)
        self.containerView.addSubview(self.overviewLabel)
        self.containerView.addSubview(self.ratingImageView)
        self.containerView.addSubview(self.ratingLabel)
        self.containerView.addSubview(self.releaseDateLabel)
        
        self.applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            self.coverImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.coverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            self.coverImageView.heightAnchor.constraint(equalToConstant: 139),
            self.coverImageView.widthAnchor.constraint(equalToConstant: 92.5)
        ])
        
        NSLayoutConstraint.activate([
            self.containerView.leadingAnchor.constraint(equalTo: self.coverImageView.trailingAnchor, constant: 16),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.genresLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.genresLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            self.genresLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            self.overviewLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.overviewLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            self.overviewLabel.topAnchor.constraint(equalTo: self.genresLabel.bottomAnchor, constant: 4)
        ])
        
        NSLayoutConstraint.activate([
            self.ratingImageView.topAnchor.constraint(greaterThanOrEqualTo: self.overviewLabel.bottomAnchor, constant: 8),
            self.ratingImageView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -4),
            self.ratingImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.ratingImageView.heightAnchor.constraint(equalToConstant: 10),
            self.ratingImageView.widthAnchor.constraint(equalToConstant: 10)
        ])

        NSLayoutConstraint.activate([
            self.ratingLabel.leadingAnchor.constraint(equalTo: self.ratingImageView.trailingAnchor, constant: 4),
            self.ratingLabel.centerYAnchor.constraint(equalTo: self.ratingImageView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            self.releaseDateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.ratingLabel.trailingAnchor, constant: 6),
            self.releaseDateLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            self.releaseDateLabel.centerYAnchor.constraint(equalTo: self.ratingLabel.centerYAnchor)
        ])
    }
}
