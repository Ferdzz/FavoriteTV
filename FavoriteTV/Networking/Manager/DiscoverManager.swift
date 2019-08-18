//
//  DiscoverManager.swift
//  FavoriteTV
//
//  Created by DESCHENES, Frédéric (MTL) on 2019-08-18.
//  Copyright © 2019 DESCHENES, Frédéric (MTL). All rights reserved.
//

import Foundation

class DiscoverManager {
    
    private let store: DiscoverStore
    
    init() {
        self.store = DiscoverStore()
    }
    
    func discover(completion: @escaping (DiscoverModel?, Error?) -> Void) {
        // This could be upgraded to support the page index to enable paging / infinite scrolling
        self.store.discover { (response, error) in
            if let response = response {
                completion(DiscoverModel(discoverResponseModel: response), nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
