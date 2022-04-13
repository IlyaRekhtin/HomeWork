//
//  FriendCollectionViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit

class FriendFotoCollectionViewController: UIViewController {
    private var pushTransition = PushImageViewTransitionAnimation()
    private var popTransition = PopImageViewTransitionAnimation()
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

        guard let vc = self.storyboard?.instantiateViewController(identifier: "imageShowController") as? ImageShowViewController else {return}
        guard let index = collectionView.indexPathsForSelectedItems?.first else {return}
        
        vc.currentIndexPuthFoto = index.row
        vc.fotoAlbum = self.user.fotoAlbum
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
}

//MARK: TransitionDelegate
extension FriendFotoCollectionViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let selectedIndexPathCell = collectionView.indexPathsForSelectedItems,
              let selectedCell = collectionView.cellForItem(at: selectedIndexPathCell.first!) as? FriendCollectionViewCell, let selectedCellSuperview = selectedCell.superview else {return nil}
            
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
