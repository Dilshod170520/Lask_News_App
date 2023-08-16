//
//  ReadArticlCell.swift
//  Lask_News_App
//
//  Created by MacBook Pro on 14/08/23.
//

import UIKit

class ReadArticlCell: UICollectionViewCell {
    
    static let identifier = "ReadArticlCell"
    
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        return img
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .tertiarySystemBackground
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(80)
            make.width.equalTo(112)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.trailing.equalTo(imageView.snp.leading)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configur(imege: UIImage?, title: String) {
        imageView.image = imege
        titleLabel.text = title
   }
}
