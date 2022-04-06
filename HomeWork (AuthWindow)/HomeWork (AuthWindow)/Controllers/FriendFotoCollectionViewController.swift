//
//  FriendCollectionViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit

class FriendFotoCollectionViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Foto>!
    private var buttonForChangeLayout = ButtonForChangeLayout()
    var user: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tap))
//        self.view.addGestureRecognizer(tap)
        setButtonForChangeLayout()
        setupCollectionView()
        createDataSource()
        collectionView.delegate = self
    }
    
//    @objc func tap(_ sender: UIGestureRecognizer){
//        print(sender.location(in: self.view))
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationController()
        reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.setValue(buttonForChangeLayout.sizeInCollectionView.rawValue, forKey: "sizeForLayoutForFotoGallary")
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        
        
        collectionView.register(FriendCollectionViewCell.self, forCellWithReuseIdentifier: FriendCollectionViewCell.reuseID)
    }
    
    private func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, collectionEnvironment) -> NSCollectionLayoutSection? in
            
            switch self.buttonForChangeLayout.sizeInCollectionView {
            case .fullScreen:
                return self.createSectionLayoutOneOnLine()
            case .treeOnLine:
                return self.createSectionLayoutThreeOnLine()
            
            }
        }
        return layout
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCollectionViewCell.reuseID, for: indexPath) as? FriendCollectionViewCell else {fatalError()}
            
            cell.setCollectionViewSetting(for: self.user.fotoAlbum[indexPath.row].image)
            
            return cell
        })
    }
    
    private  func reloadData(){
        var snapShot = NSDiffableDataSourceSnapshot<Int, Foto>()
        snapShot.appendSections([1])
        let fotoAlbum = self.user.fotoAlbum
        snapShot.appendItems(fotoAlbum)
        dataSource.apply(snapShot)
    }
  
    private func configNavigationController(){
       
        navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.standardAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        
        navigationController?.navigationBar.tintColor = .systemGreen
        self.navigationItem.setRightBarButton(buttonForChangeLayout, animated: true)
        self.navigationItem.title = "\(user.name)" + " " + "\(user.description)"
        navigationItem.backButtonTitle = ""
        tabBarController?.tabBar.isHidden = false
        
    }
    
    private func setButtonForChangeLayout(){
        let sizeInCollectionView = ButtonForChangeLayout.FotoSizeInCollectionView(rawValue: UserDefaults.standard.integer(forKey: "sizeForLayoutForFotoGallary"))
        
        let actionForChangeButton = UIAction(handler: { [self] _ in
            switch buttonForChangeLayout.sizeInCollectionView {
            case .fullScreen:
                buttonForChangeLayout.image = UIImage(systemName: "rectangle")
                buttonForChangeLayout.sizeInCollectionView = .treeOnLine
            case .treeOnLine:
                buttonForChangeLayout.image = UIImage(systemName: "rectangle.grid.2x2")
                buttonForChangeLayout.sizeInCollectionView = .fullScreen
            }
            self.collectionView.reloadData()
        })
        buttonForChangeLayout = ButtonForChangeLayout(image: ButtonForChangeLayout.getButtonImage(forSize: sizeInCollectionView!), primaryAction: actionForChangeButton)
        buttonForChangeLayout.sizeInCollectionView = sizeInCollectionView!
    }
}

extension FriendFotoCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let item = collectionView.cellForItem(at: indexPath) as? FriendCollectionViewCell else {return}
  
//        UIView.animateKeyframes(withDuration: 0.7,
//                                delay: 0,
//                                options: []) {
//            UIView.addKeyframe(withRelativeStartTime: 0,
//                               relativeDuration: 0.7) {
//
//                item.layer.zPosition = 1
//                item.transform = CGAffineTransform(scaleX: 3, y: 3)
//                item.imageView.contentMode = .scaleAspectFit
//                item.center.x = self.view.center.x
//                item.center.y = self.view.frame.height / 2 - 50
//                print(self.view.center)
//            }
//        } completion: { _ in
//            guard let vc = self.storyboard?.instantiateViewController(identifier: "imageShowController") as? ImageShowViewController else {return}
//            guard let index = collectionView.indexPathsForSelectedItems?.first else {return}
//            vc.currentIndexPuthFoto = index
//            vc.fotoAlbum = self.user.fotoAlbum
//
//
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        guard let vc = self.storyboard?.instantiateViewController(identifier: "imageShowController") as? ImageShowViewController else {return}
        guard let index = collectionView.indexPathsForSelectedItems?.first else {return}
        
        vc.currentIndexPuthFoto = index
        vc.fotoAlbum = self.user.fotoAlbum
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
