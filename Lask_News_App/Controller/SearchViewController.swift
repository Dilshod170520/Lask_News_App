//
//  SearchViewController.swift
//  Lask_News_App
//
//  Created by MacBook Pro on 14/08/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 64, height: 80)
        
        let colView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
        return colView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupcollectionViewDelegates()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupcollectionViewDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        cell.set(image: UIImage(named: "image")!,
                 title: "Hello world ")
        return cell
    }

}
