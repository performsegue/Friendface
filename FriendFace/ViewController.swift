//
//  ViewController.swift
//  FriendFace
//
//  Created by Bharath  Raj kumar on 27/01/19.
//  Copyright © 2019 Bharath Raj Kumar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchResultsUpdating {
    
    let dataSource = FriendDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dataSource.dataChanged = {
            [weak self] in
            self?.tableView.reloadData()
        }
        let url = "https://www.hackingwithswift.com/samples/friendface.json"
        dataSource.fetch(url)
        tableView.dataSource = dataSource
        
        
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find a Friend"
        search.searchResultsUpdater = self
        navigationItem.searchController = search
        
        
    }
    
    func updateSearchResults(for searchController: UISearchController)
    {
        dataSource.filterText = searchController.searchBar.text
    }
    
    
}

