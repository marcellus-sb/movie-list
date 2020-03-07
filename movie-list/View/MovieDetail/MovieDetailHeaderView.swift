//
//  MovieDetailHeaderView.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 05/03/20.
//  Copyright © 2020 Marcellus Selga Batista. All rights reserved.
//

import UIKit

class MovieDetailHeaderView: UIView {
    
    // MARK: - Views
    lazy var gradientView: GradientView = {
        let view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startColor = .clear
        view.endColor = .black
        return view
    }()
    
    lazy var coverView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 10, height: 10)
        view.layer.shadowRadius = 4
        return view
    }()
    
    lazy var ratingView: RatingView = {
        let view = RatingView(imgSize: 12, font: .systemFont(ofSize: 12))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var reminderStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 4
        return view
    }()
    
    lazy var reminderButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.setImage(R.image.bell()?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .dsTextDarkCross
        button.addTarget(self, action: #selector(self.reminderTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .dsTextDarkCross
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 4
        return view
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.setImage(R.image.share()?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .dsTextDarkCross
        button.addTarget(self, action: #selector(self.sharedTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.setImage(R.image.heart()?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .dsTextDarkCross
        button.addTarget(self, action: #selector(self.favoriteTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    private var actionDelegate: MovieDetailActionDelegate
    
    // MARK: - Lifecycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(actionDelegate: MovieDetailActionDelegate) {
        self.actionDelegate = actionDelegate
        super.init(frame: .zero)
        self.applyStyles()
        self.addViews()
    }
    
    // MARK: - Public Methods
    func loadData(movie: MovieViewModel, favoriteIsActive: Bool) {
        ImageWorker.downloadImage(url: movie.posterPath) { [weak self] img, imgUrl in
            guard let self = self else { return }
            if movie.posterPath == imgUrl {
                self.coverView.image = img
            }
        }
        
        self.ratingView.setRating(rating: movie.voteAverage, voteCount: movie.voteCount)
        self.reminderButton.isHidden = movie.releaseDate.timeIntervalSinceNow.sign == .minus
        self.releaseDateLabel.text = movie.releaseDateText
        self.favoriteButton.tintColor = favoriteIsActive ? .dsRed : .dsTextDarkCross
    }
    
    // MARK: - Layout Methods
    private func applyStyles() {
        self.backgroundColor = .clear
    }
    
    private func addViews() {
        self.addSubview(self.gradientView)
        self.gradientView.addSubview(self.coverView)
        self.gradientView.addSubview(self.ratingView)
        
        self.gradientView.addSubview(self.reminderStackView)
        self.reminderStackView.addArrangedSubview(self.reminderButton)
        self.reminderStackView.addArrangedSubview(self.releaseDateLabel)
        
        self.gradientView.addSubview(self.buttonsStackView)
        self.buttonsStackView.addArrangedSubview(self.shareButton)
        self.buttonsStackView.addArrangedSubview(self.favoriteButton)
        
        self.applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 360),
            self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        NSLayoutConstraint.activate([
            self.gradientView.topAnchor.constraint(equalTo: self.topAnchor),
            self.gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.coverView.topAnchor.constraint(equalTo: self.gradientView.topAnchor, constant: 65),
            self.coverView.centerXAnchor.constraint(equalTo: self.gradientView.centerXAnchor),
            self.coverView.heightAnchor.constraint(equalToConstant: 180),
            self.coverView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            self.ratingView.topAnchor.constraint(equalTo: self.coverView.bottomAnchor, constant: 20),
            self.ratingView.centerXAnchor.constraint(equalTo: self.coverView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.reminderStackView.bottomAnchor.constraint(equalTo: self.gradientView.bottomAnchor, constant: -8),
            self.reminderStackView.leadingAnchor.constraint(equalTo: self.gradientView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            self.reminderButton.heightAnchor.constraint(equalToConstant: 40),
            self.reminderButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            self.buttonsStackView.bottomAnchor.constraint(equalTo: self.gradientView.bottomAnchor, constant: -8),
            self.buttonsStackView.trailingAnchor.constraint(equalTo: self.gradientView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            self.shareButton.heightAnchor.constraint(equalToConstant: 40),
            self.shareButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            self.favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            self.favoriteButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Actions
    @objc func reminderTapped() {
        self.actionDelegate.toggleReminder()
    }
    
    @objc func sharedTapped() {
        self.actionDelegate.doShare()
    }
    
    @objc func favoriteTapped() {
        self.actionDelegate.toggleFavorite { [weak self] isActive in
            self?.favoriteButton.tintColor = isActive ? .dsRed : .dsTextDarkCross
        }
    }
}
