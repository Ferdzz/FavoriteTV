//
//  MovieModel.swift
//  FavoriteTV
//
//  Created by DESCHENES, Frédéric (MTL) on 2019-08-18.
//  Copyright © 2019 DESCHENES, Frédéric (MTL). All rights reserved.
//

import Foundation

class MovieModel {
    var voteCount: Int?
    var id: Int?
    var video: Bool?
    var voteAverage: Double?
    var title: String?
    var popularity: Double?
    var posterPath: String?
    var originalLanguage: String?
    var originalTitle: String?
    var backdropPath: String?
    var adult: Bool?
    var overview: String?
    var releaseDate: String?

    init(movieResponseModel: MovieResponseModel) {
        self.voteCount = movieResponseModel.vote_count
        self.id = movieResponseModel.id
        self.video = movieResponseModel.video
        self.voteAverage = movieResponseModel.vote_average
        self.title = movieResponseModel.title
        self.popularity = movieResponseModel.popularity
        self.posterPath = movieResponseModel.poster_path
        self.originalLanguage = movieResponseModel.original_language
        self.originalTitle = movieResponseModel.original_title
        self.backdropPath = movieResponseModel.backdrop_path
        self.adult = movieResponseModel.adult
        self.overview = movieResponseModel.overview
        self.releaseDate = movieResponseModel.release_date
    }
}
