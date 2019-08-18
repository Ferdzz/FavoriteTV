//
//  DiscoverViewController.swift
//  FavoriteTV
//
//  Created by DESCHENES, Frédéric (MTL) on 2019-08-18.
//  Copyright © 2019 DESCHENES, Frédéric (MTL). All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var discoverManager = DiscoverManager()
    
    private var model: DiscoverModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register nibs
        self.collectionView.register(R.nib.discoverMovieCollectionViewCell)
        
        // Setup collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
        // Start request
        self.fetchData()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        // Refresh the CollectionView after transition
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Networking
    
    private func fetchData() {
        self.discoverManager.discover { (model, error) in
            if let error = error {
                // This error handling could be improved by having an embedded error display instead of an UIAlertController
                // It would also be an opportunity to add a Retry button
                self.present(UIAlertController(title: R.string.localizable.error(),
                                               message: error.localizedDescription,
                                               preferredStyle: .alert),
                             animated: true,
                             completion: nil)
            } else if let model = model {
                self.model = model
                self.collectionView.reloadData()
            }
        }
    }
}

extension DiscoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.discoverMovieCollectionViewCell, for: indexPath) else {
            preconditionFailure("Attempted to dequeue cell of unknown type")
        }
        guard let model = self.model?.results?[indexPath.row] else {
            preconditionFailure("Attempted to dequeue invalid row")
        }
        cell.configure(viewModel: DiscoverMovieCollectionViewCellViewModel(discoverMovieModel: model))
        return cell
    }
}

extension DiscoverViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            preconditionFailure("Supports only FlowLayout")
        }
        // Fit 2 cells when regular, fit 1 when compact
        let cellsToFit: CGFloat = collectionView.traitCollection.horizontalSizeClass == .compact ? 1 : 2
        let cellSize =
            (collectionView.frame.width / cellsToFit) // Width divided by cells
            - (collectionView.contentInset.left - collectionView.contentInset.right) // Minus left and right offset
            - (flowLayout.minimumInteritemSpacing * (cellsToFit - 1)) // Minus the spacing between cells
        return CGSize(width: cellSize, height: 278)
    }
}
