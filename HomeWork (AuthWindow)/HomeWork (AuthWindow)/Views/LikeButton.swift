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
        self.configuration?.imagePadding = 5
        self.configuration?.buttonSize = .medium
        self.addAction(UIAction(handler: { _ in
            self.updateLikeButton()
        }), for: .touchUpInside)
    }
    
    init<T: Likeble>(item: T) {
        super.init(frame: .zero)
        self.configuration?.imagePadding = 5
        self.configuration?.buttonSize = .medium
        self.addAction(UIAction(handler: { _ in
            self.updateLikeButton()
        }), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfig<T: Likeble>(for item: T){
        guard let likes = item.likes else {
            self.configuration?.image = buttonStateImages.like.image
            self.configuration?.baseForegroundColor = UIColor.gray
            self.isEnabled = false
            return
        }
        self.isEnabled = true
        self.configuration?.image = likes.userLikes == 1 ? buttonStateImages.likeFill.image : buttonStateImages.like.image
        self.configuration?.baseForegroundColor = likes.userLikes == 1 ? UIColor.red : UIColor.gray
        self.configuration?.title = likes.count == 0 ? "" : String(likes.count)
    }
    
    @objc func updateLikeButton(){
        animationImageChange()
//        likes.count = likes.userLikes == 1 ? likes.count - 1 : likes.count + 1
//        likes.userLikes = likes.userLikes == 1 ? 0 : 1
//        self.configuration?.image = likes.userLikes == 1 ? buttonStateImages.likeFill.image : buttonStateImages.like.image
//        self.configuration?.baseForegroundColor = likes.userLikes == 1 ? UIColor.red : UIColor.gray
//        self.configuration?.title = likes.count == 0 ? "" : String(likes.count)
//        likes.userLikes == 1 ? LikeButton.likesNetwork(item: item, method: .likeAdd) :  LikeButton.likesNetwork(item: item, method: .likeDelete)
    }
    
    
    
    
}
//MARK: - Animation for button
extension LikeButton {
    private func animationImageChange() {
        if self.isEnabled == true {
            let animation = CASpringAnimation(keyPath: "position.y")
            animation.fromValue = self.layer.position.y - 5
            animation.toValue = self.layer.position.y
            animation.duration = 0.5
            animation.stiffness = 1000
            animation.mass = 0.5
            self.layer.add(animation, forKey: nil)
        }
    }
}

//MARK: - network method
extension LikeButton {
    
    static func likesNetwork<T: Likeble>(item: T, method: Api.BaseURL.ApiMethod) {
        var type = ""
        var ownerID = 0
        var id = 0
        if let photo = item as? Photo {
            type = "photo"
            ownerID = photo.ownerID
            id = photo.id
        } else if let news = item as? News {
            type = "post"
            ownerID = news.sourceID
            id = news.postID
            
        }
        let params = ["type": type,
                      "owner_id":String(ownerID),
                      "item_id": String(id),
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion]
        guard let url = URL.configureURL(method: method, baseURL: .api, params: params) else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


