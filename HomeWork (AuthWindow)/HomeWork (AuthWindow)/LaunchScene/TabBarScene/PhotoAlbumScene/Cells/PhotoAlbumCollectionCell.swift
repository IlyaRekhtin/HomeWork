//
//  FriendCollectionViewCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 22.02.2022.
//

import UIKit
import SnapKit
import Kingfisher

class PhotoAlbumCollectionCell: UICollectionViewCell {
    
    static var reuseID = "UserCollectionCell"
    
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = UIColor(red: 0.7, green: 0.8, blue: 0.85, alpha: 0.7)
        imageView.kf.indicatorType = .activity
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func configCell (for photoUrl: URL) {
        
        
        imageView.kf.setImage(with: photoUrl) { result in
            
        }
       
        
        makeConstraints()
    }
    
    
    private func makeConstraints() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }

    
}
