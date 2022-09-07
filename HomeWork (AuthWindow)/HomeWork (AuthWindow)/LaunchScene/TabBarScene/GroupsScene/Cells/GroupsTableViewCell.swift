//
//  GroupsTableViewCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.02.2022.
//

import UIKit
import SnapKit
import Kingfisher
import RealmSwift
import SwiftUI

class GroupsTableViewCell: UITableViewCell {
    
    static var reuseID = "groupCell"
    
    private let service = ButtonForAddGroupsService()
    private var activeGroup: GroupViewModel!
    var groupForRealm: Group!
    private var addGroupButton = ButtonForAddGroup(frame: .zero) {
        didSet {
            addGroupButton.setNeedsUpdateConfiguration()
        }
    }
    
    var groupImage: AvatarView = {
        let imageView = AvatarView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
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
    
    func setCellSetup(for group: GroupViewModel) {
        self.activeGroup = group
//        groupImage.setImage(group.avatar)
        groupName.text = group.name
        addGroupButton.configuration?.image = activeGroup.isMember ? UIImage(systemName: "checkmark")! : UIImage(systemName: "plus")!
        addGroupButton.isHidden = group.isMember ? true : false
    }
    
    ////реализация кнопки добавить группу
    @objc private func targetForAddGroupButton() {
        activeGroup.isMember ? service.groupNetwork(self.activeGroup.id, .leaveGroup) : service.groupNetwork(self.activeGroup.id, .joinGroup)
        do {
            let realm = try Realm()
            try realm.write {
                if activeGroup.isMember {
                    realm.add(groupForRealm, update: .modified)
                    addGroupButton.configuration?.image = UIImage(systemName: "checkmark")!
                    activeGroup.isMember.toggle()
                } else {
                    activeGroup.isMember.toggle()
                    addGroupButton.configuration?.image = UIImage(systemName: "plus")!
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setConstraints() {
        contentView.addSubview(groupImage)
        addSubview(groupName)
        addSubview(groupDescription)
        contentView.addSubview(addGroupButton)
        
        
        addGroupButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
        
        groupImage.snp.makeConstraints { make in
            make.size.equalTo(groupImage.frame.width)
            make.left.top.bottom.equalToSuperview().inset(5).priority(999)
        }
        
        groupName.snp.makeConstraints { make in
            make.left.equalTo(groupImage.snp.right).offset(20)
            make.top.equalToSuperview().inset(self.frame.height / 5)
            make.right.equalToSuperview().inset(50)
        }
        groupDescription.snp.makeConstraints { make in
            make.left.equalTo(groupImage.snp.right).offset(20)
            make.top.equalTo(groupName.snp.bottom).offset(3)
            make.right.equalToSuperview().inset(50)
        }
    }
}
