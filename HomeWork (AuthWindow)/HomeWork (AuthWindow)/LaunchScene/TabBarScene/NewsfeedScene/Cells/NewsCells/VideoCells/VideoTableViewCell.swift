//
//  VideoTableViewCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 14.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

final class VideoTableViewCell: UITableViewCell, UICollectionViewDelegate {
    
    static let reuseID = "videoTableViewCell"
    
    var video = [Video]()
    var currentSizePhotos = [URL]()
    
    var videoCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, Video>!
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        self.videoCollectionView.delegate = self
        createDataSourse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(for video: [Video]) {
        setConstraints()
        self.video = video
        reloadData()
    }
    
    
}
//MARK: - CollectionView
 extension VideoTableViewCell {
    //    //MARK: - Setup collectionView
    func setupCollectionView() {
        videoCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.layer.frame.width, height: self.layer.frame.width), collectionViewLayout: createCompositionLayout())
        videoCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        videoCollectionView.isScrollEnabled = false
        videoCollectionView.showsHorizontalScrollIndicator = false
        videoCollectionView.showsVerticalScrollIndicator = false
        videoCollectionView.delegate = self
        videoCollectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.reuseID)
    }
    
    //    //MARK: - create composition layout
    func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, collectionEnvironment) -> NSCollectionLayoutSection? in
            
            switch self.video.count {
            case 1:
                return self.createLayoutForNewsImage()
            case 2:
                return self.createLayoutForTwoNewsImages()
            case 3:
                return self.createLayoutForThreeNewsImages()
            case 4:
                return self.createLayoutForFourNewsImages()
            case 5:
                return self.createLayoutForFiveNewsImages()
            case 6:
                return self.createLayoutForSixNewsImages()
            default:
                return self.createLayoutForNewsImage()
            }
        }
        return layout
    }
    //    //MARK: - create Data Source
    func createDataSourse() {
        dataSource = UICollectionViewDiffableDataSource<Int, Video>(collectionView: self.videoCollectionView,
                                                                    cellProvider: { (collectionView, indexPuth, model) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.reuseID, for: indexPuth) as! VideoCollectionViewCell
            let currentVideo = self.video[indexPuth.row]
            cell.config(for: currentVideo)
            return cell
        })
    }
    
    func reloadData(){
        var snapShot = NSDiffableDataSourceSnapshot<Int, Video>()
        snapShot.appendSections([1])
        snapShot.appendItems(video)
        dataSource.apply(snapShot)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
}
//MARK: - make constraints
private extension VideoTableViewCell {
    func setConstraints() {
        self.contentView.addSubview(videoCollectionView)
        videoCollectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
            make.height.equalTo(self.videoCollectionView.frame.height)
        }
    }
}

//MARK: - layout
extension VideoTableViewCell {
    
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
