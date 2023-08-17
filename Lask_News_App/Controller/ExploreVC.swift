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
        collectionView.backgroundColor = .tertiarySystemBackground
        return collectionView
    }()
    
    // Array for Category Title
    var categoryNames: [String] = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    
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
    
    var searchText: String? = nil
    var selectedCategory: Category? = nil
    
    let apiService = ApiService()
    var evrethingArticls : [Article] = [ ]
    
    
    //MARK: -  ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        
        searchController.searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //        apiService.getNews(searchText: serchText) { result in
        //            switch result {
        //            case .success(let success):
        //                self.evrethingArticls = success
        //                DispatchQueue.main.async {
        //                    self.collectionView.reloadData()
        //                }
        //            case .failure(let failure):
        //                print(failure)
        //            }
        //        }
        
        apiService.getNews(page: 3, pageSize: 40) { result in
            
            switch result {
            case .success(let articls):
                self.evrethingArticls = articls
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
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
            button.configuration?.title = category.capitalized
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
        
        view.backgroundColor = .tertiarySystemBackground
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
        
        categoryButtons.forEach { button in
            button.configuration?.baseForegroundColor = .white
            button.configuration?.baseBackgroundColor = .systemGray6
        }
        
        sender.configuration?.baseBackgroundColor = .systemBlue
        sender.configuration?.baseForegroundColor = .white
        
        selectedCategory = Category(rawValue: sender.configuration!.title!.lowercased())
        
        apiService.getTopHeadlineNews(withCategory: selectedCategory) { result in
            switch result {
            case .success(let articls):
                self.evrethingArticls = articls
                print(articls)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    //Searchbar Target
    @objc func searchBtnPressed() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "Search artists"
        searchController.searchBar.sizeToFit()
        
        navigationItem.searchController = searchController
        searchController.searchBar.becomeFirstResponder()
    }
}

extension ExploreVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        if let text = self.searchText {
            apiService.getTopHeadlineNews(withCategory: selectedCategory, withQuery: text) { result in
                switch result {
                case .success(let success):
                    self.evrethingArticls = success
                case .failure(let failure):
                    print(failure)
                }
            }
        }
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchText = nil
        
        apiService.getNews(page: 20) { result in
            switch result {
            case .success(let success):
                self.evrethingArticls = success
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
        navigationItem.searchController?.searchBar.resignFirstResponder()
    }
}

typealias CollectionDelegates =  UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

extension ExploreVC: CollectionDelegates {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return evrethingArticls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCell.identifier, for: indexPath) as! ExploreCell
        cell.configure(image: UIImage(named: "ExploreImage")!, title: "Hello Tashkent Hello Samarqand Samarqand Samarqand")
        
        var image: UIImage?
        if let urlString = evrethingArticls[indexPath.row].urlToImage {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    image = UIImage(data: data)
                }
            }
        }
        
        cell.configure(image: image,
                       title: evrethingArticls[indexPath.row].title!)
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

extension ExploreVC: UISearchControllerDelegate  {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchText =  searchBar.text!
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchText =  searchBar.text!
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text != nil {
//            searchText = searchText
        }
    }
}
