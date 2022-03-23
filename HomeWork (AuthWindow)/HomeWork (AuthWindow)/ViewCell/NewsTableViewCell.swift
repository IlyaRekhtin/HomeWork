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

    private var avatar: Avatar = {
        let imageView = Avatar(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        return imageView
    }()
    
    private var name: UILabel = {
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        lable.numberOfLines = 1
        lable.textAlignment = .left
        lable.font = UIFont(name: "Times New Roman", size: 17)
        return lable
    }()
    
    private var text: UILabel = {
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        lable.textAlignment = .justified
        lable.font = UIFont(name: "Times New Roman", size: 17)
        lable.numberOfLines = 5
        return lable
    }()
    
    private var buttonForFullText: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        button.configuration = .plain()
        button.configuration?.title = "Показать полностью..."
        
        button.configuration?.attributedTitle?.font = UIFont(name: "Times New Roman", size: 14)
        button.tintColor = .blue
        return button
    }()
    
    private var headerStack: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        stackView.spacing = 3
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.alignment = .leading
        return stackView
    }()
    
    private var footerStack: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        stackView.spacing = 1
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.alignment = .leading
        return stackView
    }()
    
    private var newsStack: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        stackView.spacing = 1
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    private var textState = 0
    
    private var images = [UIImage]()
    
    private var collectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, UIImage>!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        createDataSourse()
        headerStack.addArrangedSubview(avatar)
        headerStack.addArrangedSubview(name)
        newsStack.addArrangedSubview(text)
        newsStack.addArrangedSubview(buttonForFullText)
        
        buttonForFullText.addTarget(self, action: #selector(actionForMoreButton), for: .touchDown)
        self.collectionView.delegate = self
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configurationCell(_ news: News) {
        avatar.offShadow()
        avatar.setImage(news.person.avatar)
        name.text = news.person.name
        text.text = news.newsText
        images = news.newsImages!
        
        if text.
        
        
        reloadData()
        setConstreints()
    }
    
    func getCellSize() -> CGFloat {
        return self.text.frame.height + self.collectionView.frame.height
    }
    
    private func setConstreints() {
        self.addSubview(headerStack)
        self.contentView.addSubview(newsStack)
        self.addSubview(collectionView)
        
        
        headerStack.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(5)
        }
        
        avatar.snp.makeConstraints { make in
            make.size.equalTo(self.avatar.frame.width)
        }
        
        name.snp.makeConstraints { make in
            make.centerY.equalTo(avatar.snp.centerY)
        }
        
        newsStack.snp.makeConstraints { make in
            make.top.equalTo(headerStack.snp.bottom).offset(2)
            make.trailing.leading.equalToSuperview().inset(5)
        }
        
        
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(newsStack.snp.bottom).offset(3)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(self.bounds.width)
           
            
           
        }
        
    }
    
    @objc private func actionForMoreButton() {
        switch self.textState{
        case 0:
            textState = 1
            text.numberOfLines = 0
        case 1:
            textState = 0
            text.numberOfLines = 5
        default:
            break
        }
    }
    
    
    
    
    //MARK: - Setup collectionView
        private func setupCollectionView() {
            collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.width), collectionViewLayout: createCompositionLayout())
            collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
           
            collectionView.isScrollEnabled = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.showsVerticalScrollIndicator = false
           
            collectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.reuseID)
        }
    //MARK: - create composition layout
    private func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, collectionEnvironment) -> NSCollectionLayoutSection? in
            
            return self.createLayoutForNewsImages()
       
        }
        return layout
    }
    
    //MARK: - create Data Source
    private func createDataSourse() {
        dataSource = UICollectionViewDiffableDataSource<Int, UIImage>(collectionView: self.collectionView,
                                                                         cellProvider: { (collectionView, indexPuth, model) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.reuseID, for: indexPuth) as! ImagesCollectionViewCell
            cell.config(self.images[indexPuth.row])
            return cell
        })
        // crerate Header in sections
//        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPuth in
//            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
//                                                                                      withReuseIdentifier: SectionHeader.reuseID ,
//                                                                                      for: indexPuth) as? SectionHeader else { return nil }
//            guard let firstItem = self?.dataSource.itemIdentifier(for: indexPuth) else { return nil }
//            guard let sectionName = self?.dataSource.snapshot().sectionIdentifier(containingItem: firstItem) else { return nil }
//            if sectionName.name.isEmpty { return nil }
//            sectionHeader.header.text = sectionName.name
//            return sectionHeader
//        }
    }
        
    private  func reloadData(){
        var snapShot = NSDiffableDataSourceSnapshot<Int, UIImage>()
        snapShot.appendSections([1])
        snapShot.appendItems(images)
        dataSource.apply(snapShot)
    }
    
    
    
    

}

