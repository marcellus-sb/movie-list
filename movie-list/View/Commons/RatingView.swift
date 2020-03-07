//
//  RatingView.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 07/03/20.
//  Copyright © 2020 Marcellus Selga Batista. All rights reserved.
//

import UIKit

class RatingView: UIView {
    
    // MARK: - Views
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 6
        return view
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
        label.font = self.font
        return label
    }()
    
    // MARK: - Properties
    private let imgSize: CGFloat
    private let font: UIFont
    
    // MARK: - Lifecycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(imgSize: CGFloat, font: UIFont) {
        self.imgSize = imgSize
        self.font = font
        
        super.init(frame: .zero)
        
        self.applyStyles()
        self.addViews()
    }
    
    // MARK: - Public Methods
    func setRating(rating: Double, voteCount: Int) {
        self.ratingLabel.text = "\(rating) (\(voteCount))"
    }
    
    // MARK: - Layout Methods
    private func applyStyles() {
        self.backgroundColor = .clear
    }
    
    private func addViews() {
        self.addSubview(self.stackView)
        
        self.stackView.addArrangedSubview(self.ratingImageView)
        self.stackView.addArrangedSubview(self.ratingLabel)
        
        self.applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.ratingImageView.heightAnchor.constraint(equalToConstant: self.imgSize),
            self.ratingImageView.widthAnchor.constraint(equalToConstant: self.imgSize)
        ])
    }
}
