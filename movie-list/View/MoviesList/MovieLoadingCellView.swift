//
//  MovieLoadingCellView.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 01/03/20.
//  Copyright © 2020 Marcellus Selga Batista. All rights reserved.
//

import UIKit

class MovieLoadingCellView: UITableViewCell {
    // MARK: - Constants
    static let identifier: String = "movieLoadingCell"
    
    // MARK: - Views
    lazy var coverPlaceholderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6.0
        view.clipsToBounds = true
        view.backgroundColor = .dsDisable
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var titlePlaceholderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dsDisable
        return view
    }()
    
    lazy var genrePlaceholderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dsDisable
        return view
    }()
    
    lazy var overviewPlaceholderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dsDisable
        return view
    }()
    
    lazy var ratingPlaceholderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dsDisable
        return view
    }()
    
    //MARK: - Attributes
    private var animationRunning = false
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.applyStyles()
        self.addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func startAnimation() {
        if !self.animationRunning {
            self.animationRunning = true
            self.animateView(self.coverPlaceholderView)
            self.animateView(self.titlePlaceholderView)
            self.animateView(self.genrePlaceholderView)
            self.animateView(self.overviewPlaceholderView)
            self.animateView(self.ratingPlaceholderView)
        }
    }
    
    // MARK: - Animation
    private func animateView(_ view: UIView) {
        let newAlpha: CGFloat = view.alpha == 1 ? 0.1 : 1
        UIView.animate(withDuration: 0.9, delay: 0, options: [.allowUserInteraction], animations: {
            view.alpha = newAlpha
        }, completion: { [weak self] _ in
            self?.animateView(view)
        })
    }
    
    // MARK: - Layout Methods
    private func applyStyles() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    private func addViews() {
        self.addSubview(self.coverPlaceholderView)
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.titlePlaceholderView)
        self.containerView.addSubview(self.genrePlaceholderView)
        self.containerView.addSubview(self.overviewPlaceholderView)
        self.containerView.addSubview(self.ratingPlaceholderView)
        
        self.applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            self.coverPlaceholderView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.coverPlaceholderView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.coverPlaceholderView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            self.coverPlaceholderView.heightAnchor.constraint(equalToConstant: 139),
            self.coverPlaceholderView.widthAnchor.constraint(equalToConstant: 92.5)
        ])
        
        NSLayoutConstraint.activate([
            self.containerView.leadingAnchor.constraint(equalTo: self.coverPlaceholderView.trailingAnchor, constant: 16),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            self.titlePlaceholderView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.titlePlaceholderView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            self.titlePlaceholderView.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            self.titlePlaceholderView.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        NSLayoutConstraint.activate([
            self.genrePlaceholderView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.genrePlaceholderView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -16),
            self.genrePlaceholderView.topAnchor.constraint(equalTo: self.titlePlaceholderView.bottomAnchor, constant: 8),
            self.genrePlaceholderView.heightAnchor.constraint(equalToConstant: 14)
        ])
        
        NSLayoutConstraint.activate([
            self.overviewPlaceholderView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.overviewPlaceholderView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -32),
            self.overviewPlaceholderView.topAnchor.constraint(equalTo: self.genrePlaceholderView.bottomAnchor, constant: 4),
            self.overviewPlaceholderView.heightAnchor.constraint(equalToConstant: 14)
        ])
        
        NSLayoutConstraint.activate([
            self.ratingPlaceholderView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -4),
            self.ratingPlaceholderView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.ratingPlaceholderView.heightAnchor.constraint(equalToConstant: 12),
            self.ratingPlaceholderView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
