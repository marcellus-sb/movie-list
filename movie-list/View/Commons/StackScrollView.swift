//
//  StackScrollView.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 05/03/20.
//  Copyright © 2020 Marcellus Selga Batista. All rights reserved.
//

import UIKit

class StackScrollView: UIView {
    
    // MARK: - Views
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        } else {
            view.contentInset = .zero
        }
        
        return view
    }()
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
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
    func addArrangedViews(_ views: [UIView]) {
        for view in views {
            self.stackView.addArrangedSubview(view)
        }
    }
    
    // MARK: - Layout Methods
    private func applyStyles() {
        self.backgroundColor = .clear
    }
    
    private func addViews() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.mainView)
        self.mainView.addSubview(self.stackView)
        
        self.applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.mainView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.mainView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.mainView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.mainView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor)
        ])
        
        let heightConstraint = self.mainView.heightAnchor.constraint(equalTo: self.heightAnchor)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.mainView.topAnchor),
            self.stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.mainView.bottomAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor)
        ])
    }
}
