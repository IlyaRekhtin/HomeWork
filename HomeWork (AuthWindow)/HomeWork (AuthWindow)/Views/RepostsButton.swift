
import UIKit

class RepostsButton: UIButton {
    /// images enum
    private enum buttonStateImages: String {
        case reposts
        case repostsFill
        
        var image: UIImage? {
            switch self {
            case .reposts:
                return UIImage(systemName: "arrowshape.turn.up.right")
            case .repostsFill:
                return UIImage(systemName: "arrowshape.turn.up.right.fill")
            }
        }
    }
    
    func setConfig<T: Reposteble>(for item: T){
        guard let reposts = item.reposts else {return}
        self.configuration?.image = reposts.userReposted == 1 ? buttonStateImages.repostsFill.image : buttonStateImages.reposts.image
        self.configuration?.baseForegroundColor = reposts.userReposted == 1 ? UIColor.darkGray : UIColor.gray
        self.configuration?.title = reposts.count == 0 ? "" : String(reposts.count)
        self.configuration?.imagePadding = 5
    }
    
    func updateLikeButton<T: Reposteble>(for item: T){
        animationImageChange()
        guard let reposts = item.reposts else {return}
        reposts.count = reposts.userReposted == 1 ? reposts.count - 1 : reposts.count + 1
        reposts.userReposted = reposts.userReposted == 1 ? 0 : 1
        self.configuration?.image = reposts.userReposted == 1 ? buttonStateImages.repostsFill.image : buttonStateImages.reposts.image
        self.configuration?.baseForegroundColor = reposts.userReposted == 1 ? UIColor.darkGray : UIColor.gray
        self.configuration?.title = reposts.count == 0 ? "" : String(reposts.count)
//        likes.userLikes == 1 ? self.repost(for: photo, .likeAdd) : self.repost(for: photo, .likeDelete)
    }
}
//MARK: - Animation for button
extension RepostsButton {
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
extension RepostsButton {
    func repost(for photo: Photo, _ method: Api.BaseURL.ApiMethod) {
        let params = ["type": "photo",
                      "owner_id": String(photo.ownerID),
                      "item_id": String(photo.id),
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


