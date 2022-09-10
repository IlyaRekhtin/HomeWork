//
//  SectionHeaderReusableView.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 01.03.2022.
//

import UIKit


class LayoutChangeButton: UIBarButtonItem {
    
    enum PhotoSizeInCollectionView: Int {
        case fullScreen
        case treeOnLine
    }
    
    var layoutFlag: PhotoSizeInCollectionView = .fullScreen
    
    static func getButtonImage(for variant: PhotoSizeInCollectionView) -> UIImage {
        var image = UIImage()
        switch variant{
        case .fullScreen:
            image = UIImage(systemName: "rectangle.grid.2x2")!
        case .treeOnLine:
            image = UIImage(systemName: "rectangle")!
        }
        return image
    }
}
