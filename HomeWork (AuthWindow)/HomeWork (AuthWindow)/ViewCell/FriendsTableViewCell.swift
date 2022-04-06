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
        let imageView = Avatar(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        return imageView
    }()
    private var fullName: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont(name: "Timas New Roman", size: 18)
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    func getRowForFriendsVC(for user: Person) {
        avatar.setImage(user.avatar)
        fullName.text = "\(user.name) \(user.description)"
    }
    
    func getimageSize() -> CGSize {
        return avatar.frame.size
    }
    
    private func setupConstraints(){
        self.contentView.addSubview(avatar)
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
