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
        newsDate.textColor = .lightGray
        return newsDate
    }()
    
    private var newsTime: UILabel = {
        let newsTime = UILabel()
        newsTime.numberOfLines = 1
        newsTime.textAlignment = .left
        newsTime.font = UIFont(name: "Times New Roman", size: 12)
        newsTime.textColor = .lightGray
        return newsTime
    }()
    
    private var buttonForAddGroup: ButtonForAddGroup = {
        let buttonForAddGroup = ButtonForAddGroup(frame: .zero)
        return buttonForAddGroup
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCellForGroup(_ group: Group, for news: News) {
        avatar.setImage(group.photo50)
        fullName.text = group.name
        /// формат и установка даты
        self.newsDate.text = getCurrentDate(for: news.date)
        ///формат и установка времени
        self.newsTime.text = getCurrentTime(for: news.date)
        
        /// для группы добавляем кнопку инвайта
        self.addSubview(buttonForAddGroup)
        buttonForAddGroup.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
        
        buttonForAddGroup.configuration?.image = group.isMember == 1 ? UIImage(systemName: "checkmark")! : UIImage(systemName: "plus")!
        buttonForAddGroup.isHidden = group.isMember == 1 ? true : false
    }
    
    func configCellForFriend(_ friend: Profile,for news: News) {
        avatar.setImage(friend.photo50)
        fullName.text = friend.firstName + friend.lastName
        self.newsTime.text = getCurrentTime(for: news.date)
        self.newsDate.text = getCurrentDate(for: news.date)
    }
    
    private func getCurrentDate(for timeInterval: Int) -> String {
        let dateNews = Date(timeIntervalSince1970: Double(timeInterval))
        let dateFormatterForDate = DateFormatter()
        dateFormatterForDate.timeZone = .current
        dateFormatterForDate.locale = .current
        dateFormatterForDate.dateFormat = "dd-MM-yyy"
        let today = Calendar.current.startOfDay(for: .now)
        
        if Calendar.current.startOfDay(for: dateNews) == today {
             return "Сегодня"
        } else if Calendar.current.startOfDay(for: dateNews) == today - (60*60*24) {
            return "Вчера"
        } else {
            return dateFormatterForDate.string(from: dateNews)
        }
    }
    
    private func getCurrentTime(for timeInterval: Int) -> String {
        let dateNews = Date(timeIntervalSince1970: Double(timeInterval))
        let dateFormatterForTime = DateFormatter()
        dateFormatterForTime.timeZone = .current
        dateFormatterForTime.locale = .current
        dateFormatterForTime.dateFormat = "HH:mm"
        return dateFormatterForTime.string(from: dateNews)
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
