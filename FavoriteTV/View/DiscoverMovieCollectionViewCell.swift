//
//  DiscoverMovieCollectionViewCell.swift
//  FavoriteTV
//
//  Created by DESCHENES, Frédéric (MTL) on 2019-08-18.
//  Copyright © 2019 DESCHENES, Frédéric (MTL). All rights reserved.
//

import UIKit
import SDWebImage

struct DiscoverMovieCollectionViewCellViewModel {
    let title: String
    let subtitle: String
    let description: String
    let imageUrl: String
    
    init(discoverMovieModel: DiscoverMovieModel) {
        self.title = discoverMovieModel.title ?? ""
        self.subtitle = discoverMovieModel.releaseDate ?? ""
        self.description = discoverMovieModel.overview ?? ""
        self.imageUrl = "\(Constants.tmdbImageRoot)\(discoverMovieModel.posterPath ?? "")"
    }
}

class DiscoverMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let cornerMasks = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner)
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.layer.maskedCorners = cornerMasks
    }
    
    func configure(viewModel: DiscoverMovieCollectionViewCellViewModel) {
        self.imageView.sd_setImage(with: URL(string: viewModel.imageUrl), completed: nil)
        self.titleLabel.text = viewModel.title
        self.dateLabel.text = viewModel.subtitle
        self.descriptionLabel.text = viewModel.description
    }
}
