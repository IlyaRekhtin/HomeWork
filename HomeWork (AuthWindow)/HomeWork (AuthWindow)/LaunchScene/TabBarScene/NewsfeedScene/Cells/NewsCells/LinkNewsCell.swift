
//  LinkNewsCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 31.05.2022.
//

import UIKit
import SnapKit
import Kingfisher

final class LinkNewsCell: UITableViewCell {
    
    static let reuseID = "footerNewsCell"
    
    private let backView: UIView = {
        var backView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen().bounds.width, height: UIScreen().bounds.width))
        backView.layer.cornerRadius = backView.bounds.width / 5
        backView.layer.borderColor = UIColor.darkGray.cgColor
        backView.backgroundColor = .clear
        backView.layer.borderWidth = 1
        backView.clipsToBounds = true
        return backView
    }()
    
    private var linkImage: UIImageView = {
        let linkImage = UIImageView(frame: .zero)
        linkImage.contentMode = .scaleAspectFit
        return linkImage
    }()
    
    
    
    private var linkTitle: UILabel = {
        var linkTitle = UILabel()
        linkTitle.textColor = .black
        linkTitle.font = UIFont(name: "Times New Roman", size: 16)
        linkTitle.numberOfLines = 2
        return linkTitle
    }()
    
    private var linkSubTitle: UILabel = {
        var linkSubTitle = UILabel()
        linkSubTitle.textColor = .lightGray
        linkSubTitle.font = UIFont(name: "Times New Roman", size: 10)
        linkSubTitle.numberOfLines = 1
        return linkSubTitle
    }()
    
    
    private var linkURL = ""
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(for link: Link) {
        self.linkURL = link.url
        
        let photoURL = Photo.getPhotoUrl(with: .z, for: [link.photo])
        self.linkImage.kf.setImage(with: photoURL.first)
        
        self.linkTitle.text = link.title
        self.linkSubTitle.text = link.caption
        
        //TODO action
    }
    
    
    
}
//MARK: - make constrainst
private extension LinkNewsCell {
    func makeConstraints() {
        self.contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
        }
        
        backView.addSubview(linkImage)
        linkImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(self.backView.frame.height - 70)
        }
        
        
        backView.addSubview(linkTitle)
        linkTitle.snp.makeConstraints { make in
            make.top.equalTo(self.linkImage.snp.bottom).offset(5)
            make.right.left.equalToSuperview()
            make.height.equalTo(50)
        }
        
        backView.addSubview(linkSubTitle)
        linkSubTitle.snp.makeConstraints { make in
            make.top.equalTo(self.linkTitle.snp.bottom).offset(3)
            make.right.left.bottom.equalToSuperview()
        }
    }
}

