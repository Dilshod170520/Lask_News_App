//
//  HomeVC.swift
//  NewsAppFirst
//
//  Created by MacBook Pro on 10/08/23.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    var colView: UICollectionView = {
        // bu yerda collection umumiy nastroykalari
        let col = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        col.isScrollEnabled = true
        
        // register cells
        col.register(ExploreCell.self, forCellWithReuseIdentifier: "cell")
        col.register(LargeNewsColViewCell.self, forCellWithReuseIdentifier: "large")
        return col
    }()
    let stack: UIStackView = {
        let st = UIStackView()
        st.axis = .vertical
        st.spacing = 10
        st.alignment = .fill
        st.distribution = .fillEqually
        return st
    }()
    
    var apiService = ApiService()
    
    var topArticles: [Article] = []
    var everyThingArticles: [Article] = []
    //   var fetchedData: [FetchedData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground
        setupNavBar()
        setupSubviews()
        setupColView()
        
        apiService.getTopHeadlineNews { result in
            switch result {
            case .success(let articles):
                self.topArticles = articles
                DispatchQueue.main.async {
                    self.colView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        apiService.getNews(page: 1) { result in
            switch result {
            case .success(let articles):
                self.everyThingArticles = articles
                
                DispatchQueue.main.async {
                    self.colView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - Setup Functions
    
    func setupSubviews() {
        // colView
        view.addSubview(colView)
        // constraints of ColView
        colView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupNavBar() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d, yyyy"
        
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        navigationItem.title = "Good morng  turn " + dateString
        
        let morning: UILabel = {
            let l = UILabel()
            l.text = "Good  Morning"
            l.textColor = .label
            return l
        }()
        let dateLabel: UILabel = {
            let l = UILabel()
            l.text = dateString
            l.textColor = .label
            return l
        }()
        
        [morning, dateLabel].forEach { labels in
            stack.addArrangedSubview(labels)
        }
        navigationItem.titleView = stack
        
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemGray2
        ]
        appearance.titlePositionAdjustment = UIOffset(horizontal: -100,
                                                      vertical: 0)
        navigationController?.navigationBar.standardAppearance = appearance
        //        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    func setupColView() {
        colView.delegate = self
        colView.dataSource = self
        colView.setCollectionViewLayout(createLayout(), animated: true)
    }
    
    //MARK: - Col View Layout Functions
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [self] section, environment in
            switch section {
            case 0:
                return createBigSizeSection()
            case 1:
                return createNormalSizeSection()
            case 3:
                return createNormalSizeSection()
            default:
                return createSmallSizeSection()
            }
        }
        return layout
    }
    
    func createBigSizeSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.95),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10) // Set your desired insets
        
        return section
    }
    func createNormalSizeSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(0.6)),
            subitems: [item,item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10) // Set your desired insets
        return section
    }
    func createSmallSizeSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalWidth(0.5)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10) // Set your desired insets
        return section
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return topArticles.count
        case 1:
            return everyThingArticles.count
        default:
            return 11
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = colView.dequeueReusableCell(withReuseIdentifier: "large", for: indexPath) as! LargeNewsColViewCell
            
            cell.titleLbl.text = topArticles[indexPath.row].title
            cell.categoryLbl.text = topArticles[indexPath.row].author
            // url to Image -> Data -> Image
            // url checking
            // URL String = articles[indexPath.row].urlToImage
            // string -> URL
            if let url = URL(string: topArticles[indexPath.row].urlToImage!) {
                
                // url -> Data
                if let data = try? Data(contentsOf: url) {
                    // data -> Image
                    cell.bannerImgView.image = UIImage(data: data)
                }
            }
            return cell
        case 1:
            let cell = colView.dequeueReusableCell(withReuseIdentifier: "large", for: indexPath) as! LargeNewsColViewCell
            
            cell.titleLbl.text = everyThingArticles[indexPath.row].title
            cell.categoryLbl.text = everyThingArticles[indexPath.row].author
            // url to Image -> Data -> Image
            // url checking
            // URL String = articles[indexPath.row].urlToImage
            // string -> URL
            if let url = URL(string: everyThingArticles[indexPath.row].urlToImage!) {
                
                
                // url -> Data
                if let data = try? Data(contentsOf: url) {
                    // data -> Image
                    cell.bannerImgView.image = UIImage(data: data)
                }
            }
            return cell
        default:
            let cell = colView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ExploreCell
            return cell
        }
    }
    // did select - > To Next VC : More info
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ArticleViewController()
        vc.modalPresentationStyle = .fullScreen
        switch indexPath.section {
        case 0:
            if  let url = URL(string: topArticles[indexPath.row].urlToImage!) {
                if let data = try? Data(contentsOf: url) {
                    vc.backgroundImageview.image = UIImage(data: data)
                }
            }
            vc.dataLabal.text = topArticles[indexPath.row].author
            vc.titlLabel.text = topArticles[indexPath.row].title
            vc.descreptionLabel.text = topArticles[indexPath.row].description
        default:
            if  let url = URL(string: everyThingArticles[indexPath.row].urlToImage!) {
                if let data = try? Data(contentsOf: url) {
                    vc.backgroundImageview.image = UIImage(data: data)
                }
            }
            vc.dataLabal.text = everyThingArticles[indexPath.row].author
            vc.titlLabel.text = everyThingArticles[indexPath.row].title
            vc.descreptionLabel.text = everyThingArticles[indexPath.row].description
        }
        self.present(vc, animated: true)
    }
}
