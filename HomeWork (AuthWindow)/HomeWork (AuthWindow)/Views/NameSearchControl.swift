//
//  NameSearchControl.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 05.03.2022.
//

import UIKit
import SnapKit


class NameSearchControl: UIControl {
    
   private var stackView: UIStackView = {
       let stackView = UIStackView()
       stackView.axis = .vertical
       stackView.alignment = .center
       stackView.distribution = .fillEqually
       stackView.spacing = 2
       
       return stackView
    }()
    
    private var buttons = [UIButton]()
    private var arrayOfLetter = DataBase.data.getFirstLettersOfTheName()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.config()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.config()
    }
    

    private func config() {
        for letter in arrayOfLetter {
            let button = UIButton(type: .roundedRect)
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            button.layer.cornerRadius = button.frame.width / 2
            button.setTitle(letter, for: .normal)
            button.setTitleColor(.systemGreen, for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.addTarget(self, action: #selector(selectLetter), for: .touchUpInside)
            self.buttons.append(button)
        }
        for button in buttons {
            stackView.addArrangedSubview(button)
        }
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    
    
    
    @objc private func selectLetter(_ sender: UIButton) {
       
    }
    
    
    private func setConstraints() {
        
    }
    
}
