//
//  HomeViewController.swift
//  FavoriteTV
//
//  Created by DESCHENES, Frédéric (MTL) on 2019-08-18.
//  Copyright © 2019 DESCHENES, Frédéric (MTL). All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {

    enum Tab: Int, CaseIterable {
        case discover
        case search
        
        /// Returns the icon for this tab
        var icon: UIImage? {
            switch self {
            case .discover:
                return R.image.icnDiscover()
            case .search:
                return R.image.icnSearch()
            }
        }
        
        /// Returns the localized title for this tab
        var localizedTitle: String {
            switch self {
            case .discover:
                return R.string.localizable.discoverTitle()
            case .search:
                return R.string.localizable.searchTitle()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Setup the tab images & text
        for tab in Tab.allCases {
            guard let item = self.tabBar.items?[tab.rawValue] else {
                continue
            }
            item.title = tab.localizedTitle
            item.image = tab.icon
        }
    }
}

