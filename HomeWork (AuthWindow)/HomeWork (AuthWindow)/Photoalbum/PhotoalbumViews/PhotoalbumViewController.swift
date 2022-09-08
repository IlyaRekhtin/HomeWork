//
//  FriendCollectionViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit

final class PhotoalbumViewController: UIViewController, PhotoalbumViewProtocol {
    
    
    var presenter: PhotoalbumPresenterProtocol?
    let assembly: PhotoalbumAssemblyProtocol = PhotoalbumAssembly()
    
    private var pushTransition = PushImageViewTransitionAnimation()
    private var popTransition = PopImageViewTransitionAnimation()
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, PhotoalbumViewModel>!
//    private var layoutChangeButton = LayoutChangeButton()
    
    var photoalbumViewModels = [PhotoalbumViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        layoutChangeButtonConfigurations()
        setupCollectionView()
        createDataSource()
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navControllerConfiguration()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
//        UserDefaults.standard.setValue(layoutChangeButton.sizeInCollectionView.rawValue, forKey: "sizeForLayoutForFotoGallary")
    }
    
    deinit {
        print("deinit photoalbumVC")
    }
    
    func setNameForNavigationBar(_ name: String) {
        self.navigationController?.title = name
    }
    
    func update(with photos: [PhotoalbumViewModel]) {
        self.photoalbumViewModels = photos
        reloadData()
    }
}

//MARK: - Private
private extension PhotoalbumViewController {
    
//    func layoutChangeButtonConfigurations(){
//        let sizeInCollectionView = LayoutChangeButton.FotoSizeInCollectionView(rawValue: UserDefaults.standard.integer(forKey: "sizeForLayoutForFotoGallary"))
//
//        let actionForChangeButton = UIAction(handler: { [self] _ in
//            switch layoutChangeButton.sizeInCollectionView {
//            case .fullScreen:
//                layoutChangeButton.image = UIImage(systemName: "rectangle")
//                layoutChangeButton.sizeInCollectionView = .treeOnLine
//            case .treeOnLine:
//                layoutChangeButton.image = UIImage(systemName: "rectangle.grid.2x2")
//                layoutChangeButton.sizeInCollectionView = .fullScreen
//            }
//            self.collectionView.reloadData()
//        })
//        layoutChangeButton = LayoutChangeButton(image: LayoutChangeButton.getButtonImage(forSize: sizeInCollectionView!), primaryAction: actionForChangeButton)
//        layoutChangeButton.sizeInCollectionView = sizeInCollectionView!
//    }
    
    func navControllerConfiguration(){
        // Navigation Controller Appearance
        navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.standardAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.tintColor = .systemGreen
//        self.navigationItem.setRightBarButton(layoutChangeButton, animated: true)
        // config custom barButton
        
        navigationItem.backButtonTitle = ""
        tabBarController?.tabBar.isHidden = false
    }
    
}

//MARK: - CollectionView
extension PhotoalbumViewController: UICollectionViewDelegate {
    
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
        let layout = UICollectionViewCompositionalLayout {[weak self] (sectionIndex, collectionEnvironment) -> NSCollectionLayoutSection? in
            return self?.createSectionLayoutThreeOnLine()
//            switch self?.layoutChangeButton.sizeInCollectionView {
//            case .fullScreen:
//                return self?.createSectionLayoutOneOnLine()
//            case .treeOnLine:
//                return self?.createSectionLayoutThreeOnLine()
//            case .none:
//                return self?.createSectionLayoutOneOnLine()
//            }
        }
        return layout
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, PhotoalbumViewModel>(collectionView: collectionView, cellProvider: {[weak self] collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoAlbumCollectionCell.reuseID, for: indexPath) as? PhotoAlbumCollectionCell else {fatalError()}
            if let item = self?.photoalbumViewModels[indexPath.item] {
                cell.configCell(item)
            }
            return cell
        })
    }
    
    private  func reloadData(){
        var snapShot = NSDiffableDataSourceSnapshot<Int, PhotoalbumViewModel>()
        snapShot.appendSections([1])
        snapShot.appendItems(self.photoalbumViewModels)
        dataSource.apply(snapShot)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        guard let vc = self.storyboard?.instantiateViewController(identifier: "imageShowController") as? ImagePresentViewController else {return}
//        guard let index = collectionView.indexPathsForSelectedItems?.first else {return}
//        
//        vc.currentIndexPuthFoto = index.row
//        
//        let photo = self.photoalbumViewModels[index.row].photo
//        vc.firstImageView.image = photo
//        
////        vc.photoAlbum = self.photoalbumViewModels
//        vc.transitioningDelegate = self
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
//        
    }
}


//MARK: TransitionDelegate
extension PhotoalbumViewController: UIViewControllerTransitioningDelegate {
    
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


