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
        likeButton.layer.cornerRadius = likeButton.frame.height / 4
        likeButton.clipsToBounds = true
        likeButton.configuration = .bordered()
        likeButton.configuration?.buttonSize = .small
        return likeButton
    }()
    
    private var reposts: RepostsButton = {
        let reposts = RepostsButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        reposts.layer.cornerRadius = reposts.frame.height / 4
        reposts.clipsToBounds = true
        reposts.configuration = .bordered()
        reposts.configuration?.buttonSize = .small
        return reposts
    }()
    
    private var views: UILabel = {
        var views = UILabel()
        views.textColor = .gray
        views.font = UIFont(name: "Times New Roman", size: 14)
        views.contentMode = .center
        return views
    }()
    
    private var item: News?
    
    private var id = 0
    private var owner = 0
    
    
    
//    private let separateView: UIView = {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 5))
//        view.backgroundColor = .opaqueSeparator
//        return view
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(for news: News) {
        self.item = news
        self.owner = news.sourceID
        self.id = news.postID
        self.likeButton.setConfig(for: news)
        self.reposts.setConfig(for: news)
        guard let viewsCount = news.views?.count else {return}
        self.views.text = "🙈" + String(viewsCount)
    }
    
    
    @objc private func likeButtonTap() {
//        guard let item = self.item else {return}
//        self.likeButton.updateLikeButton(for: item)
    }
    
    
}
//MARK: - make constrainst
private extension FooterNewsCell {
    func makeConstraints() {
        self.contentView.addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(10)
        }

        self.contentView.addSubview(reposts)
        reposts.snp.makeConstraints { make in
            make.left.equalTo(self.likeButton.snp.right).offset(5)
            make.top.equalToSuperview().inset(10)
        }

        self.contentView.addSubview(views)
        views.snp.makeConstraints { make in
            make.centerY.equalTo(self.likeButton.snp.centerY)
            make.right.equalToSuperview().inset(10)
        }
        
//        self.contentView.addSubview(separateView)
//        separateView.snp.makeConstraints { make in
//            make.top.equalTo(self.likeButton.snp.bottom).offset(10)
//            make.height.equalTo(self.separateView.frame.height)
//            make.left.right.bottom.equalToSuperview()
//            
//        }
    }
}
