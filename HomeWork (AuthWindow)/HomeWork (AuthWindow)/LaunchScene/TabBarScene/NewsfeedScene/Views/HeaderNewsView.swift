//
//  headerNewsView.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 24.03.2022.
//

import UIKit
import SnapKit

class HeaderNewsView: UIView {

    private var avatar: AvatarView
    private var name: UILabel
    
    
    override init(frame: CGRect) {
        let avatarSize = CGSize(width: frame.height, height: frame.height)
        avatar = AvatarView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: avatarSize))
        name = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: avatarSize))
        name.numberOfLines = 1
        name.textAlignment = .left
        name.font = UIFont(name: "Times New Roman", size: 16)
        
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
            make.left.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(3)
            make.size.width.equalTo(avatar.frame.size)
           
        }
        
        name.snp.makeConstraints { make in
            make.centerY.equalTo(avatar.snp.centerY)
            make.left.equalTo(avatar.snp.right).offset(10)
            make.right.equalToSuperview()
        }
    }
    
    func setValue(_ avatar: String, _ name: String) {
        guard let url = URL(string: avatar) else {return}
        self.avatar.shadowOff()
        self.avatar.setImage(url)
        self.name.text = name
    }
   
    
}
