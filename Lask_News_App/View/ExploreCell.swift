//
//  ColViewCell.swift
//  NewsAppFirst
//
//  Created by MacBook Pro on 10/08/23.
//

import UIKit

class ExploreCell: UICollectionViewCell {
    
    static let  identifier: String = "ExploreCell"
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    // Override init and setup UI elements using SnapKit
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        imageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(80) // Set your desired image size
            make.height.equalTo(112)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.trailing.equalTo(imageView.snp.leading).offset(16)
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configure the cell's content
    func configure(image: UIImage, title: String) {
        imageView.image = image
        titleLabel.text = title
    }
}

