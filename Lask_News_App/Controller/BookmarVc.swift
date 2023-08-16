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
    
    
    let apiService = ApiService()
    var everyThingArticls: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNuvbar()
        setupTableVeiw()
        
        
        apiService.getNews(page: 4) { result in
            switch result {
            case .success(let articls):
                self.everyThingArticls = articls
                DispatchQueue.main.async {
                    self.tableVeiw.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
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
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return everyThingArticls.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  BookmarkTableVeiwCell.identifier)as! BookmarkTableVeiwCell
        cell.configure(title: "I am gonna be iOS Developer in the future Inshaallah", image: UIImage(named: "image"))
         var dataImage = Data()
        if let url = URL(string:  everyThingArticls[indexPath.row].urlToImage!) {
            if let data = try? Data(contentsOf: url) {
               dataImage = data
            }
        }
        cell.configure(title: everyThingArticls[indexPath.row].title!, image: UIImage(data: dataImage))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
}
