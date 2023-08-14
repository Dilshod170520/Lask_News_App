//
//  CategoryVC.swift
//  NewsAppFirst
//
//  Created by MacBook Pro on 10/08/23.
//

import UIKit

class BookmarVc: UIViewController {
    
    let tableVeiw: UITableView = {
        let table = UITableView()
        table.register(BookmarkTableVeiwCell.self, forCellReuseIdentifier: BookmarkTableVeiwCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNuvbar()
        setupTableVeiw()
    }
    
    func setupTableVeiw() {
        
        view.addSubview(tableVeiw)
        tableVeiw.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableVeiw.dataSource = self
        tableVeiw.delegate = self
    }
    
    
    
    func setupNuvbar() {
        
        navigationItem.title = "Bookmark"
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold)
        ]
        appearance.titlePositionAdjustment = UIOffset(horizontal: -500, vertical: 0)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(markPressed))
    }
    
    @objc func markPressed() {
        
    }
}
typealias TableVeiwDelegetes =  UITableViewDelegate & UITableViewDataSource
extension BookmarVc: TableVeiwDelegetes{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  BookmarkTableVeiwCell.identifier)as! BookmarkTableVeiwCell
        cell.configure(title: "I am gonna be iOS Developer in the future Inshaallah", image: UIImage(named: "image"))
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
}
