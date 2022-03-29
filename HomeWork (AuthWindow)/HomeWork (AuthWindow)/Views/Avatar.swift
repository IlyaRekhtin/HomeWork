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
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateFoto))
        self.addGestureRecognizer(tapRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImage(_ image: UIImage) {
        self.foto.contentMode = .scaleAspectFill
        self.foto.image = image
    }
    
    @objc private func animateFoto() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut) {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
        }
        self.transform = .identity
        
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
    
    func offShadow() {
        shadowLayer.isHidden = true
    }
    
    func onShadow() {
        shadowLayer.isHidden = false
    }
    
    func imageHigth() -> CGFloat {
        return foto.frame.height
    }
    
}
