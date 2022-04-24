//
//  like.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 28.02.2022.
//

import UIKit

class LikeButton: UIButton {

    private var imageLike = UIImage(systemName: "heart")
    private var imageLikeFill = UIImage(systemName: "heart.fill")
    private var likeCount: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfig(for photo: Photo) {
  
        self.configuration?.image = photo.likes.userLikes == 1 ? imageLikeFill : imageLike
        self.configuration?.baseForegroundColor = photo.likes.userLikes == 1 ? UIColor.red : UIColor.gray
        self.likeCount = photo.likes.count
        self.configuration?.title = String(likeCount)
        self.configuration?.imagePadding = 5
    }
    
     func animationImageChange() {
         let animation = CASpringAnimation(keyPath: "position.y")
         animation.fromValue = self.layer.position.y - 5
         animation.toValue = self.layer.position.y
         animation.duration = 0.5
         animation.stiffness = 1000
         animation.mass = 0.5
         self.layer.add(animation, forKey: nil)
        
    }
    
    func changeValue(for photo: Photo) {
        switch photo.likes.userLikes {
        case 1:
            self.configuration?.image = UIImage(systemName: "heart")
            self.likeCount = Api.shared.likes(for: photo, .delete)?.count ?? 0
            self.configuration?.title = String(self.likeCount)
           
        case 0:
            self.configuration?.image = UIImage(systemName: "heart.fill")
            self.likeCount = Api.shared.likes(for: photo, .add)?.count ?? 0
            self.configuration?.title = String(self.likeCount)
           
        default:
            break
        }
        
    }
    
    
}
