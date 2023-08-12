//
//  SearchVC.swift
//  NewsAppFirst
//
//  Created by MacBook Pro on 10/08/23.
//

import UIKit

class ExploreVC: UIViewController {
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
     return scroll
    }()
    
    let travelBtn: UIButton = {
        let b = UIButton()
        b.setTitle("Travel", for: .normal)
        b.layer.cornerRadius = 15
        b.tintColor = .black
        b.frame = CGRect(x: 0, y: 0, width: 200, height: 30)

        b.layer.borderColor = UIColor.systemBackground.cgColor
        b.layer.borderWidth = 1.5
        return b
    }()
    
    let entertanmentBtn: UIButton = {
        let b = UIButton()
        b.setTitle("Travel", for: .normal)
        b.layer.cornerRadius = 15
        b.tintColor = .black
        b.frame = CGRect(x: 0, y: 0, width: 200, height: 30)

        b.layer.borderColor = UIColor.systemBackground.cgColor
        b.layer.borderWidth = 1.5
        return b
    }()
    let texnologyBtn: UIButton = {
        let b = UIButton()
        b.setTitle("Travel", for: .normal)
        b.layer.cornerRadius = 15
        b.tintColor = .black
        b.layer.borderColor = UIColor.systemBackground.cgColor
        b.frame = CGRect(x: 0, y: 0, width: 200, height: 30)

        b.layer.borderWidth = 1.5
        return b
    }()
    
    let businessBtn: UIButton = {
        let b = UIButton()
        b.setTitle("Travel", for: .normal)
        b.layer.cornerRadius = 15
        b.tintColor = .black
        b.layer.borderColor = UIColor.systemBackground.cgColor
        b.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        b.layer.borderWidth = 1.5
        return b
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: view.frame.width + 50 , height: 40)
               
        [travelBtn,texnologyBtn, businessBtn , entertanmentBtn].forEach({ button in
            
            scrollView.addSubview(button)
        })
        
               view.addSubview(scrollView)
        view.backgroundColor = .white
        setNavBar()
        
       
    }
    
    func setNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Explore", style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: nil, action: nil)
    }
}
