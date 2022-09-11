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
    var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        return collection
    }()
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    private var photoalbumViewModels = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSetup()
        createDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navControllerConfiguration()
    }
    
    override func viewDidLayoutSubviews() {
        collectionView.frame = view.bounds
    }
    
    func setNameForNavigationBar(_ name: String) {
        self.navigationController?.title = name
    }
    
    func update(with photos: [String]) {
        self.photoalbumViewModels = photos
        reloadData()
    }
}

//MARK: - Private
private extension PhotoalbumViewController {
    func collectionSetup() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PhotoAlbumCollectionCell.self, forCellWithReuseIdentifier: PhotoAlbumCollectionCell.reuseID)
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    func navControllerConfiguration(){
        // Navigation Controller Appearance
        navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.mainNavigationControllerAppearance()
        navigationController?.navigationBar.compactAppearance = Appearance.data.mainNavigationControllerAppearance()
        navigationController?.navigationBar.standardAppearance = Appearance.data.mainNavigationControllerAppearance()
        navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.mainNavigationControllerAppearance()
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.backButtonTitle = ""
        tabBarController?.tabBar.isHidden = false
    }
    
}

//MARK: - CollectionView
extension PhotoalbumViewController: UICollectionViewDelegate {
    
    private func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {[weak self] (sectionIndex, collectionEnvironment) -> NSCollectionLayoutSection? in
            return self?.createSectionLayoutThreeOnLine()
        }
        return layout
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: collectionView) {[weak self] collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoAlbumCollectionCell.reuseID, for: indexPath) as? PhotoAlbumCollectionCell else {fatalError()}
            if let item = self?.photoalbumViewModels[indexPath.item] {
                self?.presenter?.getPhoto(url: item){ fetchImage in
                    guard let image = fetchImage else {return}
                        cell.configCell(image)
                }
            }
            return cell
        }
    }
    
    private  func reloadData(){
        var snapShot = NSDiffableDataSourceSnapshot<Int, String>()
        snapShot.appendSections([1])
        snapShot.appendItems(self.photoalbumViewModels)
        dataSource.apply(snapShot)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let vc = self.storyboard?.instantiateViewController(identifier: "PhotoViewerViewController") as? PhotoViewerViewController else {return}
        guard let index = collectionView.indexPathsForSelectedItems?.first else {return}
        vc.assembly.configure(with: vc, self.photoalbumViewModels, index.row)
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
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


