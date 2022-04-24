//
//  FriendCollectionViewCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 22.02.2022.
//

import UIKit
import SnapKit
import Kingfisher

class FriendCollectionViewCell: UICollectionViewCell {
    
    static var reuseID = "UserCollectionCell"
    
    var imageView = UIImageView()
    
    func setCollectionViewSetting (for photo: Photo) {
       let currentPhoto = photo.sizes.filter { size in
            size.type == "r"
        }
        print(currentPhoto)
//        imageView.kf.setImage(with: currentPhoto.first?.url)
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        
        makeConstraints()
    }
    
    
    private func makeConstraints() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
//    private func scaleImage(_ image: UIImage) -> UIImage {
//        
//        
//        let orientation = image.size.width / image.size.height
//        
//        let widthScale = self.frame.width / image.size.width
//        let heigthScale = self.frame.height / image.size.height
//        var rect = CGRect.zero
//        switch orientation {
//        case ...1:
//            rect = CGRect(x: 0, y: 0, width: image.size.width * widthScale, height: image.size.height * widthScale)
//        case 1:
//            rect = CGRect(x: 0, y: 0, width: image.size.width * widthScale, height: image.size.width * widthScale)
//        case 1...:
//            rect = CGRect(x: 0, y: 0, width: image.size.width * heigthScale, height: image.size.height * heigthScale)
//        default:
//            break
//        }
//        
//        UIGraphicsBeginImageContext(rect.size)
//        image.draw(in: rect)
//        let scaleImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
// 
//        return scaleImage
//    }
    
    
}
