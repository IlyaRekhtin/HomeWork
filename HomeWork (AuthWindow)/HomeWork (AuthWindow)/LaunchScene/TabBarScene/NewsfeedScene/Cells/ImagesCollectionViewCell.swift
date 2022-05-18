//
//  CollectionViewCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 18.03.2022.
//

import UIKit
import SnapKit
import Kingfisher

class ImagesCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "images"
    
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.backgroundColor = UIColor(red: 0.7, green: 0.8, blue: 0.85, alpha: 0.7)
        imageView.kf.indicatorType = .activity
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config (_ imageURL: URL) {
        imageView.kf.setImage(with: imageURL) { result in
            
        }
    }
    
    private func setConstraints() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
