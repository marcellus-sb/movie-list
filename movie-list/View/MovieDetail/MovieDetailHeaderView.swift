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
    
    // MARK: - Lifecycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        self.applyStyles()
        self.addViews()
    }
    
    // MARK: - Public Methods
    func loadCoverImage(url: String) {
        ImageWorker.downloadImage(url: url) { [weak self] img, imgUrl in
            guard let self = self else { return }
            if url == imgUrl {
                self.coverView.image = img
            }
        }
    }
    
    // MARK: - Layout Methods
    private func applyStyles() {
        self.backgroundColor = .clear
    }
    
    private func addViews() {
        self.addSubview(self.gradientView)
        self.gradientView.addSubview(self.coverView)
        
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
    }
}
