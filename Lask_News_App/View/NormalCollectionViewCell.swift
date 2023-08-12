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
        l.font = UIFont.systemFont(ofSize: 25,weight: .semibold )
        l.textColor = .black
        l.numberOfLines = 0
        l.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        l.minimumScaleFactor = 0.6
        return l
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        contentView.addSubview(normalImage)
        contentView.addSubview(normaltitle)
        contentView.addSubview(normalCategoryLabel)
        
        
        normalImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        normalCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(normalImage.snp.bottom).offset(5)

        }
        normaltitle.snp.makeConstraints { make in
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}

/*
 var bannerImgView: UIImageView = {
     let imgView = UIImageView()
     imgView.contentMode = .scaleToFill
     imgView.layer.cornerRadius = 16
     imgView.clipsToBounds = true
     return imgView
 }()
 
 var titleLbl: UILabel = {
     let lbl = UILabel()
     lbl.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
     lbl.textColor = UIColor.black
     lbl.numberOfLines = 0
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
 */
