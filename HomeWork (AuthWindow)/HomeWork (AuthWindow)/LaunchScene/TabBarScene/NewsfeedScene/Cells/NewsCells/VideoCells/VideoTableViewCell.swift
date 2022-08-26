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
    
    var videos = [VideoViewModel]() {
        didSet{
            reloadData()
        }
    }
    
    private var videoCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, VideoViewModel>!
    private let layout = MediaNewsLayout()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        createDataSourse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(for video: [VideoViewModel]) {
        setConstraints()
        self.videos = video
    }
    
    
}
//MARK: - CollectionView
 extension VideoTableViewCell {
    //    //MARK: - Setup collectionView
    func setupCollectionView() {
        videoCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.layer.frame.width, height: self.layer.frame.width), collectionViewLayout: createCompositionLayout())
        videoCollectionView.delegate = self
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
            
            switch self.videos.count {
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
        dataSource = UICollectionViewDiffableDataSource<Int, VideoViewModel>(collectionView: self.videoCollectionView,
                                                                    cellProvider: { (collectionView, indexPuth, model) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.reuseID, for: indexPuth) as! VideoCollectionViewCell
            let currentVideo = self.videos[indexPuth.row]
            cell.config(for: currentVideo)
            return cell
        })
    }
    
    func reloadData(){
        var snapShot = NSDiffableDataSourceSnapshot<Int, VideoViewModel>()
        snapShot.appendSections([1])
        snapShot.appendItems(videos)
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
