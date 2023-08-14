//
//  ClappedArticlsVC.swift
//  Lask_News_App
//
//  Created by MacBook Pro on 14/08/23.
//

import UIKit

class ClappedArticlsVC: UIViewController {

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ClappedArticlsCell.self, forCellWithReuseIdentifier: ClappedArticlsCell.identifier)
        
        
        return collection
    }()
    
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
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClappedArticlsCell.identifier, for: indexPath) as! ClappedArticlsCell
        cell.set(image: UIImage(named: "kingfisher"), title: "I am gonna go Samarqand ")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 25,
                            left: 32,
                            bottom: 0,
                            right: 32)
    }
}
