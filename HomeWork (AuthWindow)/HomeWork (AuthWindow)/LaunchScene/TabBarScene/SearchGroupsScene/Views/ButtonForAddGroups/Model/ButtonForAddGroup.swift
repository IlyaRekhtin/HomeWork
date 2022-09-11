//
//  File.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 02.06.2022.
//

import Foundation
import UIKit

final class ButtonForAddGroup: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .systemGreen
        config.buttonSize = .mini
        self.configuration = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
