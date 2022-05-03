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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfig(for photo: Photo) {
        self.configuration?.image = photo.likes.userLikes == 1 ? imageLikeFill : imageLike
        self.configuration?.baseForegroundColor = photo.likes.userLikes == 1 ? UIColor.red : UIColor.gray
        self.configuration?.title = String(photo.likes.count)
        self.configuration?.imagePadding = 5
    }
    
    func updateLikeButton(for photo: Photo){
        animationImageChange()
        self.configuration?.image = photo.likes.userLikes == 1 ? imageLikeFill : imageLike
        self.configuration?.baseForegroundColor = photo.likes.userLikes == 1 ? UIColor.red : UIColor.gray
        self.configuration?.title = String(photo.likes.count)
        photo.likes.userLikes == 1 ? Api.shared.likes(for: photo, .add) : Api.shared.likes(for: photo, .delete)
    }
    
    private func animationImageChange() {
        let animation = CASpringAnimation(keyPath: "position.y")
        animation.fromValue = self.layer.position.y - 5
        animation.toValue = self.layer.position.y
        animation.duration = 0.5
        animation.stiffness = 1000
        animation.mass = 0.5
        self.layer.add(animation, forKey: nil)
       
   }
    
    
   
    
}
