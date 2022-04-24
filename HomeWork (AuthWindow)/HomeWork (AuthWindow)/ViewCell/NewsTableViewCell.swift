//
//  NewsCollectionViewCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 18.03.2022.
//

import UIKit
import SnapKit

class NewsTableViewCell: UITableViewCell, UICollectionViewDelegate {
    
    static let reuseID = "news"

    private var headerNewsView = HeaderNewsView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    
    private var newsView : UILabel = {
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        lable.font = UIFont(name: "Times New Roman", size: 17)
        lable.numberOfLines = 0
        return lable
    }()
    
    private var like: LikeButton = {
        let button = LikeButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.configuration = .gray()
        button.layer.cornerRadius = button.frame.height / 3
        button.clipsToBounds = true
        return button
    }()
    
    private let separateView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 5))
        view.backgroundColor = .opaqueSeparator
        return view
    }()
    
    private var images = [Photo]()
    
    var newsfeed = Newsfeed()
    var photoNewsfeedCollectionView = UICollectionView()
    var dataSource: UICollectionViewDiffableDataSource<Int, Photo>!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        createDataSourse()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurationCell(_ newsfeed: Newsfeed) {
        
//        headerNewsView.setValue(news.person.avatar, news.person.name)
//        newsView.text = news.newsText
//
//        images = self.news.newsImages ?? []
//
//        like.setConfig(for: self.news)
//
//        like.addAction(UIAction(handler: { _ in
//            self.news.myLike.toggle()
//            self.like.animationImageChange()
//            self.like.setConfig(for: self.news)
//
//            // TODO go to server change
//
//        }), for: .touchUpInside)
//
//
//        reloadData()
//
//        setConstreints(self.news)
    }
}


//MARK: - CollectionView
private extension NewsTableViewCell {
    //MARK: - Setup collectionView
    func setupCollectionView() {
        photoNewsfeedCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.layer.frame.width, height: self.layer.frame.width), collectionViewLayout: createCompositionLayout())
        photoNewsfeedCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        photoNewsfeedCollectionView.isScrollEnabled = false
        photoNewsfeedCollectionView.showsHorizontalScrollIndicator = false
        photoNewsfeedCollectionView.showsVerticalScrollIndicator = false
        photoNewsfeedCollectionView.delegate = self
        photoNewsfeedCollectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.reuseID)
    }
    
    //MARK: - create composition layout
    func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, collectionEnvironment) -> NSCollectionLayoutSection? in
            
            switch self.images.count {
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
    //MARK: - create Data Source
    func createDataSourse() {
        dataSource = UICollectionViewDiffableDataSource<Int, Photo>(collectionView: self.photoNewsfeedCollectionView,
                                                                         cellProvider: { (collectionView, indexPuth, model) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.reuseID, for: indexPuth) as! ImagesCollectionViewCell
            cell.config(self.images[indexPuth.row])
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

//MARK: - Constraints
private extension NewsTableViewCell {
    
    func setConstreints() {
        self.contentView.addSubview(headerNewsView)
        headerNewsView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(self.headerNewsView.frame.height)
        }
        
//        if news.newsText != nil {
            self.contentView.addSubview(newsView)
            newsView.snp.makeConstraints { make in
                make.top.equalTo(headerNewsView.snp.bottom).offset(10)
                make.left.right.equalToSuperview().inset(10)
            }
//        }
        
        if !images.isEmpty {
            self.contentView.addSubview(photoNewsfeedCollectionView)
            photoNewsfeedCollectionView.snp.makeConstraints { make in
//                if news.newsText != nil {
//                    make.top.equalTo(self.newsView.snp.bottom).offset(3)
//                } else {
                    make.top.equalTo(self.headerNewsView.snp.bottom).offset(3)
//                }
                make.left.right.equalToSuperview()
                make.height.equalTo(self.photoNewsfeedCollectionView.frame.height)
            }
        }
        
        self.contentView.addSubview(like)
        like.snp.makeConstraints { make in
            if !images.isEmpty {
                make.top.equalTo(self.photoNewsfeedCollectionView.snp.bottom).offset(5)
            } else {
                make.top.equalTo(self.newsView.snp.bottom).offset(5)
            }
            make.left.equalToSuperview().inset(5)
        }

        self.contentView.addSubview(separateView)
        separateView.snp.makeConstraints { make in
            make.top.equalTo(self.like.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(self.separateView.frame.height)
        }
    }
    
}
