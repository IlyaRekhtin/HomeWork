//
//  FriendsTableViewCellFor.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 18.02.2022.
//

import UIKit
import SnapKit
import Kingfisher


class FriendsTableViewCell: UITableViewCell {
    
    static let reuseID = "CellFriends"

    var avatar: AvatarView = {
        let imageView = AvatarView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        return imageView
    }()
    
   
    private var fullName: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont.mainTextFont
        return lable
    }()
    
    private var city: UILabel = {
        let lable = UILabel()
        lable.textColor = .lightGray
        lable.font = UIFont.subTextFont
        lable.alpha = 0.9
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configCell(for friend: FriendViewModel) {
        city.text = friend.city
        fullName.text = friend.name
    }
    
    func getimageSize() -> CGSize {
        return avatar.frame.size
    }
    
    private func setupConstraints(){
        self.contentView.addSubview(avatar)
        addSubview(fullName)
        addSubview(city)
        
        avatar.snp.makeConstraints { make in
            make.width.equalTo(avatar.frame.width)
            make.left.top.bottom.equalToSuperview().inset(5)
        }
        
        fullName.snp.makeConstraints { make in
            make.left.equalTo(avatar.snp.right).offset(20)
            make.top.trailing.equalToSuperview().inset(8)
        }
        
        city.snp.makeConstraints { make in
            make.left.equalTo(avatar.snp.right).offset(20)
            make.top.equalTo(fullName.snp.bottom).offset(5)
            make.trailing.equalToSuperview()
        }
        
    }
}
