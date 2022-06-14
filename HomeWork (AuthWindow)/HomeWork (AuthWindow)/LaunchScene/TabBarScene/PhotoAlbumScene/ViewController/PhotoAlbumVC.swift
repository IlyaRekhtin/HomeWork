//
//  FriendCollectionViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit
import Kingfisher

class PhotoAlbumVC: UIViewController {
    
    
    private let service = PhotoAlbumService()
    private var pushTransition = PushImageViewTransitionAnimation()
    private var popTransition = PopImageViewTransitionAnimation()
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Photo>!
    private var layoutChangeButton = LayoutChangeButton()
    
    var photoAlbum = [Photo]() {
        didSet {
            currentSizePhotos = Photo.getURLForMaxPhotos(self.photoAlbum)
            reloadData()
        }
    }
    
    private var currentSizePhotos = [URL]()
    
    var userId: Int!
    var firstName: String?
    var lastName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutChangeButtonConfigurations()
        setupCollectionView()
        createDataSource()
        collectionView.delegate = self
        DispatchQueue.global().async {
            self.service.getPhotos(for: self.userId){photos in
                self.photoAlbum = Array(photos.items)
                self.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navControllerConfiguration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.setValue(layoutChangeButton.sizeInCollectionView.rawValue, forKey: "sizeForLayoutForFotoGallary")
    }
}

//MARK: - Private
private extension PhotoAlbumVC {
    
     func layoutChangeButtonConfigurations(){
        let sizeInCollectionView = LayoutChangeButton.FotoSizeInCollectionView(rawValue: UserDefaults.standard.integer(forKey: "sizeForLayoutForFotoGallary"))
        
        let actionForChangeButton = UIAction(handler: { [self] _ in
            switch layoutChangeButton.sizeInCollectionView {
            case .fullScreen:
                layoutChangeButton.image = UIImage(systemName: "rectangle")
                layoutChangeButton.sizeInCollectionView = .treeOnLine
            case .treeOnLine:
                layoutChangeButton.image = UIImage(systemName: "rectangle.grid.2x2")
                layoutChangeButton.sizeInCollectionView = .fullScreen
            }
            self.collectionView.reloadData()
        })
        layoutChangeButton = LayoutChangeButton(image: LayoutChangeButton.getButtonImage(forSize: sizeInCollectionView!), primaryAction: actionForChangeButton)
        layoutChangeButton.sizeInCollectionView = sizeInCollectionView!
    }
    
     func navControllerConfiguration(){
       // Navigation Controller Appearance
        navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.standardAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.tintColor = .systemGreen
        self.navigationItem.setRightBarButton(layoutChangeButton, animated: true)
         // config custom barButton
         
        self.navigationItem.title = "\(firstName ?? "")" + " " + "\(lastName ?? "")"
        navigationItem.backButtonTitle = ""
        tabBarController?.tabBar.isHidden = false
    }
    
}

//MARK: - CollectionView
extension PhotoAlbumVC: UICollectionViewDelegate {
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        // Register cell
        collectionView.register(PhotoAlbumCollectionCell.self, forCellWithReuseIdentifier: PhotoAlbumCollectionCell.reuseID)
    }
    
    private func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, collectionEnvironment) -> NSCollectionLayoutSection? in
        
            switch self.layoutChangeButton.sizeInCollectionView {
            case .fullScreen:
                return self.createSectionLayoutOneOnLine()
            case .treeOnLine:
                return self.createSectionLayoutThreeOnLine()
            
            }
        }
        return layout
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Photo>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoAlbumCollectionCell.reuseID, for: indexPath) as? PhotoAlbumCollectionCell else {fatalError()}
            cell.configCell(for: self.currentSizePhotos[indexPath.row])
            
            return cell
        })
    }
    
    private  func reloadData(){
        var snapShot = NSDiffableDataSourceSnapshot<Int, Photo>()
        snapShot.appendSections([1])
        snapShot.appendItems(self.photoAlbum)
        dataSource.apply(snapShot)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let vc = self.storyboard?.instantiateViewController(identifier: "imageShowController") as? ImagePresentViewController else {return}
        guard let index = collectionView.indexPathsForSelectedItems?.first else {return}
        
        vc.currentIndexPuthFoto = index.row
    
        DispatchQueue.main.async {
            vc.firstImageView.kf.setImage(with: self.currentSizePhotos[index.row])
        }
        vc.currentSizePhotos = self.currentSizePhotos
        vc.firstImageView.kf.indicatorType = .activity
        vc.photoAlbum = self.photoAlbum
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
}


//MARK: TransitionDelegate
extension PhotoAlbumVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let selectedIndexPathCell = collectionView.indexPathsForSelectedItems,
              let selectedCell = collectionView.cellForItem(at: selectedIndexPathCell.first!) as? PhotoAlbumCollectionCell,
              let selectedCellSuperview = selectedCell.superview else {return nil}
        pushTransition.imageInitFrame = selectedCellSuperview.convert(selectedCell.layer.frame, to: nil)
        pushTransition.imageInitFrame = selectedCell.layer.frame
        pushTransition.imageInitFrame = CGRect(
          x: pushTransition.imageInitFrame.origin.x ,
          y: pushTransition.imageInitFrame.origin.y + 50,
          width: pushTransition.imageInitFrame.size.width,
          height: pushTransition.imageInitFrame.size.height + 70
        )
        return pushTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //TODO возвращение в ячейку коллекции
        return popTransition
    }
}


