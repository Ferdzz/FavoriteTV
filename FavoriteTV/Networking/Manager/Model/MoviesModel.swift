//
//  MoviesModel.swift
//  FavoriteTV
//
//  Created by DESCHENES, Frédéric (MTL) on 2019-08-18.
//  Copyright © 2019 DESCHENES, Frédéric (MTL). All rights reserved.
//

import Foundation

class MoviesModel {
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var results: [MovieModel]?
    
    init(moviesResponseModel: MoviesResponseModel) {
        self.page = moviesResponseModel.page
        self.totalResults = moviesResponseModel.total_results
        self.totalPages = moviesResponseModel.total_pages
        self.results = moviesResponseModel.results?.map { MovieModel(movieResponseModel: $0) }
    }
}
