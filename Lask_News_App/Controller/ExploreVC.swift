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
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 80) // Set your desired cell 
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ExploreCell.self, forCellWithReuseIdentifier: ExploreCell.identifier)
        collectionView.backgroundColor = .white
        return collectionView
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
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
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
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(scrollView.snp.bottom)
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

typealias CollectionDelegates =  UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension ExploreVC: CollectionDelegates {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCell.identifier, for: indexPath) as! ExploreCell
        cell.configure(image: UIImage(named: "ExploreImage")!, title: "Hello Tashkent Hello Samarqand Samarqand Samarqand")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 64, height: 80)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let inset = UIEdgeInsets(top: 20,
                                 left: 32,
                                 bottom: 0,
                                 right: 32)
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
}
