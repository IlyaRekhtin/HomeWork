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
    private var lable: String = "0"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfig<T:Likeble>(for foto: T) {
        self.configuration?.image = foto.myLike ? imageLikeFill : imageLike
        self.configuration?.title = String(foto.likesCount)
//        self.configuration?.baseForegroundColor = .white
        self.configuration?.imagePadding = 5
    }
    
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
