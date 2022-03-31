//
//  headerNewsView.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 24.03.2022.
//

import UIKit
import SnapKit

class HeaderNewsView: UIView {

    private var avatar: Avatar
    private var name: UILabel
    
    
    override init(frame: CGRect) {
        let avatarSize = CGSize(width: frame.height - 6, height: frame.height - 6)
        avatar = Avatar(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: avatarSize))
        name = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: avatarSize))
        name.numberOfLines = 1
        name.textAlignment = .left
        name.font = UIFont(name: "Times New Roman Полужирный", size: 18)
        
        super.init(frame: frame)
        
        addSubview(avatar)
        addSubview(name)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        avatar.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(3)
            make.size.equalTo(avatar.frame.size)
           
        }
        
        name.snp.makeConstraints { make in
            make.centerY.equalTo(avatar.snp.centerY)
            make.left.equalTo(avatar.snp.right).offset(10)
            make.right.equalToSuperview()
        }
    }
    
    func setValue(_ avatar: UIImage, _ name: String) {
        self.avatar.offShadow()
        self.avatar.setImage(avatar)
        self.name.text = name
    }
   
    
}
