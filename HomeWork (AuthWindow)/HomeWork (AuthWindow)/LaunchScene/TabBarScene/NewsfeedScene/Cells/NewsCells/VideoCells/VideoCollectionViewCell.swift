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
    
   private let imageView: UIImageView = {
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.backgroundColor = UIColor(red: 0.7, green: 0.8, blue: 0.85, alpha: 0.7)
        imageView.kf.indicatorType = .activity
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let durationLable: UILabel = {
        var lable = UILabel(frame: .zero)
        lable.backgroundColor = .darkGray
        lable.font = UIFont(name: "Times New Roman", size: 12)
        lable.textColor = .white
        lable.layer.cornerRadius = 5
        lable.clipsToBounds = true
        return lable
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config (for video: Video) {
        guard let firstFramesSize = video.firstFrame else {return}
        let startImageUrlStr = Photo.max(in: firstFramesSize)
        guard let url = URL(string: startImageUrlStr) else {return}
        imageView.kf.setImage(with: url)
    }
    
    private func setConstraints() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        imageView.addSubview(durationLable)
        durationLable.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(100)
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(5)
        }
    }
}
