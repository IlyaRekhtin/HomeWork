//
//  NewsCollectionViewCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 18.03.2022.
//

import UIKit
import SnapKit
import RealmSwift

class NewsfeedTableViewCell: UITableViewCell, UICollectionViewDelegate {
    
    static let reuseID = "newsfeed"
    
    
    private var headerNewsView = HeaderNewsView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    
    private var newsfeedText : UILabel = {
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        lable.font = UIFont(name: "Times New Roman", size: 17)
        lable.numberOfLines = 0
        return lable
    }()
    
    private var likeButton: LikeButton = {
        let button = LikeButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
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
    private var imagesURL = [URL]()
    
    var photoNewsfeedCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, Photo>!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        createDataSourse()
        setConstreints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurationCell(with news: News) {
        
        var userAvatarStringUrl = String()
        var userName = String()
        let groups = DataManager.data.readFromDatabase(Group.self)
        let profiles = DataManager.data.readFromDatabase(Friend.self)
        switch news.sourceID {
        case ..<0:
            groups.forEach { group in
                if news.sourceID == -group.id {
                    userAvatarStringUrl = group.photo50
                    userName = group.name
                }
            }
        default:
            profiles.forEach { user in
                if news.sourceID == user.id {
                    userAvatarStringUrl = user.photo50
                    userName = user.firstName + " " + user.lastName
                }
            }
        }
        headerNewsView.setValue(userAvatarStringUrl, userName)
        ///добавляем массив фотографий из news
        if news.photos != nil {
            images = Array(news.photos!.items)
        }
        imagesURL = DataManager.data.getPhotoUrl(with: .x, for: images)
        newsfeedText.text = news.text
        if newsfeedText.text == nil {
            newsfeedText.snp.updateConstraints { make in
                make.top.equalTo(self.headerNewsView.snp.bottom).offset(10)
                make.right.left.equalToSuperview().inset(10)
                make.height.equalTo(0)
            }
        }
        
        
        likeButton.setConfig(for: news)
        likeButton.addAction(UIAction(handler: { _ in
            
            
        }), for: .touchUpInside)
        
        
        reloadData()
    }
}


//MARK: - CollectionView
private extension NewsfeedTableViewCell {
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
            
            switch self.imagesURL.count {
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
            cell.config(self.imagesURL[indexPuth.row])
            
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
private extension NewsfeedTableViewCell {
    
    func setConstreints() {
        self.contentView.addSubview(headerNewsView)
        headerNewsView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(3)
            make.left.right.equalToSuperview()
        }
        
        self.contentView.addSubview(newsfeedText)
        newsfeedText.snp.makeConstraints { make in
            make.top.equalTo(self.headerNewsView.snp.bottom).offset(10)
            make.right.left.equalToSuperview().inset(10)
            make.height.equalTo(100)
        }
        self.contentView.addSubview(photoNewsfeedCollectionView)
        photoNewsfeedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.newsfeedText.snp.bottom).offset(5)
            make.right.left.equalToSuperview()
            make.height.equalTo(self.photoNewsfeedCollectionView.frame.height)
        }
        
        self.contentView.addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(self.photoNewsfeedCollectionView.snp.bottom).offset(5)
            make.left.equalToSuperview()
            make.height.equalTo(self.likeButton.frame.height)
        }
        self.contentView.addSubview(separateView)
        separateView.snp.makeConstraints { make in
            make.top.equalTo(self.likeButton.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

