//
//  addGroupButton.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 13.03.2022.
//

import UIKit
import SnapKit

class ButtonForAddGroup: UIButton {
    
    enum imageForButton {
        case groupIsAddImage
        case groupIsNotAddImage
        
        var image: UIImage {
            switch self {
            case .groupIsNotAddImage: return UIImage(systemName: "plus")!
            case .groupIsAddImage: return UIImage(systemName: "checkmark")!
            }
        }
        
    }
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config() {
        self.configuration = .plain()
        self.tintColor = .systemGreen
        
    }

}
