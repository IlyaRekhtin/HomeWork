
//  LinkNewsCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 31.05.2022.
//

import UIKit
import SnapKit
import Kingfisher

final class LinkNewsCell: UITableViewCell {
    
    static let reuseID = "linkNewsCell"
    
    private let backView: UIView = {
        var backView = UIView()
        backView.layer.cornerRadius = 10
        backView.layer.borderColor = UIColor.lightGray.cgColor
        backView.backgroundColor = .clear
        backView.layer.borderWidth = 0.5
        backView.clipsToBounds = true
        return backView
    }()
    
    private let titleBackView: UIView = {
        var backView = UIView()
        backView.backgroundColor = .white
        return backView
    }()
    
    private var linkImage: UIImageView = {
        let linkImage = UIImageView(frame: .zero)
        linkImage.clipsToBounds = true
        linkImage.contentMode = .scaleToFill
        return linkImage
    }()
    
    private var linkTitle: UILabel = {
        var linkTitle = UILabel()
        linkTitle.textColor = .black
        linkTitle.font = UIFont.mainTextFont
        linkTitle.numberOfLines = 2
        return linkTitle
    }()
    
    private var linkSubTitle: UILabel = {
        var linkSubTitle = UILabel()
        linkSubTitle.textColor = .lightGray
        linkSubTitle.font = UIFont.subTextFont
        linkSubTitle.numberOfLines = 1
        return linkSubTitle
    }()
    
    var linkURL = ""
    var delegate: NewsfeedItemTapped?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(for link: LinkViewModel) {
        self.linkURL = link.linkURL
        self.linkImage.kf.setImage(with: link.linkImage)
        self.linkTitle.text = link.linkTitle
        self.linkSubTitle.text = link.linkSubTitle
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapToLink))
        self.addGestureRecognizer(tap)
    }
    
    @objc private func tapToLink() {
        delegate?.newsfeedItemTapped(cell: self)
    }
    
    
}
//MARK: - make constrainst
private extension LinkNewsCell {
    func makeConstraints() {
        
        self.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
            make.height.equalTo(250)
        }
        
        backView.addSubview(linkImage)
        linkImage.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()
        }
        
        backView.addSubview(titleBackView)
        titleBackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.backView.snp.bottom)
            make.right.left.equalTo(self.backView)
            make.height.equalTo(70)
        }
        
        titleBackView.addSubview(linkTitle)
        linkTitle.snp.makeConstraints { make in
            make.top.equalTo(self.titleBackView.snp.top).offset(8)
            make.right.left.equalTo(self.backView).inset(10)
        }
        
        titleBackView.addSubview(linkSubTitle)
        linkSubTitle.snp.makeConstraints { make in
            make.top.equalTo(self.linkTitle.snp.bottom).inset(3)
            make.right.left.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(5)
        }
    }
}

