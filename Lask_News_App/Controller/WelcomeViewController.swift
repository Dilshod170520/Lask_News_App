//
//  WelcomeViewController.swift
//  NewsAppFirst
//
//  Created by MacBook Pro on 11/08/23.
//

import UIKit

class WelcomeViewController: UIViewController {

    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgroundImaga")
        image.contentMode = .scaleToFill
        return image
    }()
    let buildingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "building")
        image.contentMode = .scaleToFill
        return image
    }()
    
    let contenerView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemBackground
        view.layer.cornerRadius = 40
        return view
    }()
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Get The Latest News And Updates"
        l.textColor = .label
        l.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        l.textAlignment = .center
        l.numberOfLines = 2
        return l
    }()
    
    let subTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "From Politics to Entertainment: Your One-Stop Source for Comprehensive Coverage of the Latest News and Developments Across the Glob will be right on your hand."
        l.textColor = UIColor(named: "grayColor")
        l.font = UIFont.systemFont(ofSize: 18)
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    let button: UIButton = {
        let b = UIButton()
        b.setTitle("Explore ➜", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        b.tintColor = .white
        b.backgroundColor =  UIColor(named: "exploreBtnColer")
        b.layer.cornerRadius = 25
        return b
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(buildingImage)
        buildingImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(view.frame.height/1.6)
        }
        
        view.addSubview(contenerView)
        contenerView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(view.frame.height/2.2)
        }
        
        contenerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
        }
        
        contenerView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
        }
        
        contenerView.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(140)
        }
        
        button.addTarget(self, action: #selector(explorBtnPressed), for: .touchUpInside)
        
    }
    
    @objc func explorBtnPressed() {
        let tabBar = TabBar()
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
    

}
