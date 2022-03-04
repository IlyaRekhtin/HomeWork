//
//  SectionHeaderReusableView.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 01.03.2022.
//

import UIKit
import SnapKit

class ButtonForChangeLayout: UIBarButtonItem {
    
    var state = 0

    override init() {
        super.init()
        setupForButton()
    }
    
    convenience init(forState state: Int) {
        self.init()
        self.state = state
        setImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupForButton() {
        self.tintColor = .systemGreen
        self.action = #selector(actionForButton)
    }
    
    private func setImage(){
        switch state {
        case 0:
            self.image = UIImage(systemName: "rectangle.grid.2x2")
        case 1:
            self.image = UIImage(systemName: "rectangle")
        default:
            break
        }
    }
    
    @objc func actionForButton() {
        switch state {
        case 0:
            state += 1
            self.image = UIImage(systemName: "rectangle")
        case 1:
            state -= 1
            self.image = UIImage(systemName: "rectangle.grid.2x2")
        default:
            break
        }
        let myVC = FriendFotoCollectionViewController()
        myVC.reloadInputViews()
    }
    
}
