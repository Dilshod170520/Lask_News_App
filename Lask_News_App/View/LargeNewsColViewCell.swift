//
//  LargeNewsColViewCell.swift
//  NewsAppFirst
//
//  Created by MacBook Pro on 10/08/23.
//

import UIKit
import SnapKit

class LargeNewsColViewCell: UICollectionViewCell {
 
    var bannerImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.layer.cornerRadius = 16
        imgView.clipsToBounds = true
        return imgView
    }()
    
    var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        lbl.textColor = UIColor.black
        lbl.numberOfLines = 2
        lbl.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.6
//        lbl.lineBreakMode = .byTruncatingTail
        return lbl
    }()
    
    var categoryLbl: UILabel = {
        
        let lbl = UILabel()
        
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        lbl.textColor = UIColor.systemBlue
        lbl.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
//        lbl.lineBreakMode = .byTruncatingTail
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLbl)
        contentView.addSubview(categoryLbl)
        contentView.addSubview(bannerImgView)
        // image view
        bannerImgView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        // category Label
        categoryLbl.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(bannerImgView.snp.bottom).offset(8)
        }
        // title label
        titleLbl.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(categoryLbl.snp.bottom).offset(8)
        }
        titleLbl.text = "Bugun sana 10.08. Havo harorati odatiy issiq"
        categoryLbl.text = "Figma"
        bannerImgView.image = UIImage(named: "image")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
