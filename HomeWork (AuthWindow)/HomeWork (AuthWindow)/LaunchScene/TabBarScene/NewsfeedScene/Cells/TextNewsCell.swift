
//  TextNewsCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 31.05.2022.
//

import UIKit
import SnapKit

final class TextNewsCell: UITableViewCell {
    
    static let reuseID = "textNewsCell"
    
    private let moreButton: UIButton = {
        var moreButton = UIButton()
        moreButton.configuration = UIButton.Configuration.plain()
        moreButton.configuration?.title = "Показать больше..."
        moreButton.configuration?.titleAlignment = .leading
        return moreButton
    }()
    
    private var newsText: UITextView = {
        var newsText = UITextView()
        newsText.isScrollEnabled = false
        newsText.isEditable = false
        newsText.isSelectable = false
        newsText.textAlignment = .left
        newsText.textColor = .black
        newsText.font = UIFont.mainTextFont
        return newsText
    }()
    
    func configCell(for newsText: String) {
        makeConstraints()
        self.newsText.text = newsText
        //TODO button
    }
}
//MARK: - make constrainst
private extension TextNewsCell {
    func makeConstraints() {
        self.addSubview(newsText)
        newsText.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
