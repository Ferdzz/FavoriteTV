//
//  DiscoverMovieResponseModel.swift
//  FavoriteTV
//
//  Created by DESCHENES, Frédéric (MTL) on 2019-08-18.
//  Copyright © 2019 DESCHENES, Frédéric (MTL). All rights reserved.
//

import Foundation
import ObjectMapper

class DiscoverMovieResponseModel: Mappable {
    var vote_count: Int?
    var id: Int?
    var video: Bool?
    var vote_average: Double?
    var title: String?
    var popularity: Double?
    var poster_path: String?
    var original_language: String?
    var original_title: String?
    var backdrop_path: String?
    var adult: Bool?
    var overview: String?
    var release_date: String?
    
    required init?(map: Map) {
        // Nothing to do
    }
    
    func mapping(map: Map) {
        self.vote_count <- map["vote_count"]
        self.id <- map["id"]
        self.video <- map["video"]
        self.vote_average <- map["vote_average"]
        self.title <- map["title"]
        self.popularity <- map["popularity"]
        self.poster_path <- map["poster_path"]
        self.original_language <- map["original_language"]
        self.original_title <- map["original_title"]
        self.backdrop_path <- map["backdrop_path"]
        self.adult <- map["adult"]
        self.overview <- map["overview"]
        self.release_date <- map["release_date"]
    }
}
