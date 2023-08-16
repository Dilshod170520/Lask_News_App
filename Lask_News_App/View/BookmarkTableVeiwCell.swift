//
//  BookmarkTableVeiwCell.swift
//  Lask_News_App
//
//  Created by MacBook Pro on 14/08/23.
//

import UIKit
import SnapKit

class BookmarkTableVeiwCell: UITableViewCell {
   
    static let identifier = "BookmarkTableVeiwCell"
        // Create the label and image view
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.textColor = .tertiarySystemBackground
            label.numberOfLines = 2
            label.font  = UIFont.systemFont(ofSize: 20, weight: .semibold)
            return label
        }()
        
        private let rightImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleToFill
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            return imageView
        }()
        
    
    private let contanerView: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        return view
    }()
    
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            
            contentView.addSubview( contanerView)
            // Add subviews to cell's content view
            contanerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            
            contanerView.addSubview(titleLabel)
            contanerView.addSubview(rightImageView)
            
            // Apply SnapKit constraints
            titleLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(16) // Left padding
                make.centerY.equalToSuperview() // Vertically centered
                make.trailing.lessThanOrEqualTo(rightImageView.snp.leading).offset(-16) // Space between
                make.top.equalToSuperview().offset(12)
                make.bottom.equalToSuperview().inset(12)
            }
            
            rightImageView.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(-16) // Right padding
                make.centerY.equalToSuperview() // Vertically centered
                make.width.equalTo(112) // Set a fixed width for the image view
                make.height.equalTo(80) // Set a fixed height for the image view
                make.top.equalToSuperview().offset(12)
                make.bottom.equalToSuperview().inset(12)
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // Configure the cell's content
        func configure(title: String, image: UIImage?) {
            titleLabel.text = title
            rightImageView.image = image
        }
    }
