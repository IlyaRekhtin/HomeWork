//
//  DocCollectionViewCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 12.06.2022.
//

import UIKit
import SnapKit

class DocViewCell: UICollectionViewCell {
    
    static var reuseID = "DocViewCell"
    
    private let mbait = 0.0000009537
    
    //    private var docButton: UIButton = {
    //        var config = UIButton.Configuration.plain()
    //        config.baseBackgroundColor = .lightGray
    //        config.baseForegroundColor = .darkGray
    //        config.image = UIImage(systemName: "doc.circle")
    //        config.imagePadding = 20
    //        config.titleAlignment = .leading
    //        config.buttonSize = .large
    //        let button = UIButton(configuration: config)
    //        return button
    //    }()
    
    private let docImage: UIImageView = {
        let docImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        docImage.tintColor = .lightGray
        docImage.image = UIImage(systemName: "doc.circle")
        docImage.backgroundColor = .systemBackground
        return docImage
    }()
    
    private var docNameLable: UILabel = {
        let docNameLable = UILabel()
        docNameLable.textColor = .lightGray
        docNameLable.font = UIFont.mainTextFont
        docNameLable.numberOfLines = 1
        return docNameLable
    }()
    
    private var docSubLable: UILabel = {
        let docSubLable = UILabel()
        docSubLable.textColor = .lightGray
        docSubLable.font = UIFont.subTextFont
        docSubLable.numberOfLines = 1
        return docSubLable
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stackView.addArrangedSubview(self.docNameLable)
        stackView.addArrangedSubview(self.docSubLable)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configCell(for doc: Doc) {
        self.docNameLable.text = doc.title
        guard let size = doc.size else {return}
        let docSize = NSString(format: "%.1f", Double(size) * mbait)
        let docDate = getCurrentTime(for: doc.date ?? 0)
        self.docSubLable.text = "\(docSize) Mb ・ \(docDate)"
    }
    
    private func getCurrentTime(for timeInterval: Int) -> String {
        let dateNews = Date(timeIntervalSince1970: Double(timeInterval))
        let dateFormatterForTime = DateFormatter()
        dateFormatterForTime.timeZone = .current
        dateFormatterForTime.locale = .current
        dateFormatterForTime.dateFormat = "dd.MM.yy HH:mm"
        return dateFormatterForTime.string(from: dateNews)
    }
    
}
//MARK: - make constraints
private extension DocViewCell {
    func  makeConstraints() {
        self.addSubview(docImage)
        docImage.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.size.equalTo(self.docImage.frame.size)
        }
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.equalTo(self.docImage.snp.right).offset(5)
            make.right.top.bottom.equalToSuperview().inset(5)
        }
    }
}
