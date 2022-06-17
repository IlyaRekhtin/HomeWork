//
//  DocCollectionViewCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 12.06.2022.
//

import UIKit
import SnapKit

class DocViewCell: UITableViewCell {
    
    static var reuseID = "DocViewCell"
    
    private let mbait = 0.0000009537
    
    private var docButtonConfig: UIButton.Configuration = {
        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = .lightGray
        config.baseForegroundColor = .darkGray
        config.image = UIImage(systemName: "doc.circle")
        config.imagePadding = 20
        config.buttonSize = .large
        return config
    }()
    private var doc: UIButton?
    private var doc1: UIButton?
    private var doc2: UIButton?
    private var doc3: UIButton?
    private var doc4: UIButton?
    private var doc5: UIButton?
    private var doc6: UIButton?
    private var doc7: UIButton?
    private var doc8: UIButton?
    private var doc9: UIButton?
    
    private lazy var docsButton = [doc, doc1, doc2, doc3, doc4, doc5, doc6, doc7, doc8, doc9]
    
   
    var stacView: UIStackView = {
        var stacView = UIStackView(frame: .zero)
        stacView.axis = .vertical
        stacView.distribution = .fill
        stacView.alignment = .leading
        stacView.contentMode = .scaleToFill
        return stacView
    }()
    
    
    func configCell(for docs: [Doc]) {
        for (index, doc) in docs.enumerated() {
            docsButton[index] = UIButton(configuration: self.docButtonConfig)
            docsButton[index]?.configuration?.title = doc.title
            guard let size = doc.size else {return}
            let docSize = NSString(format: "%.1f", Double(size) * mbait)
            let docDate = getCurrentTime(for: doc.date ?? 0)
            docsButton[index]?.configuration?.subtitle = "\(docSize) Mb ・ \(docDate)"
            stacView.addArrangedSubview(docsButton[index]!)
        }
        makeConstraints()
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
        self.contentView.addSubview(stacView)
        stacView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
