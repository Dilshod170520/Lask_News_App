//
//  ArticleViewController.swift
//  NewsAppFirst
//
//  Created by MacBook Pro on 11/08/23.
//

import UIKit

class ArticleViewController: UIViewController {

    let backgroundImageview: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "articleBackgroundImage")
        img.contentMode = .scaleAspectFill
       return img
    }()
    
    let contenerView: UIView = {
        
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius  = 35
        return v
    }()
    // TabBar View
    let tabBarView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray6
        v.layer.cornerRadius  = 10
        return v
    }()
    
    //MARK: - TabBar items
    
    let chevronLeftBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        b.tintColor = .black
        return b
    }()
    
    let likeBtn: UIButton = {
        let b = UIButton()
        b.setImage( UIImage(systemName: "hands.sparkles")  , for: .normal)
        b.tintColor = .black
        return b
    }()
    
    let bookMarkBtn: UIButton = {
        let b = UIButton()
        b.setImage(  UIImage(systemName: "bookmark") , for: .normal)
        b.tintColor = .black
        return b
    }()
    
    let shareBtn: UIButton = {
        let b = UIButton()
        b.setImage( UIImage(systemName: "arrowshape.turn.up.right") , for: .normal)
        b.tintColor = .black
        return b
    }()
    
    let stackView: UIStackView = {
        let stck = UIStackView()
        stck.axis = .horizontal
        stck.spacing = 40
        stck.alignment = .center
        stck.distribution = .fillEqually
        return stck
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(backgroundImageview)
        backgroundImageview.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(view.frame.height/3)
        }
        
        view.addSubview(contenerView)
        contenerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(backgroundImageview.snp.bottom).offset(-30)
        }
        
        view.addSubview(tabBarView)
        tabBarView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(80)
        }
        
        //Stack
        [ likeBtn , bookMarkBtn, shareBtn].forEach { buttons in
            stackView.addArrangedSubview(buttons)
        }
        
        tabBarView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(5)
            make.right.equalToSuperview().inset(30)

        }
        
        tabBarView.addSubview(chevronLeftBtn)
        chevronLeftBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(5)
            make.left.equalToSuperview().offset(20)
            
        }
        
        
    }
}
