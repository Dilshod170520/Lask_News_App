//
//  ReadArticlVC.swift
//  Lask_News_App
//
//  Created by MacBook Pro on 14/08/23.
//

import UIKit

class ReadArticlVC: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 64, height: 80)
        let collecton = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collecton.register(ReadArticlCell.self, forCellWithReuseIdentifier: ReadArticlCell.identifier)
        return collecton
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setColDelegates()
        setNavBar()
        view.backgroundColor = .blue
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setColDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func setNavBar() {
        navigationItem.title = "Read Articls"
        
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
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReadArticlCell.identifier, for: indexPath) as! ReadArticlCell
        cell.configur(imege: UIImage(named: "flower"), title: "I love my town. Because that is so wandurfull")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30,
                            left: 34,
                            bottom: 0,
                            right: 34)
    }
}
