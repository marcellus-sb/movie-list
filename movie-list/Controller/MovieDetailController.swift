//
//  MovieDetailController.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 20/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import UIKit

class MovieDetailController: UIViewController {
    
    //MARK: - Constants
    
    private var TOP_BAR_HEIGHT: CGFloat {
        return 44.0 + UIApplication.shared.statusBarFrame.height
    }
    private let DEFAULT_BACKGROUND_HEIGHT: CGFloat = 360
    private let ANIMATION_DURATION: Double = 0.2
    
    //MARK: - Public
    
    var movie: MovieViewModel?
    var genresList: GenresListViewModel?
    
    //MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var topBarView: UIVisualEffectView!
    @IBOutlet weak var topBarTitleLabel: UILabel!
    @IBOutlet weak var topBarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var backgroundImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var highlightCoverImage: UIImageView!
    @IBOutlet weak var highlightReleaseDateLabel: UILabel!
    @IBOutlet weak var highlightRatingImageView: UIImageView!
    @IBOutlet weak var highlightRatingLabel: UILabel!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailGenresLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var reminderButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegates()
        self.applyStyle()
        self.loadData()
    }
    
    private func setDelegates() {
        self.scrollView.delegate = self
    }
    
    private func applyStyle() {
        self.view.backgroundColor = .dsBGPrimary
        self.detailView.backgroundColor = .dsBGPrimary
        self.highlightRatingLabel.textColor = .dsHighlight
        self.highlightRatingImageView.tintColor = .dsHighlight
        self.highlightReleaseDateLabel.textColor = .dsTextDarkCross
        self.topBarTitleLabel.textColor = .dsTextDarkCross
        self.shareButton.tintColor = .dsTextDarkCross
        self.favoriteButton.tintColor = .dsTextDarkCross
        self.reminderButton.tintColor = .dsTextDarkCross
        
        self.highlightCoverImage.clipsToBounds = false
        self.highlightCoverImage.layer.shadowColor = UIColor.black.cgColor
        self.highlightCoverImage.layer.shadowOpacity = 0.5
        self.highlightCoverImage.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.highlightCoverImage.layer.shadowRadius = 4
        self.highlightCoverImage.layer.shadowPath = UIBezierPath(roundedRect: self.highlightCoverImage.bounds, cornerRadius: 1).cgPath
        
        self.detailGenresLabel.textColor = .dsTextSecondary
        self.detailDescriptionLabel.textColor = .dsTextPrimary
        
        self.closeButton.tintColor = .dsTextDarkCross
        self.closeButton.backgroundColor = UIColor.dsTextLightCross.withAlphaComponent(0.4)
        self.closeButton.layer.cornerRadius = 12.5
        self.closeButton.clipsToBounds = true
        
        self.topBarHeightConstraint.constant = TOP_BAR_HEIGHT
    }
    
    private func loadData() {
        guard let movieLoaded = movie else { return }
        
        ImageWorker.downloadImage(url: movieLoaded.posterPath) { [weak self] img, url in
            guard let self = self else { return }
            if self.movie?.posterPath == url {
                self.highlightCoverImage.image = img
            }
        }
        
        ImageWorker.downloadImage(url: movieLoaded.backdropPath) { [weak self] img, url in
            guard let self = self else { return }
            if self.movie?.backdropPath == url {
                self.backgroundImage.image = img
            }
        }
        
        self.topBarTitleLabel.text = movieLoaded.title
        self.highlightReleaseDateLabel.text = movieLoaded.releaseDate
        self.highlightRatingLabel.text = "\(movieLoaded.voteAverage) (\(movieLoaded.voteCount))"
        self.detailGenresLabel.text = self.genresList?.getGenresLabelFrom(movie: movieLoaded)
        self.detailDescriptionLabel.text = movieLoaded.overview
        
        self.closeButton.setImage(R.image.close()?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.shareButton.setImage(R.image.share()?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.favoriteButton.setImage(R.image.heart()?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.reminderButton.setImage(R.image.bell()?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.highlightRatingImageView.image = R.image.star()?.withRenderingMode(.alwaysTemplate)
        
    }
    
    //MARK: - Actions
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func share() {
        //TODO: share action
        let alert = UIAlertController(title: "TOOD", message: "Share is not ready yet.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func reminder() {
        //TODO: reminder action
        let alert = UIAlertController(title: "TOOD", message: "Reminder is not ready yet.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func toggleFavorite() {
        //TODO: favorite action
        let alert = UIAlertController(title: "TOOD", message: "Favorite is not ready yet.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MovieDetailController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY <= 0 {
            if offsetY < -110 {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.backgroundImageHeightConstraint.constant = DEFAULT_BACKGROUND_HEIGHT + (-offsetY)
            }
        } else {
            self.showTopBar(offsetY > 90)
            let bgHeight = DEFAULT_BACKGROUND_HEIGHT - offsetY
            self.backgroundImageHeightConstraint.constant = bgHeight > 0 ? bgHeight : 0
        }
    }
    
    private func showTopBar(_ value: Bool) {
        if value && self.topBarView.isHidden {
            self.topBarTopConstraint.constant = 0
            self.topBarView.isHidden = false
            self.view.setNeedsLayout()
            UIView.animate(withDuration: ANIMATION_DURATION) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        } else if !value && !self.topBarView.isHidden {
            self.topBarTopConstraint.constant = -self.TOP_BAR_HEIGHT
            self.view.setNeedsLayout()
            
            UIView.animate(withDuration: ANIMATION_DURATION, delay: 0, options: .curveEaseOut, animations: { [weak self] in
                self?.view.layoutIfNeeded()
            }, completion: { [weak self] finished in
                DispatchQueue.main.asyncAfter(deadline: .now() + (self?.ANIMATION_DURATION ?? 0)) { [weak self] in
                    self?.topBarView.isHidden = true
                }
            })
        }
        
    }
}
