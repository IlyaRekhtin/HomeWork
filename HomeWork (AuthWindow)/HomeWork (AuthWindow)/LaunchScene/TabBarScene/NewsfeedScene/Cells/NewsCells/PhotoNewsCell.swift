//
//  PhotoNewsCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

final class PhotoNewsCell: UITableViewCell, UICollectionViewDelegate {
    
    static let reuseID = "photoNewsCell"
    
    private var images = [Photo]()
    private var currentSizePhotos = [URL]()
    
    var photoNewsfeedCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, Photo>!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        self.photoNewsfeedCollectionView.delegate = self
        createDataSourse()
        setConstreints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK: - CollectionView
private extension PhotoNewsCell {
    //    //MARK: - Setup collectionView
    func setupCollectionView() {
        photoNewsfeedCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.layer.frame.width, height: self.layer.frame.width), collectionViewLayout: createCompositionLayout())
        photoNewsfeedCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        photoNewsfeedCollectionView.isScrollEnabled = false
        photoNewsfeedCollectionView.showsHorizontalScrollIndicator = false
        photoNewsfeedCollectionView.showsVerticalScrollIndicator = false
        photoNewsfeedCollectionView.delegate = self
        photoNewsfeedCollectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.reuseID)
    }
    
    //    //MARK: - create composition layout
    func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, collectionEnvironment) -> NSCollectionLayoutSection? in
            
            switch self.currentSizePhotos.count {
            case 1:
                return self.createLayoutForNewsImage()
            case 2...3:
                return self.createLayoutForTwoToThreeNewsImages()
            case 4:
                return self.createLayoutForFourNewsImages()
            case 5...6:
                return self.createLayoutForFiveToSixNewsImages()
            default:
                return self.createLayoutForNewsImage()
            }
        }
        return layout
    }
    //    //MARK: - create Data Source
    func createDataSourse() {
        dataSource = UICollectionViewDiffableDataSource<Int, Photo>(collectionView: self.photoNewsfeedCollectionView,
                                                                    cellProvider: { (collectionView, indexPuth, model) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.reuseID, for: indexPuth) as! ImagesCollectionViewCell
            cell.config(self.currentSizePhotos[indexPuth.row])
            return cell
        })
    }
    
    func reloadData(){
        var snapShot = NSDiffableDataSourceSnapshot<Int, Photo>()
        snapShot.appendSections([1])
        snapShot.appendItems(images)
        dataSource.apply(snapShot)
    }
}