//
//  MovieDetailBackgroundView.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 06/03/20.
//  Copyright © 2020 Marcellus Selga Batista. All rights reserved.
//

import UIKit

class MovieDetailBackgroundView: UIView {
    
    // MARK: - Views
    
    lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var effectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
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
    func loadImage(url: String) {
        ImageWorker.downloadImage(url: url) { [weak self] img, imgUrl in
            guard let self = self else { return }
            if url == imgUrl {
                self.backgroundImage.image = img
            }
        }
    }
    
    // MARK: - Layout Methods
    private func applyStyles() {
        self.backgroundColor = .clear
    }
    
    private func addViews() {
        self.addSubview(self.backgroundImage)
        self.addSubview(self.effectView)
        
        self.applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            self.backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            self.effectView.topAnchor.constraint(equalTo: self.topAnchor),
            self.effectView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.effectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.effectView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
