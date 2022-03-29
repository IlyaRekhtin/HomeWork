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
        setButtonForChangeLayout()
        setupCollectionView()
        createDataSource()
        collectionView.delegate = self
    }
    
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
            cell.backgroundColor = .brown
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
        tabBarController?.tabBar.isHidden = false
        navigationItem.backButtonTitle = ""
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
        guard let vc = storyboard?.instantiateViewController(identifier: "imageShowController") as? ImageShowViewController else {return}
        guard let index = collectionView.indexPathsForSelectedItems?.first else {return}
        vc.foto = self.user.fotoAlbum[index.row]
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
