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
    
    var addGroupButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    private var groupImage: Avatar = {
        let imageView = Avatar(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
       
        return imageView
    }()
    
    private var groupName: UILabel = {
        let lable = UILabel()
        lable.textColor = .systemGreen
        lable.font = UIFont(name: "Apple Color Emoji", size: 20)
        lable.numberOfLines = 2
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func hiddenButtonAdd() {
        self.addGroupButton.isHidden = true
    }
    
    func getImageSize() -> CGSize {
        return groupImage.frame.size
    }
    
    func setCellSetup(for group: Group) {
        groupImage.setImage(group.avatar!)
        groupName.text = group.name
        
        let actionForButton = UIAction { [self] _ in
            switch addGroupButton.configuration?.image {
            case UIImage(systemName: "checkmark"):
                DataBase.data.myGroups.remove(group)
                
            case UIImage(systemName: "plus"):
                DataBase.data.myGroups.insert(group)
               
            default:
                break
            }
            print(DataBase.data.myGroups.count)
        }
        addGroupButton.addAction(actionForButton, for: .touchDown)
        addGroupButton.configuration = .plain()
        addGroupButton.configuration?.image = DataBase.data.myGroups.contains(group) ? UIImage(systemName: "checkmark") : UIImage(systemName: "plus")
        addGroupButton.configuration?.baseForegroundColor = .systemGreen
    }
    
    private func setConstraints() {
        addSubview(groupImage)
        addSubview(groupName)
        self.contentView.addSubview(addGroupButton)
       
        
        addGroupButton.snp.makeConstraints { make in
            make.width.equalTo(addGroupButton.frame.width)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
        }
        
        groupImage.snp.makeConstraints { make in
            make.size.equalTo(groupImage.frame.width)
            make.left.top.bottom.equalToSuperview().inset(5)
        }
        
        groupName.snp.makeConstraints { make in
            make.left.equalTo(groupImage.snp.right).offset(20)
            make.top.equalToSuperview().inset(self.frame.height / 5)
            make.right.equalTo(addGroupButton.snp.left).offset(10)
        }
    }
}
