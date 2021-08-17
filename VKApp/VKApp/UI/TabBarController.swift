//
//  TabBarController.swift
//  VKApp
//
//  Created by Pavel Khlebnikov on 17.08.2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
    }
    
    func setupViewControllers() {
        let newsModul = NewsModul()
        
        viewControllers = [
            createNavigationController(for: FriendsTableViewController(), title: NSLocalizedString("Друзья", comment: ""), image: UIImage(systemName: "person")),
            createNavigationController(for: GroupTableViewController(), title: NSLocalizedString("Группы", comment: ""), image: UIImage(systemName: "house")),
            createNavigationController(for: newsModul.makeNewsViewController(), title: NSLocalizedString("Новости", comment: ""), image: UIImage(systemName: "highlighter"))
        ]
    }
    
    fileprivate func createNavigationController(for rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
}
