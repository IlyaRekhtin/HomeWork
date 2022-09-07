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
        return likeButton
    }()
    
    private var reposts: RepostsButton = {
        let reposts = RepostsButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        return reposts
    }()
    
    private var views: UILabel = {
        var views = UILabel()
        views.textColor = .gray
        views.font = UIFont.mainTextFont
        views.contentMode = .center
        return views
    }()
    
    @objc var currentNewsItem: NewsItem!
    var nameObservetuion: NSKeyValueObservation?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(for news: NewsItem) {
        self.currentNewsItem = news
        self.likeButton.setConfig(for: news)
        self.reposts.setConfig(for: news)
        let viewsCount = news.views
        self.views.text = "🙈" + String(viewsCount)
    }
    
    @objc private func likeButtonTap() {
        
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
    }
}
