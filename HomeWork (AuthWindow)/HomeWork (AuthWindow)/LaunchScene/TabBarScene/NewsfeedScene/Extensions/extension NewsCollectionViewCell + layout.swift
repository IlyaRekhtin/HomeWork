//
//  extension NewsCollectionViewCell + layout.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 21.03.2022.
//

import UIKit


extension PhotoNewsCell {
    
    func createLayoutForNewsImage() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension:.fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    func createLayoutForTwoNewsImages() -> NSCollectionLayoutSection {
        
        let firstItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                 heightDimension:.fractionalHeight(0.5))
        let firstItem = NSCollectionLayoutItem(layoutSize: firstItemSize)
        firstItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
        
        
       
        let secondItem = NSCollectionLayoutItem(layoutSize: firstItemSize)
        secondItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [firstItem, secondItem])
        
        let section = NSCollectionLayoutSection(group:group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    func createLayoutForThreeNewsImages() -> NSCollectionLayoutSection {
        
        let topItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                 heightDimension:.fractionalHeight(0.6))
        let topItem = NSCollectionLayoutItem(layoutSize: topItemSize)
        topItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
        
        
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                   heightDimension:.fractionalHeight(1))
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let smallItemLeft = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItemLeft.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2)
        
        
        let smallGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4))
        let smallGroup = NSCollectionLayoutGroup.horizontal(layoutSize: smallGroupSize, subitems: [smallItemLeft, smallItem])
        
        
        let largeGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let largeGroup = NSCollectionLayoutGroup.vertical(layoutSize: largeGroupSize, subitems: [topItem, smallGroup])
        

        let section = NSCollectionLayoutSection(group:largeGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    
    func createLayoutForFourNewsImages() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension:.fractionalHeight(1))
        let item1 = NSCollectionLayoutItem(layoutSize: itemSize)
        item1.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 2)
        let item2 = NSCollectionLayoutItem(layoutSize: itemSize)
        item2.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
        let item3 = NSCollectionLayoutItem(layoutSize: itemSize)
        item3.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2)
        let item4 = NSCollectionLayoutItem(layoutSize: itemSize)
        item4.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item1, item2, item3, item4])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    func createLayoutForFiveNewsImages() -> NSCollectionLayoutSection {
        
        let topItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension:.fractionalHeight(1))
        let topItem = NSCollectionLayoutItem(layoutSize: topItemSize)
        topItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
        
        let topGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: .fractionalHeight(0.75))
        
        let topGroup = NSCollectionLayoutGroup.horizontal(layoutSize: topGroupSize, subitems: [topItem])

        let bottomItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                              heightDimension:.fractionalHeight(1))
        let bottomItem = NSCollectionLayoutItem(layoutSize: bottomItemSize)
        bottomItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let bottomCentreItem = NSCollectionLayoutItem(layoutSize: bottomItemSize)
        bottomCentreItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2)
        
        let bottomGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: .fractionalHeight(0.25))
        let bottomGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bottomGroupSize, subitems: [bottomItem, bottomCentreItem, bottomCentreItem, bottomItem])
        
        let largeGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let largeGroup = NSCollectionLayoutGroup.vertical(layoutSize: largeGroupSize, subitems: [topGroup, bottomGroup])
        

        let section = NSCollectionLayoutSection(group:largeGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    func createLayoutForSixNewsImages() -> NSCollectionLayoutSection {
        
        let leftItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.67),
                                              heightDimension:.fractionalHeight(1))
        let leftItem = NSCollectionLayoutItem(layoutSize: leftItemSize)
        leftItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 2)
        
        
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension:.fractionalHeight(0.5))
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
        
        let smallGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
        let smallGroup = NSCollectionLayoutGroup.vertical(layoutSize: smallGroupSize, subitems: [smallItem, smallItem])
        
        let topGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: .fractionalHeight(0.67))
        let topGroup = NSCollectionLayoutGroup.horizontal(layoutSize: topGroupSize, subitems: [leftItem, smallGroup])

        let bottomItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3333),
                                              heightDimension:.fractionalHeight(1))
        let bottomItem = NSCollectionLayoutItem(layoutSize: bottomItemSize)
        bottomItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let bottomCentreItem = NSCollectionLayoutItem(layoutSize: bottomItemSize)
        bottomCentreItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2)
        
        let bottomGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        let bottomGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bottomGroupSize, subitems: [bottomItem, bottomCentreItem, bottomItem])
        
        let largeGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let largeGroup = NSCollectionLayoutGroup.vertical(layoutSize: largeGroupSize, subitems: [topGroup, bottomGroup])
        

        let section = NSCollectionLayoutSection(group:largeGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }

    
    
    
    
    
}
