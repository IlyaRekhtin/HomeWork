//
//  NewsfeedCollectionViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 09.07.2022.
//

import UIKit
import SnapKit
import PromiseKit

fileprivate enum NewsItemType: Hashable {
    case text(String)
    case audio(Audio)
    case doc(Doc)
    case link(Link)
    case photo(Photo)
    case video(Video)
    case poll(Poll)
    case live(String)
}

final class NewsfeedCollectionViewController: UIViewController {
    
    private var newsfeedCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<NewsItem, NewsItemType>!
    private var newsfeedNewxtFrom: String = ""
    private var newsItems = [NewsItem]()
    private let service = NewsfeedService()
    
    override func loadView() {
        super.loadView()
        loadNewsfeed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationController()
        setupCollectionView()
        setConstraints()
    }
    
    private func configNavigationController(){
        navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.standardAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.backButtonTitle = ""
        tabBarController?.tabBar.isHidden = false
    }
    
}

//MARK: - load data
private extension NewsfeedCollectionViewController {
    private func loadNewsfeed(){
        service.getURL()
            .then(on: .global(), service.fetchData(_:))
            .then(on: .global(), service.parsedData(_:))
            .done(on: .main) { [weak self] newsfeed in
                guard let self = self else { return }
                self.newsfeedNewxtFrom = newsfeed.nextFrom ?? ""
                self.createNewsItem(for: newsfeed)
                self.reloadData()
//                self.newsfeedStartDate = String(newsfeed.items.first?.date ?? 0)
            }.catch { error in
                print(error.localizedDescription)
            }
    }
    
    func createNewsItem(for newsfeed: Newsfeed) {
        for news in newsfeed.items {
            if news.sourceID < 0 {
                guard let group = newsfeed.groups.filter({-$0.id == news.sourceID}).first else {return}
                let newsItem = NewsItem(news: news, group: group)
                self.newsItems.append(newsItem)
            } else {
//                guard let profile = newsfeed.profiles.filter({$0.id == news.sourceID}).first else {return}
//                let newsItem = NewsItem(news: news, profile: profile)
//                self.newsItems.append(newsItem)
            }
        }
    }
}

//MARK: - CollectionView
extension NewsfeedCollectionViewController: UICollectionViewDelegate {
    //    //MARK: - Setup collectionView
    func setupCollectionView() {
        self.newsfeedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionLayout())
        self.newsfeedCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.newsfeedCollectionView.showsHorizontalScrollIndicator = false
        self.newsfeedCollectionView.showsVerticalScrollIndicator = false
        self.newsfeedCollectionView.delegate = self
        self.newsfeedCollectionView.register(TextNewsCell.self, forCellWithReuseIdentifier: TextNewsCell.reuseID)
        self.newsfeedCollectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.reuseID)
        self.newsfeedCollectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseID)
        self.newsfeedCollectionView.register(DocViewCell.self, forCellWithReuseIdentifier: DocViewCell.reuseID)
        self.newsfeedCollectionView.register(LinkNewsCell.self, forCellWithReuseIdentifier: LinkNewsCell.reuseID)
        self.newsfeedCollectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.reuseID)
    }
    
    //    //MARK: - create composition layout
    func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, collectionEnvironment) -> NSCollectionLayoutSection? in
            self.createCollectionLayoutSection()
        }
        return layout
    }
    //    //MARK: - create Data Source
    func createDataSourse() {
        dataSource = UICollectionViewDiffableDataSource<NewsItem, NewsItemType>(collectionView: self.newsfeedCollectionView,
                                                                                cellProvider: { (collectionView, indexPuth, newsItemType) -> UICollectionViewCell? in
            
            switch newsItemType {
            case .text(let text):
                let textCell = collectionView.dequeueReusableCell(withReuseIdentifier: TextNewsCell.reuseID, for: indexPuth) as! TextNewsCell
                textCell.configCell(for: text)
                return textCell
            case .audio(_):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseID, for: indexPuth) as! Cell
                return cell
            case .doc(let doc):
                let docCell = collectionView.dequeueReusableCell(withReuseIdentifier: DocViewCell.reuseID, for: indexPuth) as! DocViewCell
                docCell.configCell(for: doc)
                return docCell
            case .link(let link):
                let linkCell = collectionView.dequeueReusableCell(withReuseIdentifier: LinkNewsCell.reuseID, for: indexPuth) as! LinkNewsCell
                linkCell.configCell(for: link)
                return linkCell
            case .photo(let photo):
                let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.reuseID, for: indexPuth) as! ImagesCollectionViewCell
                imageCell.config(photo)
                return imageCell
            case .video(let video):
                let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.reuseID, for: indexPuth) as! VideoCollectionViewCell
                videoCell.config(for: video)
                return videoCell
            case .poll(_):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseID, for: indexPuth) as! Cell
                return cell
            case .live(_):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseID, for: indexPuth) as! Cell
                return cell
            }
        })
    }
    
    func reloadData(){
        var snapShot = NSDiffableDataSourceSnapshot<NewsItem, NewsItemType>()
        snapShot.appendSections(newsItems)
        
        for newsItem in newsItems {
            snapShot.appendItems([.text(newsItem.item.text ?? "")])
            switch newsItem.item.postType {
            case .post:
                guard let attachments = newsItem.item.attachments else {return}
                for attachment in attachments {
                    switch attachment.type {
                    case .photo:
                        guard let photo = attachment.photo else {return}
                        snapShot.appendItems([.photo(photo)])
                    case .audio:
                        guard let audio = attachment.audio else {return}
                        snapShot.appendItems([.audio(audio)])
                    case .doc:
                        guard let doc = attachment.doc else {return}
                        snapShot.appendItems([.doc(doc)])
                    case .link:
                        guard let link = attachment.link else {return}
                        snapShot.appendItems([.link(link)])
                    case .video:
                        guard let video = attachment.video else {return}
                        snapShot.appendItems([.video(video)])
                    case .live: break
                    case .poll: break
                    case .none: break
                    }
                }
            case .photo:
                guard let photos = newsItem.item.photos else {return}
                for photo in photos.items {
                    snapShot.appendItems([.photo(photo)])
                }
                
            case .none:
                break
            }
        }
        dataSource.apply(snapShot)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: - layout
private extension NewsfeedCollectionViewController {
    func createCollectionLayoutSection() -> NSCollectionLayoutSection {
        
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

//MARK: - Constraints
private extension NewsfeedCollectionViewController {
    func setConstraints() {
        self.view.addSubview(self.newsfeedCollectionView)
        self.newsfeedCollectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
