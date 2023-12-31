//
//  ClappedArticlsCell.swift
//  Lask_News_App
//
//  Created by MacBook Pro on 14/08/23.
//

import UIKit

class ClappedArticlsCell: UICollectionViewCell {
    
    
    static let identifier = "ClappedArticlsCell"
    
       let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20 , weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
      let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        return img
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
            make.height.equalTo(80)
            make.width.equalTo(112)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(imageView.snp.leading)
            make.centerY.equalToSuperview()
        }
    }
    
    func configur(article: Article) {
        titleLabel.text = article.title
        if let urlString = article.urlToImage {
            imageView.kf.setImage(with: URL(string: urlString))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
