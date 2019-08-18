//
//  SearchViewController.swift
//  FavoriteTV
//
//  Created by DESCHENES, Frédéric (MTL) on 2019-08-18.
//  Copyright © 2019 DESCHENES, Frédéric (MTL). All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private var searchMovieManager = SearchMovieManager()

    var model: MoviesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.definesPresentationContext = true
        self.title = R.string.localizable.searchTitle()
    
        // Setup tableview
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        // Setup search controller
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        self.activityIndicator.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let typedInfo = R.segue.searchViewController.showMovieDetails(segue: segue),
            let movie = sender as? MovieModel {
            typedInfo.destination.movieModel = movie
        }
    }
    
    private func fetchData(query: String) {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.searchMovieManager.search(query: query, completion: { (model, error) in
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
            self.tableView.reloadData()
        })
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.model?.results?[indexPath.row] else {
            preconditionFailure("Attempted to dequeue invalid row")
        }

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = model.title
        cell.detailTextLabel?.text = model.overview
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = self.model?.results?[indexPath.row] else {
            preconditionFailure("Attempted to dequeue invalid row")
        }
        self.performSegue(withIdentifier: R.segue.searchViewController.showMovieDetails, sender: model)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let string = searchBar.text else {
            return
        }
        
        self.fetchData(query: string)
    }
}
