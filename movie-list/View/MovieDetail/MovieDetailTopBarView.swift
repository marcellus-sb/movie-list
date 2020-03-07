//
//  MovieDetailTopBarView.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 06/03/20.
//  Copyright © 2020 Marcellus Selga Batista. All rights reserved.
//

import UIKit

class MovieDetailTopBarView: UIView {
    
    // MARK: - Views
    
    lazy var effectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .dsTextDarkCross
        return label
    }()
    
    // MARK: - Lifecycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        self.addViews()
    }
    
    // MARK: - Layout Methods
    private func addViews() {
        self.addSubview(self.effectView)
        self.effectView.contentView.addSubview(self.titleLabel)
        
        self.applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 360),
            self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        NSLayoutConstraint.activate([
            self.effectView.topAnchor.constraint(equalTo: self.topAnchor),
            self.effectView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.effectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.effectView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.titleLabel.bottomAnchor.constraint(equalTo: self.effectView.contentView.bottomAnchor, constant: -13),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.effectView.contentView.leadingAnchor, constant: 50),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.effectView.contentView.trailingAnchor, constant: -50)
        ])
    }
}
