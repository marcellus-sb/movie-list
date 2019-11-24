//
//  MovieLoadingCell.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 23/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import UIKit

class MovieLoadingCell: UITableViewCell {
    
    //MARK: - Private
    
    private var animationRunning = false
    
    //MARK: - Outlets
    
    @IBOutlet weak var placeholder1: UIView!
    @IBOutlet weak var placeholder2: UIView!
    @IBOutlet weak var placeholder3: UIView!
    @IBOutlet weak var placeholder4: UIView!
    @IBOutlet weak var placeholder5: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyStyle()
    }
    
    private func applyStyle() {
        self.backgroundColor = .clear
        self.placeholder1.backgroundColor = .dsDisable
        self.placeholder2.backgroundColor = .dsDisable
        self.placeholder3.backgroundColor = .dsDisable
        self.placeholder4.backgroundColor = .dsDisable
        self.placeholder5.backgroundColor = .dsDisable
        
        self.placeholder1.layer.cornerRadius = 6.0
    }
    
    func startAnimation() {
        if !self.animationRunning {
            self.animationRunning = true
            self.animateView(placeholder1)
            self.animateView(placeholder2)
            self.animateView(placeholder3)
            self.animateView(placeholder4)
            self.animateView(placeholder5)
        }
    }
    
    private func animateView(_ view: UIView) {
        let newAlpha: CGFloat = view.alpha == 1 ? 0.1 : 1
        UIView.animate(withDuration: 0.9, delay: 0, options: [.allowUserInteraction], animations: {
            view.alpha = newAlpha
        }, completion: { [weak self] _ in
            self?.animateView(view)
        })
    }
}
