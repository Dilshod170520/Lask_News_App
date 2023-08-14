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
                       title: "Home",
                       systemImageName: "house"),
            
            generateVC(vc: ExploreVC(),
                       title: "Search",
                       systemImageName: "magnifyingglass"),
            
            generateVC(vc: BookmarVc(),
                       title: "Bookmark",
                       systemImageName: "character.book.closed"), 
            
            

            generateVC(vc: ProfielVC(),
                       title: "Profile",
                       systemImageName: "person"),
        
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
