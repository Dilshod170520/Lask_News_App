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
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()

    
    let collectionView: UICollectionView = {
        let col = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        col.register(UINib(nibName: ExploreCell.identifier, bundle: <#T##Bundle?#>), forCellWithReuseIdentifier: <#T##String#>)
    }()
    
    // Array for Category Title
    var categoryNames: [String] = ["Technology", "Politics", "Sport", "World", "Science", "Weather"]
    
    let stack: UIStackView = {
        let stack  = UIStackView()
        stack.axis = .horizontal
        stack.spacing =  10
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    var categoryButtons = [UIButton]()
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: -  ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
       setupSubviews()
        
        
    }
    
    
    //MARK: - Setup Functions
    func setupSubviews() {
        // scroll View setup
        categoryNames.forEach { (category) in
            let button = UIButton()
            button.addTarget(self,
                             action: #selector(categoryBtnPressed(_:)),
                             for: .touchUpInside)
            button.configuration = .filled()
            button.configuration?.baseBackgroundColor = .systemGray6
            button.configuration?.title = category
            button.configuration?.cornerStyle = .capsule
            button.tag = categoryNames.firstIndex(of: category)!
            
            categoryButtons.append(button)
            stack.addArrangedSubview(button)
        }

        //Set ScrollView
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        
        //Set Stack View
        scrollView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        
        view.backgroundColor = .white
        setNavBar()
    }
    func setNavBar() {
        navigationItem.title = "Explore"
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            // title text style setup
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .semibold)
        ]
        appearance.titlePositionAdjustment = UIOffset(horizontal: -500,
                                                      vertical: 0)
        navigationController?.navigationBar.standardAppearance = appearance
        // search button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(searchBtnPressed))
        navigationItem.searchController = searchController
    }
    
    //MARK: - @objc functions
    // Category Target func
    @objc func categoryBtnPressed(_ sender: UIButton) {
        
        categoryButtons[sender.tag].configuration?.baseBackgroundColor = .systemBlue
        categoryButtons[sender.tag].configuration?.baseForegroundColor = .white
        
    }
    //Searchbar Target
    @objc func searchBtnPressed() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "Search artists"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        
        searchController.searchBar.becomeFirstResponder()
    }
}

extension ExploreVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.searchController?.searchBar.resignFirstResponder()
    }
    
}
