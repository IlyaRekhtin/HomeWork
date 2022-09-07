
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
    
    var reposts: Int = 0
    var isReposted: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuration = .bordered()
        self.configuration?.imagePadding = 5
        self.layer.cornerRadius = self.frame.height / 4
        self.clipsToBounds = true
        self.configuration?.buttonSize = .small
    }
    
    init<T: Reposteble>(item: T) {
        super.init(frame: .zero)
        self.reposts = item.reposts
        self.isReposted = item.isReposted
        self.addTarget(self, action: #selector(updateLikeButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfig<T: Reposteble>(for item: T){
        self.reposts = item.reposts
        self.isReposted = item.isReposted
        self.addTarget(self, action: #selector(updateLikeButton), for: .touchUpInside)
        self.configuration?.image = item.isReposted ? buttonStateImages.repostsFill.image : buttonStateImages.reposts.image
        self.configuration?.baseForegroundColor = item.isReposted ? UIColor.darkGray : UIColor.gray
        self.configuration?.title = item.reposts == 0 ? "" : String(item.reposts)
    }
    
    @objc private func updateLikeButton(){
        animationImageChange()
        self.reposts = !self.isReposted ? self.reposts + 1 : self.reposts - 1
        self.isReposted.toggle()
        self.configuration?.image = self.isReposted ? buttonStateImages.repostsFill.image : buttonStateImages.reposts.image
        self.configuration?.baseForegroundColor = self.isReposted ? UIColor.darkGray : UIColor.gray
        self.configuration?.title = self.reposts == 0 ? "" : String(self.reposts)
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


