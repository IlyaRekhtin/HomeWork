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
    var user: User!
    
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
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
        let titleForNavBar: UILabel = {
            let lable = UILabel()
            lable.text = user.name
            lable.font = UIFont(name: "Apple Color Emoji", size: 22)
            lable.textColor = .systemGreen
            
            return lable
        }()
        self.navigationItem.setRightBarButton(buttonForChangeLayout, animated: true)
        self.navigationItem.titleView = titleForNavBar
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemGreen
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let vc = segue.destination as? ImageShowViewController else {return}
        let index = collectionView.indexPathsForSelectedItems?.first
        vc.user = self.user
        vc.index = index?.row
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "imageShow", sender: nil)
    }
}
