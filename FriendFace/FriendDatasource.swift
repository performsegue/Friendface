//
//  FriendDatasource.swift
//  FriendFace
//
//  Created by Bharath  Raj kumar on 28/01/19.
//  Copyright © 2019 Bharath Raj Kumar. All rights reserved.
//

import Foundation
import UIKit

class FriendDataSource: NSObject, UITableViewDataSource
{
    var friends = [Friend]()
    var filteredFriends = [Friend]()
    var dataChanged: (() -> Void)?
    
    var filterText: String?
    {
        didSet {
            filteredFriends = friends.matching(filterText)
            self.dataChanged?()
        }
    }
    
    func fetch(_ urlString: String)
    {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        decoder.decode([Friend].self, fromURL: urlString, completion: { friends in
            self.friends = friends
            self.filteredFriends = friends
            self.dataChanged!()
        })
    }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let friend = filteredFriends[indexPath.row]
        
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = friend.friendList
        
        return cell
        
    }
    
    
    
    
}
