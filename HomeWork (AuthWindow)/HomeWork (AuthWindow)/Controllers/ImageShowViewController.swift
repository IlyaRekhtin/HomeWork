//
//  ImageShowViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 27.02.2022.
//

import UIKit
import SnapKit

class ImageShowViewController: UIViewController, UICollectionViewDelegate {
    
    
    private let likeButton: Like = {
        let button = Like(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.configuration = .plain()
        return button
    }()
    
    private var imageCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Foto>!
    private var stackView: UIStackView!
    
    private var customTabBar: UIView!
 
    private let spacer: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        return view
    }()
    private let spacer2: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        return view
    }()
    
    var currentIndexPuthFoto: IndexPath!
    
    var fotoAlbum: [Foto] = []
    
    var indexVisibleCell = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.indexVisibleCell = currentIndexPuthFoto.row
        navigationBarApperians()
        setupCollectionView()
        createDataSource()
        configTabBar()
        configStackView()
        configLikeButton()
        makeConstraints()
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
        self.imageCollectionView.scrollToItem(at: currentIndexPuthFoto, at: .left, animated: false)
    }
    
    
    
    private func setupCollectionView() {
        imageCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        imageCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        imageCollectionView.showsHorizontalScrollIndicator = false
        imageCollectionView.showsVerticalScrollIndicator = false
        imageCollectionView.backgroundColor = .black
       
        imageCollectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.reuseID)
    }
    
    private func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, collectionEnvironment) -> NSCollectionLayoutSection? in
                return self.createSectionLayout()
        }
        return layout
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.imageCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            guard let cell = self.imageCollectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.reuseID, for: indexPath) as? ImagesCollectionViewCell else {fatalError()}
            cell.config(self.fotoAlbum[indexPath.row])
            cell.backgroundColor = .black
            cell.imageView.contentMode = .scaleAspectFit
            return cell
        })
    }
    
    private  func reloadData(){
        var snapShot = NSDiffableDataSourceSnapshot<Int, Foto>()
        snapShot.appendSections([1])
        snapShot.appendItems(fotoAlbum)
        dataSource.apply(snapShot)
    }
    
    
    private func configTabBar() {
        self.customTabBar = UIView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: 100)))
        self.customTabBar.backgroundColor = .black
        
    }
    
    private func configStackView(){
        stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100))
        stackView.alignment = .top
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(likeButton)
        stackView.addArrangedSubview(spacer)
        stackView.addArrangedSubview(spacer2)
    }
    
    
    
    private func configLikeButton(){
        likeButton.setConfig(for: fotoAlbum[currentIndexPuthFoto.row])
        likeButton.addAction(UIAction(handler: { [self] _ in
            fotoAlbum[indexVisibleCell - 1].myLike.toggle()
            likeButton.animationImageChange()
            likeButton.setConfig(for: fotoAlbum[indexVisibleCell - 1])
        }), for: .touchUpInside)
    }
    
    private func navigationBarApperians() {
        
        navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.appearanceForNavBarImageShowVC()
        navigationController?.navigationBar.compactAppearance = Appearance.data.appearanceForNavBarImageShowVC()
        navigationController?.navigationBar.standardAppearance = Appearance.data.appearanceForNavBarImageShowVC()
        navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.appearanceForNavBarImageShowVC()
       
        navigationController?.navigationBar.tintColor = .white
       
        navigationItem.backButtonTitle = ""
        
        let rigthBarButton = UIBarButtonItem(systemItem: .action)
        rigthBarButton.tintColor = .white
        navigationItem.rightBarButtonItem = rigthBarButton
        tabBarController?.tabBar.isHidden = true
        
      
        
        
    }
    

    private func makeConstraints() {
        self.view.addSubview(imageCollectionView)
        self.view.addSubview(customTabBar)
        self.customTabBar.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(100)
            make.left.right.equalToSuperview()
        }
        
        customTabBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(100)
            make.left.right.equalToSuperview()
        }
    }
    
}

extension ImageShowViewController {
    func createSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension:.fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        section.orthogonalScrollingBehavior = .groupPaging
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            
            items.forEach { item in
                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                
                    let minScale: CGFloat = 0.9
                let maxScale: CGFloat = 1.1
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
            
            
            
            
            self.navigationItem.title = "\(items.count) из \(self.fotoAlbum.count)"
            self.indexVisibleCell = items.count
            self.likeButton.setConfig(for: self.fotoAlbum[self.indexVisibleCell - 1])
        }
        return section
    }
}
