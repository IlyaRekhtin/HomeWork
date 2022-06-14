//
//  VideoViewCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 14.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

class VideoCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "videoCollectionViewCell"
    
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
    
    func config (for video: Video) {
        
    }
    
    private func setConstraints() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
