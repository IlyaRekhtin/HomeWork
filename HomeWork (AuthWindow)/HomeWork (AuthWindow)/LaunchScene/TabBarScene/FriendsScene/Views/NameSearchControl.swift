//
//  NameSearchControl.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 05.03.2022.
//

import UIKit
import SnapKit
import RealmSwift


class NameSearchControl: UIControl {
    
    private var stackView: UIStackView = {
       let stackView = UIStackView()
       stackView.axis = .vertical
       stackView.alignment = .center
       stackView.distribution = .fillEqually
       stackView.spacing = 5
       return stackView
     }()
    
    var letters = [UILabel]()
    
    var indexPuth: IndexPath? = nil {
        didSet {
            sendActions(for: .touchCancel)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.config()
    }

    private func config() {
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
   
    func addButtonsForControl(for arrayButtons: [UILabel]) {
        for letter in letters {
            stackView.addArrangedSubview(letter)
        }
    }
}

//MARK: - touches settings
extension NameSearchControl {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let letterLocation = touches.first?.location(in: self)
        letters.forEach { $0.alpha = $0.frame.contains(letterLocation!) ? 0.5 : 1 }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let letterLocation = touches.first?.location(in: self)
        letters.forEach { $0.alpha = $0.frame.contains(letterLocation!) ? 0.5 : 1 }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let letterLocation = touches.first?.location(in: self)
        for (index, letter) in letters.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            if letter.frame.contains(letterLocation!) {
                self.indexPuth = indexPath
                letter.alpha = 1
            }
        }
    }
}
