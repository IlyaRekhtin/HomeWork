//
//  Avatar.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 27.02.2022.
//

import UIKit
import SnapKit

class Avatar: UIView {

    private var foto = UIImageView()
    private let shadowLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfig()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImage(_ image: UIImage) {
        self.foto.contentMode = .scaleAspectFill
        self.foto.image = image
    }
    
    private func setConfig() {
        foto.layer.cornerRadius = self.frame.width / 2
        foto.clipsToBounds = true
        setShadow()
       
    }
    
    private func setConstraints() {
        addSubview(foto)
        foto.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setShadow() {
        shadowLayer.shadowColor = UIColor.gray.cgColor
        shadowLayer.shadowRadius = 3
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowPath = CGPath(ellipseIn: CGRect(x: foto.layer.position.x , y: foto.layer.position.y + 5, width: self.frame.width + 3, height: self.frame.height + 3), transform: nil)
       self.layer.addSublayer(shadowLayer)
    }
    
    
    
}
