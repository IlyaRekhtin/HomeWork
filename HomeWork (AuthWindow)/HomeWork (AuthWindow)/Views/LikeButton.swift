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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuration?.image = buttonStateImages.like.image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfig<T: Likeble>(for item: T){
        guard let likes = item.likes else {return}
        self.configuration?.image = likes.userLikes == 1 ? buttonStateImages.likeFill.image : buttonStateImages.like.image
        self.configuration?.baseForegroundColor = likes.userLikes == 1 ? UIColor.red : UIColor.gray
        self.configuration?.title = likes.count == 0 ? "" : String(likes.count)
        self.configuration?.imagePadding = 5
    }
    
    func updateLikeButton<T: Likeble>(for item: T){
        animationImageChange()
        guard let likes = item.likes else {return}
        likes.count = likes.userLikes == 1 ? likes.count - 1 : likes.count + 1
        likes.userLikes = likes.userLikes == 1 ? 0 : 1
        self.configuration?.image = likes.userLikes == 1 ? buttonStateImages.likeFill.image : buttonStateImages.like.image
        self.configuration?.baseForegroundColor = likes.userLikes == 1 ? UIColor.red : UIColor.gray
        self.configuration?.title = likes.count == 0 ? "" : String(likes.count)
//        likes.userLikes == 1 ? self.likes(for: item, .likeAdd) : self.likes(for: item, .likeDelete)
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

//MARK: - network method
extension LikeButton {
    func likes(for photo: Photo, _ method: Api.BaseURL.ApiMethod) {
        let params = ["type": "photo",
                      "owner_id": String(photo.ownerID),
                      "item_id": String(photo.id),
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion]
        let url = URL.configureURL(method: method, baseURL: .api, params: params)
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


