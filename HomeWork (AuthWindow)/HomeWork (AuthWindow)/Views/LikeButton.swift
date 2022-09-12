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
    weak var item: Likeble?
    
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
        self.addTarget(self, action: #selector(self.updateLikeButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfig(for item: Likeble & Reposteble){
        if item is NewsItem {
            self.type = .post
        } else {
            self.type = .photo
        }
        self.item = item
        self.configuration?.image = item.isLiked ? buttonStateImages.likeFill.image : buttonStateImages.like.image
        self.configuration?.baseForegroundColor = item.isLiked ? UIColor.red : UIColor.gray
        self.configuration?.title = item.likes == 0 ? "" : String(item.likes)
    }
    
    @objc private func updateLikeButton(){
        animationImageChange()
        guard let item = item else {
            return
        }
        item.likes = !item.isLiked ? item.likes + 1 : item.likes - 1
        item.isLiked.toggle()
        self.configuration?.image = item.isLiked ? buttonStateImages.likeFill.image : buttonStateImages.like.image
        self.configuration?.baseForegroundColor = item.isLiked ? UIColor.red : UIColor.gray
        self.configuration?.title = item.likes == 0 ? "" : String(item.likes)
        item.isLiked ? self.likesNetwork(self.type, method: .likeAdd) : self.likesNetwork(self.type, method: .likeDelete)
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
        guard let item = self.item else {return}
        let params = ["type": type.rawValue,
                      "owner_id":String(item.sourceID),
                      "item_id": String(item.id),
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


