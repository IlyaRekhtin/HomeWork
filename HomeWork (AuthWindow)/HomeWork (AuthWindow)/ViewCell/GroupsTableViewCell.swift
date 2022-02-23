//
//  GroupsTableViewCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.02.2022.
//

import UIKit
import SnapKit

class GroupsTableViewCell: UITableViewCell {

    static var reuseID = "groupCell"
    
    private var groupImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    private var groupName: UILabel = {
        let lable = UILabel()
        lable.textColor = .systemGreen
        lable.font = UIFont(name: "Apple Color Emoji", size: 20)
        lable.numberOfLines = 2
        return lable
    }()
    
    func getImageSize() -> CGSize {
        return groupImage.frame.size
    }
    
    func setCellSetup(for group: Group) {
        groupImage.image = group.avatar
        groupName.text = group.name
        setConstraints()
    }
    
   
    
    
    
    
    
    
    private func setConstraints() {
        addSubview(groupImage)
        addSubview(groupName)
       
        
        groupImage.snp.makeConstraints { make in
            make.size.equalTo(groupImage.frame.width)
            make.left.top.bottom.equalToSuperview().inset(5)
        }
        
        groupName.snp.makeConstraints { make in
            make.left.equalTo(groupImage.snp.right).offset(20)
            make.top.equalToSuperview().inset(self.frame.height / 5)
            make.right.equalToSuperview().inset(50)
        }
        
        
    }

}
