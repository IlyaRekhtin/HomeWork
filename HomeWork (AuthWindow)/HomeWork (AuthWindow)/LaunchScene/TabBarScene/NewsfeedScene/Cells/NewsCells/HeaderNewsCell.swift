//
//  HeaderNewsCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 31.05.2022.
//

import Foundation
import UIKit
import SnapKit


final class HeaderNewsCell: UITableViewCell {
    
    static let reuseID = "headerNewsCell"
    
    private var avatar: AvatarView = {
        let avatar = AvatarView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        return avatar
    }()
    private var fullName: UILabel = {
        let name = UILabel()
        name.numberOfLines = 1
        name.textAlignment = .left
        name.font = UIFont(name: "Times New Roman", size: 16)
        return name
    }()
    private var newsDate: UILabel = {
        let newsDate = UILabel()
        newsDate.numberOfLines = 1
        newsDate.textAlignment = .left
        newsDate.font = UIFont(name: "Times New Roman", size: 12)
        return newsDate
    }()
    
    private var buttonForAddGroup: ButtonForAddGroup = {
        let buttonForAddGroup = ButtonForAddGroup(frame: .zero)
        return buttonForAddGroup
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCellForGroup(_ group: Group, date: Int) {
        guard let url = URL(string: group.photo50) else {return}
        avatar.setImage(url)
        fullName.text = group.name
        newsDate.text = String(date)
        
        // для группы добавляем кнопку инвайта
        self.addSubview(buttonForAddGroup)
        buttonForAddGroup.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
        
        buttonForAddGroup.configuration?.image = group.isMember == 1 ? UIImage(systemName: "checkmark")! : UIImage(systemName: "plus")!
        buttonForAddGroup.isHidden = group.isMember == 0 ? true : false
    }
    
    func configCellForFriend(_ friend: User, date: Int) {
        guard let url = URL(string: friend.photo50) else {return}
        avatar.setImage(url)
        fullName.text = friend.firstName + friend.lastName
        newsDate.text = String(date)
    }
}
//MARK: - make constrainst
private extension HeaderNewsCell {
    func makeConstraints() {
        self.addSubview(avatar)
        avatar.snp.makeConstraints { make in
            make.width.equalTo(avatar.frame.width)
            make.left.top.bottom.equalToSuperview().inset(5)
        }
        
        self.addSubview(fullName)
        fullName.snp.makeConstraints { make in
            make.left.equalTo(avatar.snp.right).offset(20)
            make.top.trailing.equalToSuperview().inset(8)
        }
        
        self.addSubview(newsDate)
        newsDate.snp.makeConstraints { make in
            make.left.equalTo(avatar.snp.right).offset(20)
            make.top.equalTo(fullName.snp.bottom).offset(5)
            make.trailing.equalToSuperview()
        }
    }
}
