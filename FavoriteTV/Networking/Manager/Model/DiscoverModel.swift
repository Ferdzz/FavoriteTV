//
//  DiscoverModel.swift
//  FavoriteTV
//
//  Created by DESCHENES, Frédéric (MTL) on 2019-08-18.
//  Copyright © 2019 DESCHENES, Frédéric (MTL). All rights reserved.
//

import Foundation

class DiscoverModel {
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var results: [DiscoverMovieModel]?
    
    init(discoverResponseModel: DiscoverResponseModel) {
        self.page = discoverResponseModel.page
        self.totalResults = discoverResponseModel.total_results
        self.totalPages = discoverResponseModel.total_pages
        self.results = discoverResponseModel.results?.map { DiscoverMovieModel(discoverMovieResponseModel: $0) }
    }
}
