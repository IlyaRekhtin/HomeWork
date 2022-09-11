//
//  Avatar.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 27.02.2022.
//

import UIKit
import SnapKit

class AvatarView: UIView {
    
    var userPhoto : UIImageView = {
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
            shadowLayer.shadowPath = CGPath(ellipseIn: CGRect(x: self.userPhoto.layer.position.x , y: self.userPhoto.layer.position.y + 5, width: self.frame.width + 3, height: self.frame.height + 3), transform: nil)
            self.layer.addSublayer(self.shadowLayer)
    }
    
}
