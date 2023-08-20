//
//  ReadArticlVC.swift
//  Lask_News_App
//
//  Created by MacBook Pro on 14/08/23.
//

import UIKit
import CoreData
class ReadArticlVC: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 64, height: 80)
        let collecton = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collecton.backgroundColor = .tertiarySystemBackground
        collecton.register(ReadArticlCell.self, forCellWithReuseIdentifier: ReadArticlCell.identifier)
        return collecton
    }()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext?
    
    var readTitles: [String] = []
    var articles: [Article] = []
    
    var apiService: ApiService = ApiService()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = appDelegate.persistentContainer.viewContext
        
        setColDelegates()
        setNavBar()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // data fetch
        
        if let titles = UserDefaults.standard.array(forKey: "read") as? [String] {
            readTitles = titles
        }
        print(readTitles)
        
        readTitles.forEach { title in
            
            apiService.getNews(withTitle: title) { result in
                switch result {
                case .success(let articles):
                    print(articles.count)
                    if let first = articles.first {
                        self.articles.append(first)
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let request: NSFetchRequest<ReadArticleDB> = ReadArticleDB.fetchRequest()
        
        if let readArticleDB = try? context?.fetch(request).first {
            print(readArticleDB.articles)
            
            var articlesDB = readArticleDB.articles!.allObjects as! [ArticleDB]
            
            //            articlesDB.sort { next, prev in
            //                return next.readAt! > prev.readAt!
            //            }
            articlesDB.forEach { articleDB in
                let article: Article = Article(articleDB: articleDB)
                self.articles.append(article)
            }
        }
    }
    func setColDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func setNavBar() {
        navigationItem.title = "Read Articles"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(backBtnCliced))
    }
    @objc func backBtnCliced() {
        dismiss(animated: true)
    }
}
extension ReadArticlVC: UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        articles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReadArticlCell.identifier, for: indexPath) as! ReadArticlCell
        cell.configure(article: articles[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30,
                            left: 34,
                            bottom: 0,
                            right: 34)
    }
}
