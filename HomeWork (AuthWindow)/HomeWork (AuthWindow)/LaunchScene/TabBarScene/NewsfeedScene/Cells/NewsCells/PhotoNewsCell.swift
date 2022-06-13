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
    
    var photos = [Photo]()
    var currentSizePhotos = [URL]()
    
    var photoNewsfeedCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, Photo>!
    var delegate: PhotoNewsCellDelegate?
    
    
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
        setConstraints()
        self.photos = photos
        self.currentSizePhotos = Photo.getURLForPhotos(photos)
        reloadData()
    }
    
    
}
//MARK: - CollectionView
 extension PhotoNewsCell {
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
        snapShot.appendItems(photos)
        dataSource.apply(snapShot)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cellCollectionItemTapped(cell: self)
        
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

