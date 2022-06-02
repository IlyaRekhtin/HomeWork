//
//  FooterNewsCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 31.05.2022.
//

import UIKit
import SnapKit

final class FooterNewsCell: UITableViewCell {
    
    static let reuseID = "footerNewsCell"
    
    private var likeButton: LikeButton = {
        let likeButton = LikeButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        likeButton.layer.cornerRadius = likeButton.frame.height / 3
        likeButton.clipsToBounds = true
        return likeButton
    }()
    
    private var reposts: RepostsButton = {
        let reposts = RepostsButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        reposts.layer.cornerRadius = reposts.frame.height / 3
        reposts.clipsToBounds = true
        return reposts
    }()
    
    private var views: UILabel = {
        var views = UILabel()
        views.textColor = .gray
        views.font = UIFont(name: "Times New Roman", size: 14)
        return views
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCellForFooter(news: News) {
        self.likeButton.setConfig(for: news)
        self.reposts.setConfig(for: news)
        guard let viewsCount = news.views?.count else {return}
        self.views.text = String(viewsCount)
    }
    
    
    
}
//MARK: - make constrainst
private extension FooterNewsCell {
    func makeConstraints() {
        self.addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.width.equalTo(self.likeButton.frame.width)
            make.height.equalTo(self.likeButton.frame.height)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(5)
        }
        
        self.addSubview(reposts)
        reposts.snp.makeConstraints { make in
            make.width.equalTo(self.likeButton.frame.width)
            make.height.equalTo(self.likeButton.frame.height)
            make.centerX.equalToSuperview()
            make.left.equalTo(self.likeButton.snp.right).inset(5)
        }
        
        self.addSubview(views)
        views.snp.makeConstraints { make in
            make.width.equalTo(self.likeButton.frame.width)
            make.height.equalTo(self.likeButton.frame.height)
            make.centerX.equalToSuperview()
            make.right.equalToSuperview().inset(5)
        }
    }
}
