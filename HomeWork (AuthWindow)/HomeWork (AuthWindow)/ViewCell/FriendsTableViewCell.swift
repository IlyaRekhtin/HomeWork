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
    private var firstName: UILabel = {
        let lable = UILabel()
        lable.textColor = .systemGreen
        lable.font = UIFont(name: "Apple Color Emoji", size: 20)
        return lable
    }()
    private var secondName: UILabel = {
        let lable = UILabel()
        lable.textColor = .systemGreen
        lable.font = UIFont(name: "Apple Color Emoji", size: 20)
        return lable
    }()
   
    func getRowForFriendsVC(for user: User) {
        avatar.setImage(user.avatar)
        firstName.text = user.name
        secondName.text = user.surname
        setupConstraints()
    }
    
    func getimageSize() -> CGSize {
        return avatar.frame.size
    }
    
    private func setupConstraints(){
        addSubview(avatar)
        addSubview(firstName)
        addSubview(secondName)
        
        avatar.snp.makeConstraints { make in
            make.width.equalTo(avatar.frame.width)
            make.left.top.bottom.equalToSuperview().inset(5)
        }
        
        firstName.snp.makeConstraints { make in
            make.left.equalTo(avatar.snp.right).offset(20)
            make.top.equalToSuperview().inset(self.frame.height / 5)
            make.right.equalToSuperview()
        }
        
        secondName.snp.makeConstraints { make in
            make.left.equalTo(avatar.snp.right).offset(20)
            make.top.equalTo(firstName.snp.bottom).offset(5)
            make.right.equalToSuperview()
        }
    }
}
