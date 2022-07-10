//
//  NewsCollectionViewCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 18.03.2022.
//

import UIKit
import SnapKit
import RealmSwift

class Cell: UICollectionViewCell {
    
    static let reuseID = "newsfeed"
    
    
 
    private var newsfeedText : UILabel = {
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        lable.font = UIFont(name: "Times New Roman", size: 17)
        lable.numberOfLines = 0
        return lable
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        newsfeedText.text = "ЗАГЛУШКА"
        setConstreints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - Constraints
private extension Cell {
    
    func setConstreints() {
        self.contentView.addSubview(newsfeedText)
        newsfeedText.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

