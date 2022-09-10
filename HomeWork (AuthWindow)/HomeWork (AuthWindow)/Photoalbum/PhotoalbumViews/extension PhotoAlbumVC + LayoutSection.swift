//
//  extension FriendFotoCollectionView + LayoutSection.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.02.2022.
//

import Foundation
import UIKit


extension PhotoalbumViewController {
    
    func createSectionLayoutThreeOnLine() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width / 3),
                                              heightDimension:.absolute(self.view.frame.width / 3))
        let rigthItem = NSCollectionLayoutItem(layoutSize: itemSize)
        rigthItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 1)
        let centreItem = NSCollectionLayoutItem(layoutSize: itemSize)
        centreItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 1, bottom: 2, trailing: 1)
        let leftItem = NSCollectionLayoutItem(layoutSize: itemSize)
        leftItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 1, bottom: 2, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(self.view.frame.width / 3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [rigthItem, centreItem, leftItem])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
}


