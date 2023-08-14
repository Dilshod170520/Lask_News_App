//
//  SearchCell.swift
//  Lask_News_App
//
//  Created by MacBook Pro on 14/08/23.
//

import UIKit

class SearchCell: UICollectionViewCell {
    static let identifier = "SearchCell"
    
  private  let newsImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 10
        return image
    }()
    
   private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(newsImage)
        newsImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(80)
            make.width.equalTo(112)
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(newsImage.snp.leading).offset(24)
            make.centerY.equalToSuperview()
        }
    }
    func set(image: UIImage, title: String) {
        newsImage.image = image
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
