//
//  ColViewCell.swift
//  NewsAppFirst
//
//  Created by MacBook Pro on 10/08/23.
//

import UIKit

class ExploreCell: UICollectionViewCell {
    
    var identifier: String = "cell"
    
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
        image.image = UIImage(named: "")
        return image
        
    }()
    
    let ownerImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ExploreImage")
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "")
        image.layer.cornerRadius = 5
        return image
        
    }()
    let ownerName: UILabel  = {
        let l = UILabel()
        l.text = "Jack Loo"
        l.font = UIFont.systemFont(ofSize: 10, weight: .light)
        l.textAlignment = .left
        l.numberOfLines = 1
   return l
    }()
    
    let ownerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing  = 5
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    
    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing  = 10
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
