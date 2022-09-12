//
//  PhotoViewerLikeButton.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 13.09.2022.
//

import UIKit

final class PhotoViewerLikeButton: UIButton {
    
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
        self.configuration = .plain()
        self.configuration?.imagePadding = 5
        self.layer.cornerRadius = self.frame.height / 4
        self.clipsToBounds = true
        self.configuration?.buttonSize = .large
        self.addTarget(self, action: #selector(self.updateLikeButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfig(for item: Likeble & Reposteble){
        self.item = item
        self.configuration?.image = item.isLiked ? buttonStateImages.likeFill.image : buttonStateImages.like.image
        self.configuration?.baseForegroundColor = item.isLiked ? UIColor.red : UIColor.white
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
        item.isLiked ? self.likesNetwork(.likeAdd) : self.likesNetwork(.likeDelete)
    }
}
//MARK: - Animation for button
extension PhotoViewerLikeButton {
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
extension PhotoViewerLikeButton {
    private func likesNetwork(_ method: Api.BaseURL.ApiMethod) {
        guard let item = self.item else {return}
        let params = ["type": "photo",
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
