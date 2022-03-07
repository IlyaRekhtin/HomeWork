//
//  FriendsTableViewCellFor.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 18.02.2022.
//

import UIKit
import SnapKit

class FriendsTableViewCell: UITableViewCell {
    
    static let reuseID = "CellFriends"

    private var avatar: Avatar = {
        let imageView = Avatar(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        return imageView
    }()
    private var fullName: UILabel = {
        let lable = UILabel()
        lable.textColor = .systemGreen
        lable.font = UIFont(name: "Timas New Roman", size: 17)
        return lable
    }()
    
    func getRowForFriendsVC(for user: User) {
        avatar.setImage(user.avatar)
        fullName.text = "\(user.name) \(user.surname)"
        setupConstraints()
    }
    
    func getimageSize() -> CGSize {
        return avatar.frame.size
    }
    
    private func setupConstraints(){
        addSubview(avatar)
        addSubview(fullName)
        
        avatar.snp.makeConstraints { make in
            make.width.equalTo(avatar.frame.width)
            make.left.top.bottom.equalToSuperview().inset(5)
        }
        
        fullName.snp.makeConstraints { make in
            make.left.equalTo(avatar.snp.right).offset(20)
            make.top.trailing.equalToSuperview().inset(8)
        }
    }
}
