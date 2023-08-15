//
//  NormalCollectionViewCell.swift
//  NewsAppFirst
//
//  Created by MacBook Pro on 10/08/23.
//

import UIKit
import SnapKit

class NormalCollectionViewCell: UICollectionViewCell {
    let normalImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.layer.cornerRadius = 15
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let normalCategoryLabel: UILabel = {
        let l = UILabel()
        l.textColor = .systemMint
        l.numberOfLines = 1
        l.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        l.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        l.minimumScaleFactor = 0.2
        return l
    }()
    let normaltitle: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 20,weight: .semibold )
        l.textColor = .black
        l.numberOfLines = 0
        l.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        l.minimumScaleFactor = 0.6
        return l
    }()
    
    //MARK: - Override init section
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(normalImage)
        contentView.addSubview(normalCategoryLabel)
        contentView.addSubview(normaltitle)
        normalImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(contentView.frame.width/2.2)
        }
        normalCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(normalImage.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        normaltitle.snp.makeConstraints { make in
            make.top.equalTo(normalCategoryLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(5)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

