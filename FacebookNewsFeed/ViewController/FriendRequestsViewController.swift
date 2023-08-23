//
//  FriendRequestsViewController.swift
//  FacebookNewsFeed
//
//  Created by Ting on 2023/8/23.
//

import Foundation
import UIKit

class FriendRequestsViewController: UITableViewController {
    
    static let cellId = "cellId"
    static let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Friend Requests"
        
        tableView.sectionHeaderHeight = 26
        tableView.separatorStyle = .none
        
        tableView.register(FriendRequestCell.self, forCellReuseIdentifier: FriendRequestsViewController.cellId)
        tableView.register(RequestHeader.self, forHeaderFooterViewReuseIdentifier: FriendRequestsViewController.headerId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: FriendRequestsViewController.cellId, for: indexPath) as! FriendRequestCell
        
        if indexPath.row % 3 == 0 {
            cell.nameLabel.text = "Ting"
            cell.requestImageView.image = UIImage(named: "Skip and Loafer")
        } else if indexPath.row % 3 == 1 {
            cell.nameLabel.text = "Sue"
            cell.requestImageView.image = UIImage(named: "卡西法")
        } else {
            cell.nameLabel.text = "能幹貓"
            cell.requestImageView.image = UIImage(named: "能幹貓")
        }
        
        cell.imageView?.backgroundColor = UIColor.black
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FriendRequestsViewController.headerId) as! RequestHeader
        
        if section == 0 {
            header.nameLabel.text = "FRIEND REQUESTS"
        } else {
            header.nameLabel.text = "PEOPLE YOU MAY KNOW"
        }
        
        return header
    }
}
