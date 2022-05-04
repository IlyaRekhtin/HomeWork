//
//  like.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 28.02.2022.
//

import UIKit

class LikeButton: UIButton {
/// images enum
   private enum buttonStateImages: String {
        case like
            
        case likeFill
        
        var image: UIImage? {
            switch self {
            case .like:
                return UIImage(systemName: "heart")
            case .likeFill:
                return UIImage(systemName: "heart.fill")
            }
        }
    }
    
    
    func secConfig(for news: News){
        guard let likes = news.likes else {return}
        self.configuration?.image = likes.userLikes == 1 ? buttonStateImages.likeFill.image : buttonStateImages.like.image
        self.configuration?.baseForegroundColor = likes.userLikes == 1 ? UIColor.red : UIColor.gray
        self.configuration?.title = likes.count == 0 ? "" : String(likes.count)
        self.configuration?.imagePadding = 5
    }

    func setConfig(for photo: Photo) {
        self.configuration?.image = photo.likes.userLikes == 1 ? buttonStateImages.likeFill.image : buttonStateImages.like.image
        self.configuration?.baseForegroundColor = photo.likes.userLikes == 1 ? UIColor.red : UIColor.gray
        self.configuration?.title = photo.likes.count == 0 ? "" : String(photo.likes.count)
        self.configuration?.imagePadding = 5
    }
    
    func updateLikeButton(for photo: Photo){
        animationImageChange()
        self.configuration?.image = photo.likes.userLikes == 1 ? buttonStateImages.likeFill.image : buttonStateImages.like.image
        self.configuration?.baseForegroundColor = photo.likes.userLikes == 1 ? UIColor.red : UIColor.gray
        self.configuration?.title = photo.likes.count == 0 ? "" : String(photo.likes.count)
        photo.likes.userLikes == 1 ? Api.shared.likes(for: photo, .add) : Api.shared.likes(for: photo, .delete)
    }
}
//MARK: - Animation for button
    extension LikeButton {
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
   
    

