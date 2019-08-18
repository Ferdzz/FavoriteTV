//
//  MovieDetailsViewController.swift
//  FavoriteTV
//
//  Created by DESCHENES, Frédéric (MTL) on 2019-08-18.
//  Copyright © 2019 DESCHENES, Frédéric (MTL). All rights reserved.
//

import UIKit
import SDWebImage

struct MovieDetailsViewControllerViewModel {
    
    let imageUrl: String
    let title: String
    let description: String
    
    init(movieModel: MovieModel) {
        self.imageUrl = "\(Constants.tmdbImageRoot)\(movieModel.backdropPath ?? "")"
        self.title = movieModel.title ?? ""
        self.description = movieModel.overview ?? ""
    }
}

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    var favoriteBarButtonItem: UIBarButtonItem?
    
    /// Required
    var movieModel: MovieModel?
    
    let searchMovieManager = SearchMovieManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupData()
        
        // Setup the favorite button
        self.favoriteBarButtonItem = UIBarButtonItem(image: self.getFavoriteIcon(), style: .plain, target: self, action: #selector(self.favorite))
        self.navigationItem.rightBarButtonItem = self.favoriteBarButtonItem
    }
    
    private func setupData() {
        guard let movieModel = self.movieModel else {
            self.dismiss(animated: true, completion: nil) // Didn't have a movie, close the VC
            return
        }
        let viewModel = MovieDetailsViewControllerViewModel(movieModel: movieModel)
        self.title = viewModel.title
        self.imageView.sd_setImage(with: URL(string: viewModel.imageUrl), completed: nil)
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
    }
    
    private func getFavoriteIcon() -> UIImage? {
        guard let movieModel = self.movieModel else {
            preconditionFailure("Attempted to get the favorite icon but movie is nil")
        }
        
        return self.searchMovieManager.isFavorite(movie: movieModel) ? R.image.icnFavoriteSelected() : R.image.icnFavorite()
    }
    
    // MARK: - Actions
    
    @objc private func favorite() {
        guard let movieModel = self.movieModel else {
            preconditionFailure("Attempted to favorite a movie but movie is nil")
        }

        self.searchMovieManager.toggleFavorite(movie: movieModel)
        self.favoriteBarButtonItem?.image = self.getFavoriteIcon()
    }
}
