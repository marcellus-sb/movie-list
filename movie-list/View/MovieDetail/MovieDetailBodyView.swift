//
//  MovieDetailBodyView.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 05/03/20.
//  Copyright © 2020 Marcellus Selga Batista. All rights reserved.
//

import UIKit

class MovieDetailBodyView: UIView {
    
    // MARK: - Views
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 16.0
        return view
    }()
    
    lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        label.textColor = .dsTextSecondary
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
        label.textColor = .dsTextPrimary
        return label
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
    func setData(genres: String, description: String) {
        self.genresLabel.text = genres
        self.descriptionLabel.text = description
    }
    
    // MARK: - Layout Methods
    private func applyStyles() {
        self.backgroundColor = .clear
    }
    
    private func addViews() {
        self.addSubview(self.stackView)
        
        self.stackView.addArrangedSubview(self.genresLabel)
        self.stackView.addArrangedSubview(self.descriptionLabel)
        
        self.applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32)
        ])
        
        self.genresLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        self.descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
}
