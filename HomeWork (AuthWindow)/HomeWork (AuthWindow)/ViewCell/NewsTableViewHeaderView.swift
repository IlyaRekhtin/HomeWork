//
//  NewsTableViewHeaderFooterView.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.03.2022.
//

import UIKit
import SnapKit

class NewsTableViewHeaderView: UITableViewHeaderFooterView {

    static let reuseID = "news header"
    
    
    private var avatar: Avatar = {
        let imageView = Avatar(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        return imageView
    }()
    
    private var name: UILabel = {
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        lable.numberOfLines = 1
        lable.textAlignment = .left
        lable.font = UIFont(name: "Times New Roman", size: 17)
        return lable
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(avatar)
        addSubview(name)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(_ person: Person) {
        avatar.offShadow()
        avatar.setImage(person.avatar)
        name.text = person.name
    }
    
    
    private func setConstraints() {
        avatar.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(5)
            make.width.equalTo(avatar.frame.width)
        }
        
        name.snp.makeConstraints { make in
            make.left.equalTo(avatar.snp.right).offset(10)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
