//
//  MovieDetail2Controller.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 05/03/20.
//  Copyright © 2020 Marcellus Selga Batista. All rights reserved.
//

import UIKit

class MovieDetail2Controller: UIViewController {
    
    //MARK: - Constants
    private var TOP_BAR_HEIGHT: CGFloat {
        return 44.0 + UIApplication.shared.statusBarFrame.height
    }
    
    private let DEFAULT_BACKGROUND_HEIGHT: CGFloat = 360
    private let ANIMATION_DURATION: Double = 0.2
    
    // MARK: - Views
    lazy var backgroundView: MovieDetailBackgroundView = {
        let view = MovieDetailBackgroundView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackScrollView: StackScrollView = {
        let view = StackScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var headerView: MovieDetailHeaderView = {
        let view = MovieDetailHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bodyView: MovieDetailBodyView = {
        let view = MovieDetailBodyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dsBGPrimary
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .dsTextDarkCross
        button.backgroundColor = UIColor.dsTextLightCross.withAlphaComponent(0.4)
        button.layer.cornerRadius = 12.5
        button.clipsToBounds = true
        button.setImage(R.image.close()?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(self.close), for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        return button
    }()
    
    //MARK: - Properties
    var movie: MovieViewModel
    
    var backgroundViewHeightConstraint: NSLayoutConstraint?
    
    
    // MARK: - Static
    static func loadDetail(movie: MovieViewModel, fromVC: UIViewController) {
        let detailVC = MovieDetail2Controller(movie: movie)
        detailVC.modalPresentationStyle = .fullScreen
        fromVC.present(detailVC, animated: true, completion: nil)
    }
    
    // MARK: - Lifecycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(movie: MovieViewModel) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addViews()
        self.setDelegates()
        self.loadData()
        self.applyStyle()
    }
    
    // MARK: - Load
    private func setDelegates() {
        self.stackScrollView.scrollView.delegate = self
    }
    
    private func loadData() {
        self.headerView.loadCoverImage(url: self.movie.posterPath)
        self.bodyView.setData(genres: self.movie.genresText, description: self.movie.overview)
        self.backgroundView.loadImage(url: self.movie.backdropPath)
        
//        
//        self.topBarTitleLabel.text = movieLoaded.title
//        self.highlightReleaseDateLabel.text = movieLoaded.releaseDateText
//        self.highlightRatingLabel.text = "\(movieLoaded.voteAverage) (\(movieLoaded.voteCount))"
//        self.detailGenresLabel.text = movieLoaded.genresText
//        self.detailDescriptionLabel.text = movieLoaded.overview
//        
//        self.closeButton.setImage(R.image.close()?.withRenderingMode(.alwaysTemplate), for: .normal)
//        self.shareButton.setImage(R.image.share()?.withRenderingMode(.alwaysTemplate), for: .normal)
//        self.favoriteButton.setImage(R.image.heart()?.withRenderingMode(.alwaysTemplate), for: .normal)
//        self.reminderButton.setImage(R.image.bell()?.withRenderingMode(.alwaysTemplate), for: .normal)
//        self.highlightRatingImageView.image = R.image.star()?.withRenderingMode(.alwaysTemplate)
//        
//        self.reminderButton.isHidden = movieLoaded.releaseDate < Date()
    }
    
    // MARK: - Layout
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func applyStyle() {
        self.view.backgroundColor = .dsBGPrimary
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    private func addViews() {
        self.view.addSubview(self.backgroundView)
        self.view.addSubview(self.stackScrollView)
        self.view.addSubview(self.closeButton)
        
        self.stackScrollView.addArrangedViews([
            self.headerView,
            self.bodyView
        ])
        
        self.applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            self.backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        self.backgroundViewHeightConstraint = self.backgroundView.heightAnchor.constraint(equalToConstant: 360)
        self.backgroundViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            self.stackScrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.stackScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.stackScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.stackScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.closeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.closeButton.heightAnchor.constraint(equalToConstant: 25),
            self.closeButton.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        if #available(iOS 11.0, *) {
            self.closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        } else {
            self.closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        }
    }
    
    //MARK: - Actions
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MovieDetail2Controller: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY <= 0 {
            if offsetY < -110 {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.backgroundViewHeightConstraint?.constant = DEFAULT_BACKGROUND_HEIGHT + (-offsetY)
            }
        } else {
            self.showTopBar(offsetY > 90)
            let bgHeight = DEFAULT_BACKGROUND_HEIGHT - offsetY
            self.backgroundViewHeightConstraint?.constant = bgHeight > 0 ? bgHeight : 0
        }
    }
    
    private func showTopBar(_ value: Bool) {
//        if value && self.topBarView.isHidden {
//            self.topBarTopConstraint.constant = 0
//            self.topBarView.isHidden = false
//            self.view.setNeedsLayout()
//            UIView.animate(withDuration: ANIMATION_DURATION) { [weak self] in
//                self?.view.layoutIfNeeded()
//            }
//        } else if !value && !self.topBarView.isHidden {
//            self.topBarTopConstraint.constant = -self.TOP_BAR_HEIGHT
//            self.view.setNeedsLayout()
//
//            UIView.animate(withDuration: ANIMATION_DURATION, delay: 0, options: .curveEaseOut, animations: { [weak self] in
//                self?.view.layoutIfNeeded()
//            }, completion: { [weak self] finished in
//                DispatchQueue.main.asyncAfter(deadline: .now() + (self?.ANIMATION_DURATION ?? 0)) { [weak self] in
//                    self?.topBarView.isHidden = true
//                }
//            })
//        }
        
    }
}
