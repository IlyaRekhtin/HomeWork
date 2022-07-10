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
    
    var photos = [Photo](){
        didSet {
            self.reloadData()
        }
    }
    
    var photoNewsfeedCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Photo>!
    private let layout = MediaNewsLayout()
//    var delegate: NewsfeedItemTapped?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        self.photoNewsfeedCollectionView.delegate = self
        createDataSourse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(for photos: [Photo]) {
        
        self.photos = photos
        setConstraints()
    }
}
//MARK: - CollectionView
 extension PhotoNewsCell {
    //    //MARK: - Setup collectionView
    func setupCollectionView() {
        photoNewsfeedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionLayout())
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
            
            switch self.photos.count {
            case 1:
                return self.layout.createLayoutForNewsImage()
            case 2:
                return self.layout.createLayoutForTwoNewsImages()
            case 3:
                return self.layout.createLayoutForThreeNewsImages()
            case 4:
                return self.layout.createLayoutForFourNewsImages()
            case 5:
                return self.layout.createLayoutForFiveNewsImages()
            case 6:
                return self.layout.createLayoutForSixNewsImages()
            default:
                return self.layout.createLayoutForNewsImage()
            }
        }
        return layout
    }
    //    //MARK: - create Data Source
    func createDataSourse() {
        dataSource = UICollectionViewDiffableDataSource<Int, Photo>(collectionView: self.photoNewsfeedCollectionView,
                                                                    cellProvider: { (collectionView, indexPuth, model) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.reuseID, for: indexPuth) as! ImagesCollectionViewCell
            cell.config(self.photos[indexPuth.row])
            return cell
        })
    }
    
    func reloadData(){
        var snapShot = NSDiffableDataSourceSnapshot<Int, Photo>()
        snapShot.appendSections([1])
        snapShot.appendItems(photos)
        dataSource.apply(snapShot)
    }
    
     
     
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.newsfeedItemTapped(cell: self)
    }
}
//MARK: - make constraints
private extension PhotoNewsCell {
    func setConstraints() {
        self.contentView.addSubview(photoNewsfeedCollectionView)
        photoNewsfeedCollectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
            
            make.height.equalTo(self.photoNewsfeedCollectionView.frame.height)
        }
    }
}

