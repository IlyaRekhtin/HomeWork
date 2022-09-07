//
//  UIFont + extension.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 24.08.2022.
//

import Foundation
import UIKit

extension UIFont {
    static let headerTextFont = UIFont(name: "SFPro-Medium", size: 18)
    static let mainTextFont = UIFont(name: "SFPro-Regular", size: 18)
    static let subTextFont = UIFont(name: "SFPro-Regular", size: 16)
    static let minTextFont = UIFont(name: "SFPro-Regular", size: 14)
    
    func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
    }
}


