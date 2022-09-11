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
    
    var groupImage: AvatarViewGroup = {
        let imageView = AvatarViewGroup(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        return imageView
    }()
    
    private var groupName: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont.mainTextFont
        lable.numberOfLines = 1
        return lable
    }()
    private var groupDescription: UILabel = {
        let lable = UILabel()
        lable.textColor = .lightGray
        lable.font = UIFont.minTextFont
        lable.numberOfLines = 2
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellSetup(for group: GroupViewModel) {
        groupName.text = group.name

    }
    
    private func makeConstraints() {
        contentView.addSubview(groupImage)
        addSubview(groupName)
        addSubview(groupDescription)

        groupImage.snp.makeConstraints { make in
            make.size.equalTo(groupImage.frame.width)
            make.left.top.bottom.equalToSuperview().inset(5)
        }
        groupName.snp.makeConstraints { make in
            make.left.equalTo(groupImage.snp.right).offset(20)
            make.right.equalToSuperview().inset(5)
            make.centerY.equalTo(groupImage.snp.centerY).offset(-10)
        }
        groupDescription.snp.makeConstraints { make in
            make.top.equalTo(groupName.snp.bottom).offset(3)
            make.right.equalTo(groupName.snp.right)
            make.left.equalTo(groupName.snp.left)
        }
    }
}







   ////реализация кнопки добавить группу
//    @objc private func targetForAddGroupButton() {
//        activeGroup.isMember ? service.groupNetwork(self.activeGroup.id, .leaveGroup) : service.groupNetwork(self.activeGroup.id, .joinGroup)
//        do {
//            let realm = try Realm()
//            try realm.write {
//                if activeGroup.isMember {
//                    realm.add(groupForRealm, update: .modified)
//                    addGroupButton.configuration?.image = UIImage(systemName: "checkmark")!
//                    activeGroup.isMember.toggle()
//                } else {
//                    activeGroup.isMember.toggle()
//                    addGroupButton.configuration?.image = UIImage(systemName: "plus")!
//                }
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
