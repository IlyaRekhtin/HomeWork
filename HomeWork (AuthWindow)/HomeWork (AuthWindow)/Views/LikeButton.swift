//
//  like.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 28.02.2022.
//

import UIKit

enum LikebleType: String {
    case post = "post"
    case photo = "photo"
}

class LikeButton: UIButton {
    
    var type: LikebleType = .post
    var likes: Int = 0
    var isLiked: Bool = false
    var sourceID = 0
    var id = 0
    
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
        self.configuration = .bordered()
        self.configuration?.imagePadding = 5
        self.layer.cornerRadius = self.frame.height / 4
        self.clipsToBounds = true
        self.configuration?.buttonSize = .small
    }
    
    init<T: Likeble>(item: T) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        self.likes = item.likes
        self.isLiked = item.isLiked
        self.addTarget(self, action: #selector(self.updateLikeButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfig<T: Likeble>(for item: T){
        if item is NewsItem {
            self.type = .post
        } else {
            self.type = .photo
        }
        self.sourceID = item.sourceID
        self.id = item.id
        self.likes = item.likes
        self.isLiked = item.isLiked
        self.addTarget(self, action: #selector(self.updateLikeButton), for: .touchUpInside)
        self.configuration?.image = item.isLiked ? buttonStateImages.likeFill.image : buttonStateImages.like.image
        self.configuration?.baseForegroundColor = item.isLiked ? UIColor.red : UIColor.gray
        self.configuration?.title = item.likes == 0 ? "" : String(item.likes)
    }
    
    @objc private func updateLikeButton(){
        animationImageChange()
        self.likes = !self.isLiked ? self.likes + 1 : self.likes - 1
        self.isLiked.toggle()
        self.configuration?.image = self.isLiked ? buttonStateImages.likeFill.image : buttonStateImages.like.image
        self.configuration?.baseForegroundColor = self.isLiked ? UIColor.red : UIColor.gray
        self.configuration?.title = self.likes == 0 ? "" : String(self.likes)
//        self.isLiked ? self.likesNetwork(self.type, method: .likeAdd) : self.likesNetwork(self.type, method: .likeDelete)
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
    private func likesNetwork(_ type: LikebleType, method: Api.BaseURL.ApiMethod) {
        
        let params = ["type": type.rawValue,
                      "owner_id":String(self.sourceID),
                      "item_id": String(self.id),
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


