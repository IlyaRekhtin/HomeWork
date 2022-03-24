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
    
    private var like: Like = {
        let button = Like(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
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
    
    private var images = [Foto]()
    
    private var collectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Foto>!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCollectionView()
        createDataSourse()
        self.collectionView.delegate = self
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurationCell(_ news: News) {
        headerNewsView.setValue(news.person.avatar, news.person.name)
        
        newsView.text = news.newsText
        
        images = news.newsImages ?? []
        
        like.setConfig(for: news)
        like.configuration?.baseForegroundColor = .gray
        
        
        
        reloadData()
        
        setConstreints(news)
    }
    
    private func setConstreints(_ news: News) {
        
        self.addSubview(headerNewsView)
        headerNewsView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(self.headerNewsView.frame.height)
        }
        
        if news.newsText != nil {
            self.addSubview(newsView)
            newsView.snp.makeConstraints { make in
                make.top.equalTo(headerNewsView.snp.bottom).offset(10)
                make.left.right.equalToSuperview().inset(10)
            }
        } 
        
        if !images.isEmpty {
            self.addSubview(collectionView)
            collectionView.snp.makeConstraints { make in
                if news.newsText != nil {
                    make.top.equalTo(self.newsView.snp.bottom).offset(3)
                } else {
                    make.top.equalTo(self.headerNewsView.snp.bottom).offset(3)
                }
                make.left.right.equalToSuperview()
                make.height.equalTo(self.collectionView.frame.height)
            }
        }
        
        self.addSubview(like)
        like.snp.makeConstraints { make in
            if !images.isEmpty {
                make.top.equalTo(self.collectionView.snp.bottom).offset(5)
            } else {
                make.top.equalTo(self.newsView.snp.bottom).offset(5)
            }
            make.left.equalToSuperview().inset(5)
            
            
        }
        
        self.addSubview(separateView)
        separateView.snp.makeConstraints { make in
            make.top.equalTo(self.like.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(self.separateView.frame.height)
        }
    }
    
    //MARK: - Setup collectionView
        private func setupCollectionView() {
            collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.layer.frame.width, height: self.layer.frame.width), collectionViewLayout: createCompositionLayout())
            collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
           
            collectionView.isScrollEnabled = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.showsVerticalScrollIndicator = false
           
            collectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.reuseID)
        }
    //MARK: - create composition layout
    private func createCompositionLayout() -> UICollectionViewLayout {
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
    private func createDataSourse() {
        dataSource = UICollectionViewDiffableDataSource<Int, Foto>(collectionView: self.collectionView,
                                                                         cellProvider: { (collectionView, indexPuth, model) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.reuseID, for: indexPuth) as! ImagesCollectionViewCell
            cell.config(self.images[indexPuth.row])
            return cell
        })
    }
        
    private  func reloadData(){
        var snapShot = NSDiffableDataSourceSnapshot<Int, Foto>()
        snapShot.appendSections([1])
        snapShot.appendItems(images)
        dataSource.apply(snapShot)
    }
}

