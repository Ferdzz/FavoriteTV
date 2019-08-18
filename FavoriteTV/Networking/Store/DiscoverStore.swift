//
//  DiscoverStore.swift
//  FavoriteTV
//
//  Created by DESCHENES, Frédéric (MTL) on 2019-08-18.
//  Copyright © 2019 DESCHENES, Frédéric (MTL). All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class DiscoverStore {
    
    /// Calls tmdb discover API https://developers.themoviedb.org/3/discover/movie-discover
    ///
    /// The async callback contains the DiscoverResponseModel on success, or the Error model on failure
    func discover(completion: @escaping (DiscoverResponseModel?, Error?) -> Void) {
        // This networking layer could be reworked to make it so we don't have to specify the paramters
        // everytime, or have to parse the JSON manually. For now this will have to do
        let discoverUrl = "\(Constants.tmdbApiRoot)/discover/movie"
        let parameters: Parameters = ["api_key": Constants.tmdbApiKey]
        Alamofire.request(discoverUrl, method: .get, parameters: parameters)
            .responseObject { (response: DataResponse<DiscoverResponseModel>) in
                completion(response.result.value, response.result.error)
        }
    }
}
