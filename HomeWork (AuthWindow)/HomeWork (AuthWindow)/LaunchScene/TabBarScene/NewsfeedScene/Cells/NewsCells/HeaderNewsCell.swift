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
        name.font = UIFont.mainTextFont
        return name
    }()
    private var newsDate: UILabel = {
        let newsDate = UILabel()
        newsDate.numberOfLines = 1
        newsDate.textAlignment = .left
        newsDate.font = UIFont.subTextFont
        newsDate.textColor = .lightGray
        return newsDate
    }()
    
    private var newsTime: UILabel = {
        let newsTime = UILabel()
        newsTime.numberOfLines = 1
        newsTime.textAlignment = .left
        newsTime.font = UIFont.subTextFont
        newsTime.textColor = .lightGray
        return newsTime
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCellForFriend(_ header: HeaderViewModel) {
        avatar.setImage(header.avatar)
        fullName.text = header.name
        self.newsTime.text = header.newsTime
        self.newsDate.text = header.newsDate
    }
}
//MARK: - make constrainst
private extension HeaderNewsCell {
    func makeConstraints() {
        self.addSubview(avatar)
        avatar.snp.makeConstraints { make in
            make.size.equalTo(avatar.frame.size)
            make.left.top.bottom.equalToSuperview().inset(5)
        }
        
        self.addSubview(fullName)
        fullName.snp.makeConstraints { make in
            make.left.equalTo(avatar.snp.right).offset(20)
            make.top.right.equalToSuperview().inset(8)
        }
        
        self.addSubview(newsDate)
        newsDate.snp.makeConstraints { make in
            make.left.equalTo(avatar.snp.right).offset(20)
            make.top.equalTo(fullName.snp.bottom).offset(5)
            
        }
        self.addSubview(newsTime)
        newsTime.snp.makeConstraints { make in
            make.left.equalTo(newsDate.snp.right).offset(3)
            make.top.equalTo(fullName.snp.bottom).offset(5)
            make.right.equalToSuperview()
        }
        
    }
}
