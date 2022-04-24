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
    
    var addGroupButton = AddGroupButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    private var groupImage: AvatarView = {
        let imageView = AvatarView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
       
        return imageView
    }()
    
    private var groupName: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont(name: "Times New Roman Полужирный", size: 18)
        lable.numberOfLines = 2
        return lable
    }()
    
    private var testGroup: Group?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        addGroupButton.addTarget(self, action: #selector(targetForAddGroupButton), for: .touchDown)
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
//        groupImage.setImage(group.avatar)
//        groupName.text = group.name
        testGroup = group
        addGroupButton.config()
//        addGroupButton.configuration?.image = DataManager.data.groups.contains(group) ?  AddGroupButton.imageForButton.groupIsAddImage.image : AddGroupButton.imageForButton.groupIsNotAddImage.image
    }
    
    @objc private func targetForAddGroupButton() {
        switch addGroupButton.configuration?.image {
        case AddGroupButton.imageForButton.groupIsNotAddImage.image:
            addGroupButton.configuration?.image = AddGroupButton.imageForButton.groupIsAddImage.image
        case AddGroupButton.imageForButton.groupIsAddImage.image:
            addGroupButton.configuration?.image = AddGroupButton.imageForButton.groupIsNotAddImage.image
        default:
            break
        }
        
        guard let group = testGroup else {return}
//        if DataManager.data.groups.contains(group) {
//            for (index, _) in DataManager.data.groups.enumerated(){
//                DataManager.data.groups.remove(at: index)
//            }
//        } else {
//            DataManager.data.groups.append(group)
//        }
  
    }
    
    private func setConstraints() {
        contentView.addSubview(groupImage)
        addSubview(groupName)
        contentView.addSubview(addGroupButton)
       
        
        addGroupButton.snp.makeConstraints { make in
            make.width.equalTo(addGroupButton.frame.width)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
        }
        
        groupImage.snp.makeConstraints { make in
            make.size.equalTo(groupImage.frame.width)
            make.left.top.bottom.equalToSuperview().inset(5).priority(999)
        }
        
        groupName.snp.makeConstraints { make in
            make.left.equalTo(groupImage.snp.right).offset(20)
            make.top.equalToSuperview().inset(self.frame.height / 5)
            make.right.equalTo(addGroupButton.snp.left).offset(10)
        }
    }
}
