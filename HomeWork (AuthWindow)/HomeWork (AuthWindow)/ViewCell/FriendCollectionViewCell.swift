//
//  FriendCollectionViewCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 22.02.2022.
//

import UIKit
import SnapKit

class FriendCollectionViewCell: UICollectionViewCell {
    
    static var reuseID = "UserCollectionCell"
    
    private var imageView = UIImageView()
    
    func setCollectionViewSetting (for user: User) {
        imageView.contentMode = .scaleAspectFill
        imageView.image = user.avatar
        makeConstraints()
    }
    
    
    private func makeConstraints() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    
    
    
}