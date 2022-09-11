//
//  AvatarViewGroup.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 11.09.2022.
//

import UIKit

class AvatarViewGroup: UIView {
    var photo : UIImageView = {
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
    
    func setImage(_ image: UIImage) {
        self.photo.image = image
    }
}
//MARK: - private
private extension AvatarViewGroup {

    func setConfig() {
        photo.layer.cornerRadius = self.frame.width / 2
        setShadow()
        setConstraints()
        
    }
    
    func setConstraints() {
        addSubview(photo)
        photo.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func setShadow() {
            shadowLayer.shadowColor = UIColor.gray.cgColor
            shadowLayer.shadowRadius = 3
            shadowLayer.shadowOpacity = 1
            shadowLayer.shadowPath = CGPath(ellipseIn: CGRect(x: self.photo.layer.position.x , y: self.photo.layer.position.y + 5, width: self.frame.width + 3, height: self.frame.height + 3), transform: nil)
            self.layer.addSublayer(self.shadowLayer)
    }
    
}

