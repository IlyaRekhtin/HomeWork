//
//  Avatar.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 27.02.2022.
//

import UIKit
import SnapKit
import Kingfisher

class AvatarView: UIView {
    
    private var userPhoto : UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        return imageView
    }()
    private let shadowLayer = CAShapeLayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(_ url: URL) {
        self.userPhoto.contentMode = .scaleAspectFill
        self.userPhoto.kf.indicatorType = .activity
        self.userPhoto.kf.setImage(with: url) { result in
            switch result {
            case .success(_):
                self.shadowOn()
            case .failure(let error):
                print(error.errorDescription ?? "")
            }
        }
       
    }
    
    func shadowOff() {
        shadowLayer.isHidden = true
    }
    
    func shadowOn() {
        shadowLayer.isHidden = false
    }
    
    func imageHigth() -> CGFloat {
        return userPhoto.frame.height
    }
    
}
//MARK: - private
private extension AvatarView {
    
    func setConfig() {
        userPhoto.layer.cornerRadius = self.frame.width / 2
        setShadow()
        setConstraints()
        
    }
    
    func setConstraints() {
        addSubview(userPhoto)
        userPhoto.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func setShadow() {
        shadowLayer.shadowColor = UIColor.gray.cgColor
        shadowLayer.shadowRadius = 3
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowPath = CGPath(ellipseIn: CGRect(x: userPhoto.layer.position.x , y: userPhoto.layer.position.y + 5, width: self.frame.width + 3, height: self.frame.height + 3), transform: nil)
        self.layer.addSublayer(shadowLayer)
        shadowOff()
        
    }
    
}
