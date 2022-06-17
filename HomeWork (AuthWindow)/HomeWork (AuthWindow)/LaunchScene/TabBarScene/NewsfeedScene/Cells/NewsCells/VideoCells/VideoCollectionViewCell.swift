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
        imageView.backgroundColor = .black
        imageView.kf.indicatorType = .activity
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let videoDurationView = VideoDurationView(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
    
    private let playButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.configuration = UIButton.Configuration.plain()
        button.configuration?.baseForegroundColor = .white
        button.configuration?.image = UIImage(systemName: "play.circle")
        button.configuration?.buttonSize = .large
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config (for video: Video) {
        guard let image = video.image else {return}
        let startImageUrlStr = Photo.preview(in: image)
        guard let url = URL(string: startImageUrlStr) else {return}
        imageView.kf.setImage(with: url)
        guard let videoDuration = video.duration else {return}
        videoDurationView.setTime(for: videoDuration)
    }
    
    
    
    private func setConstraints() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        imageView.addSubview(videoDurationView)
        videoDurationView.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(self.videoDurationView.frame.width)
            make.height.equalTo(self.videoDurationView.frame.height)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        imageView.addSubview(playButton)
        playButton.snp.makeConstraints { make in
            make.height.width.equalTo(self.playButton.frame.width)
            make.center.equalToSuperview()
        }
    }
}
