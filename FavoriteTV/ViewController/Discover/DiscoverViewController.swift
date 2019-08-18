//
//  DiscoverViewController.swift
//  FavoriteTV
//
//  Created by DESCHENES, Frédéric (MTL) on 2019-08-18.
//  Copyright © 2019 DESCHENES, Frédéric (MTL). All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register nibs
        self.collectionView.register(R.nib.discoverMovieCollectionViewCell)
        
        // Setup delegates
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
}

extension DiscoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.discoverMovieCollectionViewCell, for: indexPath) else {
            preconditionFailure("Attempted to dequeue cell of unknown type")
        }
        return cell
    }
}

extension DiscoverViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 400)
    }
}
