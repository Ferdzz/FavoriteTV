//
//  SearchMovieManager.swift
//  FavoriteTV
//
//  Created by DESCHENES, Frédéric (MTL) on 2019-08-18.
//  Copyright © 2019 DESCHENES, Frédéric (MTL). All rights reserved.
//

import Foundation

class SearchMovieManager {
    private let store: SearchMovieStore
    
    init() {
        self.store = SearchMovieStore()
    }
    
    func search(query: String, completion: @escaping (MoviesModel?, Error?) -> Void) {
        // This could be upgraded to support the page index to enable paging / infinite scrolling
        self.store.search(query: query, completion: { (response, error) in
            if let response = response {
                completion(MoviesModel(moviesResponseModel: response), nil)
            } else {
                completion(nil, error)
            }
        })
    }
    
    // TODO: Favorites should be moved to their own store

    func toggleFavorite(movie: MovieModel) {
        self.store.toggleFavorite(movie: movie)
    }
    
    func isFavorite(movie: MovieModel) -> Bool {
        return self.store.isFavorite(movie: movie)
    }
    
    func getFavorites() -> [MovieModel] {
        return SearchMovieStore.favoriteMovies
    }
}
