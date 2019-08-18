//
//  DiscoverMovieModel.swift
//  FavoriteTV
//
//  Created by DESCHENES, Frédéric (MTL) on 2019-08-18.
//  Copyright © 2019 DESCHENES, Frédéric (MTL). All rights reserved.
//

import Foundation

class DiscoverMovieModel {
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

    init(discoverMovieResponseModel: DiscoverMovieResponseModel) {
        self.voteCount = discoverMovieResponseModel.vote_count
        self.id = discoverMovieResponseModel.id
        self.video = discoverMovieResponseModel.video
        self.voteAverage = discoverMovieResponseModel.vote_average
        self.title = discoverMovieResponseModel.title
        self.popularity = discoverMovieResponseModel.popularity
        self.posterPath = discoverMovieResponseModel.poster_path
        self.originalLanguage = discoverMovieResponseModel.original_language
        self.originalTitle = discoverMovieResponseModel.original_title
        self.backdropPath = discoverMovieResponseModel.backdrop_path
        self.adult = discoverMovieResponseModel.adult
        self.overview = discoverMovieResponseModel.overview
        self.releaseDate = discoverMovieResponseModel.release_date
    }
}
