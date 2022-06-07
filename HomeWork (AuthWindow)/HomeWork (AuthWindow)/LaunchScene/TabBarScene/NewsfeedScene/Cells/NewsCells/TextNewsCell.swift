
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
        newsText.textAlignment = .left
        newsText.textColor = .black
        newsText.font = UIFont(name: "Times New Roman", size: 16)
        return newsText
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(for newsText: String) {
        self.newsText.text = newsText
        //TODO button
    }
    
    
    
}
//MARK: - make constrainst
private extension TextNewsCell {
    func makeConstraints() {
        
        self.contentView.addSubview(newsText)
        newsText.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
            
        }
        
//        self.addSubview(moreButton)
//        moreButton.snp.makeConstraints { make in
//            make.top.equalTo(self.newsText.snp.bottom).offset(5)
//            make.bottom.left.right.equalToSuperview()
//
//        }
    }
}
