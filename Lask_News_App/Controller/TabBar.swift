//
//  TabBar.swift
//  NewsAppFirst
//
//  Created by MacBook Pro on 10/08/23.
//

import UIKit
import BubbleTabBar

class TabBar: BubbleTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            generateVC(vc: HomeVC(),
                       title: "Discover",
                       systemImageName: "list.bullet.rectangle.portrait"),
            
            generateVC(vc: ExploreVC(),
                       title: "Search",
                       systemImageName: "magnifyingglass"),
            
            generateVC(vc: CategoryVC(),
                       title: "Categories",
                       systemImageName: "list.bullet.rectangle.portrait"),
            
            

            generateVC(vc: SavedNewsVC(),
                       title: "Saved",
                       systemImageName: "bookmark.fill"),
        
        ]
        setupTabBar()
    }
    func setupTabBar() {
        }
    
    func generateVC(vc: UIViewController, title: String, systemImageName: String) -> UIViewController {
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = UIImage(systemName: systemImageName)
        
        return nav
    }

}
