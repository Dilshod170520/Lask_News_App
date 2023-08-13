//
//  ColViewCell.swift
//  NewsAppFirst
//
//  Created by MacBook Pro on 10/08/23.
//

import UIKit

class ExploreCell: UICollectionViewCell {
    
    static let  identifier: String = "ExploreCell"
    
    let titleLabel: UILabel  = {
        let l = UILabel()
        l.text = "Experience the Serenity of Japan's Traditional Countryside"
        l.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        l.textAlignment = .center
        l.numberOfLines = 2
   return l
    }()
    
    let newsImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ExploreImage")
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "ExploreImage")
        image.frame = CGRect(x: 0, y: 0, width: 80, height: 112)
        return image
        
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(newsImage)
        newsImage.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview().inset(5)
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(5)
            make.right.equalTo(newsImage.snp.left)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
