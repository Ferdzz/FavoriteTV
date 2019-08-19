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
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var favoritesBarButtonItem: UIBarButtonItem!
    
    private var discoverManager = DiscoverManager()
    
    private var model: MoviesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = R.string.localizable.discoverTitle()
        
        // Register nibs
        self.collectionView.register(R.nib.discoverMovieCollectionViewCell)
        
        // Setup collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
        // Setup favorite button
        self.favoritesBarButtonItem.title = R.string.localizable.favorites()

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
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.discoverManager.discover { (model, error) in
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
            if let error = error {
                // This error handling could be improved by having an embedded error display instead of an UIAlertController
                // It would also be an opportunity to add a Retry button
                let alertController = UIAlertController(title: R.string.localizable.error(),
                                                        message: error.localizedDescription,
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: R.string.localizable.ok(), style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            self.model = model
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func onFavoritesTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: R.segue.discoverViewController.showFavorites, sender: nil)
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
        cell.configure(viewModel: DiscoverMovieCollectionViewCellViewModel(movieModel: model))
        return cell
    }
}

extension DiscoverViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            preconditionFailure("This implementation only supports FlowLayout")
        }
        // This could be improved by caching the size of the cells for a certain sizeclass after the first calculation
        // Fit 2 cells when regular, fit 1 when compact
        let cellsToFit: CGFloat = collectionView.traitCollection.horizontalSizeClass == .compact ? 1 : 2
        let cellSize =
            (collectionView.frame.width / cellsToFit) // Width divided by cells
            - (collectionView.contentInset.left - collectionView.contentInset.right) // Minus left and right offset
            - (flowLayout.minimumInteritemSpacing * (cellsToFit - 1)) // Minus the spacing between cells
        return CGSize(width: cellSize, height: 278)
    }
}
