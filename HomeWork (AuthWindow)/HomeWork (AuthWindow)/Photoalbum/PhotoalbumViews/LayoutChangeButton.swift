//
//  SectionHeaderReusableView.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 01.03.2022.
//

import UIKit
import SnapKit

class LayoutChangeButton: UIBarButtonItem {
    
    enum FotoSizeInCollectionView: Int {
        case fullScreen
        case treeOnLine
    }
    
    var sizeInCollectionView: FotoSizeInCollectionView = .fullScreen
 
    
    static func getButtonImage(forSize size: FotoSizeInCollectionView) -> UIImage {
        var image = UIImage()
        switch size{
        case .fullScreen:
            image = UIImage(systemName: "rectangle.grid.2x2")!
        case .treeOnLine:
            image = UIImage(systemName: "rectangle")!
        }
        return image
    }
}
