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
        img.image = UIImage(named: "noImage")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let contenerView: UIView = {
        let v = UIView()
        v.backgroundColor = .tertiarySystemBackground
        return v
    }()
    
    // TabBar View
    let tabBarView: UIView = {
        
        let view = UIView()
        
        let effect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: effect)
        
        blurView.contentView.backgroundColor = UIColor(named: "articlBarColor")!.withAlphaComponent(0.3)
        blurView.alpha = 0.9
        
        view.addSubview(blurView)
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return view
    }()
    
    //MARK: - TabBar items
    let chevronLeftBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        b.tintColor = .label
        return b
    }()
    
    let likeBtn: UIButton = {
        let b = UIButton()
        b.setImage( UIImage(systemName: "hands.sparkles")  , for: .normal)
        b.tintColor = .label
        return b
    }()
    let bookMarkBtn: UIButton = {
        let b = UIButton()
        b.setImage(  UIImage(systemName: "bookmark") , for: .normal)
        b.tintColor = .label
        return b
    }()
    
    let shareBtn: UIButton = {
        let b = UIButton()
        b.setImage( UIImage(systemName: "arrowshape.turn.up.right") , for: .normal)
        b.tintColor = .label
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
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
        
    let titlLabel: UILabel = {
        let l = UILabel()
        l.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
        l.textColor = .label
        l.textAlignment = .justified
        l.numberOfLines = 3
        l.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return l
    }()
    let dataLabal: UILabel = {
        let l = UILabel()
        l.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
        l.textColor = .blue
        l.textAlignment = .justified
        l.numberOfLines = 1
        l.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return l
    }()
    
    let descreptionLabel: UILabel = {
        let l = UILabel()
        l.textColor = .label
        l.textAlignment = .justified
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return l
    }()
    
    let articleImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "articleBackgroundImage")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewConstents()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        contenerView.roundCorners(corners: [.topLeft, .topRight], radius: 35)
        tabBarView.roundCorners(corners: [.topLeft, .topRight], radius: 35)
        
        likeBtn.addTarget(self,
                          action: #selector(likeBtnPressed),
                          for: .touchUpInside)
    }
    @objc func likeBtnPressed() {
        
        likeBtn.tintColor = .blue
    }
    
    //MARK: - Setup View Constents
    func setupViewConstents() {
        
        contenerView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.verticalEdges.equalToSuperview().inset(24)
        }
        
        //Set ScrollView Labels
        scrollView.addSubview(titlLabel)
        titlLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            // scrollView inner width related to label width
            make.width.equalToSuperview().multipliedBy(1)
        }
        scrollView.addSubview(dataLabal)
        dataLabal.snp.makeConstraints { make in
            make.top.equalTo(titlLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
        }
        scrollView.addSubview(descreptionLabel)
        descreptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dataLabal.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
        }

        // Set Background Image
        view.addSubview(backgroundImageview)
        backgroundImageview.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(view.frame.height/3)
        }
        // Set Contaner View
        view.addSubview(contenerView)
        contenerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(backgroundImageview.snp.bottom).offset(-30)
        }
        
        // set TabBar View
        view.addSubview(tabBarView)
        tabBarView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(70)
        }
        
        //Stack
        [ likeBtn , bookMarkBtn, shareBtn].forEach { buttons in
            stackView.addArrangedSubview(buttons)
        }
        // Set Stack View
        tabBarView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(30)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        // Set left Button
        tabBarView.addSubview(chevronLeftBtn)
        chevronLeftBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        // Set Target for left button
        chevronLeftBtn.addTarget(self,
                                 action: #selector(backBtnPressed),
                                 for: .touchUpInside)
    }
    
    //MARK: - @objc function for Btn Targets
    
    @objc func backBtnPressed() {
        dismiss(animated: true)
    }
}
