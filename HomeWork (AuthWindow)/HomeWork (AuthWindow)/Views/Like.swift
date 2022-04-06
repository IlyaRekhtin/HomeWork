//
//  like.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 28.02.2022.
//

import UIKit

class Like: UIButton {

    private var imageLike = UIImage(systemName: "heart")
    private var imageLikeFill = UIImage(systemName: "heart.fill")
    
    private var likeCount: Int = 0
    
   
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfig<T:Likeble>(for foto: T) {
        self.configuration?.image = foto.myLike ? imageLikeFill : imageLike
        self.configuration?.baseForegroundColor = foto.myLike ? UIColor.red : UIColor.gray
        self.likeCount = foto.myLike ? 1 : 0
        self.likeCount += foto.likesCount
        self.configuration?.title = String(likeCount)
//        self.configuration?.baseForegroundColor = .white
        self.configuration?.imagePadding = 5
    }
    
     func animationImageChange() {
         let animation = CASpringAnimation(keyPath: "position.y")
         animation.fromValue = self.layer.position.y - 5
         animation.toValue = self.layer.position.y
         animation.duration = 0.5
         animation.stiffness = 1000
         animation.mass = 0.5
         
         
         self.layer.add(animation, forKey: nil)
        
    }
    
    
    
//    @objc func actionForButton() {
//        switch self.stateValue {
//        case true:
//            self.configuration?.image = UIImage(systemName: "heart")
//            self.stateValue.toggle()
//            self.likeCount += 1
//        case false:
//            self.configuration?.image = UIImage(systemName: "heart.fill")
//            self.stateValue.toggle()
//            self.likeCount -= 1
//        }
//
//    }
    
    func changeValue<T:Likeble>(for foto: T) {
        switch foto.myLike {
        case true:
            self.configuration?.image = UIImage(systemName: "heart")
            self.configuration?.title = String(foto.likesCount)
        case false:
            self.configuration?.image = UIImage(systemName: "heart.fill")
            self.configuration?.title = String(foto.likesCount)
        }
        
    }
    
    
}
