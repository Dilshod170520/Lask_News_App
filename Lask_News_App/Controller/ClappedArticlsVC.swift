//
//  ClappedArticlsVC.swift
//  Lask_News_App
//
//  Created by MacBook Pro on 14/08/23.
//

import UIKit
import CoreData

class ClappedArticlsVC: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .tertiarySystemBackground
        
        collection.register(ClappedArticlsCell.self, forCellWithReuseIdentifier: ClappedArticlsCell.identifier)
        return collection
    }()
    
    var dataCours: [Article] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        view.backgroundColor = .red
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.delegate  = self
        collectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //         getData()
        //        func getData() {
        let request: NSFetchRequest = ClappedArticleDB.fetchRequest()
        
        if let clapperdData = try? context.fetch(request).first {
            
            let arteclesDB = clapperdData.articles?.allObjects  as! [ArticleDB]
            
            arteclesDB.forEach { arteclesDB in
                let article = Article(articleDB: arteclesDB)
                self.dataCours.append(article)
                
            }
            collectionView.reloadData()
        }
        //        }
        
    }
    
    
    
    func setNavBar() {
        navigationItem.title = "Clappped Articls"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"),
                                                           style: .done,
                                                           target: self, action: #selector(backPressed))
        
    }
    
    @objc func  backPressed() {
        dismiss(animated: true)
    }
}

extension ClappedArticlsVC: UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataCours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClappedArticlsCell.identifier, for: indexPath) as! ClappedArticlsCell
        
        cell.configur(article: dataCours[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 25,
                            left: 32,
                            bottom: 0,
                            right: 32)
    }
}
