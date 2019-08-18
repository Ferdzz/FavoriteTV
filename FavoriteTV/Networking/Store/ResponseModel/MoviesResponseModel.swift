//
//  MoviesResponseModel.swift
//  FavoriteTV
//
//  Created by DESCHENES, Frédéric (MTL) on 2019-08-18.
//  Copyright © 2019 DESCHENES, Frédéric (MTL). All rights reserved.
//

import Foundation
import ObjectMapper

class MoviesResponseModel: Mappable {
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
    var results: [MovieResponseModel]?
    
    required init?(map: Map) {
        // Nothing to do
    }
    
    func mapping(map: Map) {
        self.page <- map["page"]
        self.total_results <- map["total_results"]
        self.total_pages <- map["total_pages"]
        self.results <- map["results"]
    }
}
