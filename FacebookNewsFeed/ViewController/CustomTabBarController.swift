//
//  CustomTabBarController.swift
//  FacebookNewsFeed
//
//  Created by Ting on 2023/8/23.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedController = FeedViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: feedController)
        navigationController.title = "News Feed"
        navigationController.tabBarItem.image = UIImage(named: "news_feed_icon")
        
        let friendRequestsController = FriendRequestsViewController()
        let secondNavigationController = UINavigationController(rootViewController: friendRequestsController)
        secondNavigationController.title = "Requests"
        secondNavigationController.tabBarItem.image = UIImage(named: "requests_icon")
        
        let messengerVC = UIViewController()
        messengerVC.navigationItem.title = "Chat Room"
        let messengerNavigationController = UINavigationController(rootViewController: messengerVC)
        messengerNavigationController.title = "Messenger"
        messengerNavigationController.tabBarItem.image = UIImage(named: "messenger_icon")
        
        let notificationVC = UIViewController()
        notificationVC.navigationItem.title = "Notifications"
        let notificationsNavigationController = UINavigationController(rootViewController: notificationVC)
        notificationsNavigationController.title = "Notifications"
        notificationsNavigationController.tabBarItem.image = UIImage(named: "globe_icon")
        
        let moreVC = UIViewController()
        moreVC.navigationItem.title = "More"
        let moreNavigationController = UINavigationController(rootViewController: moreVC)
        moreNavigationController.tabBarItem.title = "More"
        moreNavigationController.tabBarItem.image = UIImage(named: "more_icon")

        viewControllers = [navigationController, secondNavigationController, messengerNavigationController, notificationsNavigationController, moreNavigationController]
        
//        tabBar.isTranslucent = false
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor.rgb(red: 229, green: 231, blue: 235).cgColor
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
    }
}
