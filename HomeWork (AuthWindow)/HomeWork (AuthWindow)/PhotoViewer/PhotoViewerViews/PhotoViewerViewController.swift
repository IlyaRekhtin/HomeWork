//
//  ImageShowViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 27.02.2022.
//

import UIKit
import SnapKit
import Kingfisher

final class PhotoViewerViewController: UIViewController, PhotoViewerProtocol {
    
    var presenter: PhotoViewerPresenterProtocol?
    var assembly: PhotoViewerAssemblyProtocol = PhotoViewerAssambly()
    
    /// State flag for GRecognizer
    private var navigationBarIsHide = false
    
    //ImageViews
    /// ImageView for present target image on ViewController
    var firstImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }() {
        didSet {
            firstImageView.isUserInteractionEnabled = true
        }
    }
    /// ImageView for present next image on ViewController
    private var secondImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var customTabBar: PhotoViewerTabBar?
    
    // Animation
    private var propertyAnimator = UIViewPropertyAnimator()
    private enum AnimationDirection {
        case right, left
    }
    private var animationDirection: AnimationDirection = .left
    
    //Data
    var currentIndexPuthPhoto: Int = 0
    var photoAlbum = [Likeble & Reposteble]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigForMainView()
    }
    
}

//MARK: - Configuration view private methods
private extension PhotoViewerViewController {
    func setConfigForMainView() {
        self.view.backgroundColor = .black
        firstImageView.image = presenter?.getPhoto(url: photoAlbum[currentIndexPuthPhoto].photo)
        navigationBarApperians()
        customTabBarAppereans()
        addGestureRecognizer()
        makeConstraints()
    }
}

//MARK: - GestureRecognaze Metods
private extension PhotoViewerViewController {
    
    func addGestureRecognizer() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(hideNavBarAndTabBar))
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        let swipeDownGR = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownAction))
        swipeDownGR.direction = .down
        let swipeRigthGR = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownAction))
        swipeRigthGR.direction = .right
        let swipeLeftGR = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownAction))
        swipeLeftGR.direction = .left
        self.view.addGestureRecognizer(tapGR)
        self.view.addGestureRecognizer(panGR)
        self.view.addGestureRecognizer(swipeDownGR)
        self.view.addGestureRecognizer(swipeRigthGR)
        self.view.addGestureRecognizer(swipeLeftGR)
    }
    
    @objc func swipeDownAction(sender: UISwipeGestureRecognizer){
        switch sender.direction {
        case .down:
            self.navigationController?.popViewController(animated: true)
        case .left:
            panAnimation(for: .left)
        case .right:
            panAnimation(for: .right)
        default:
            break
        }
    }
    
    @objc func hideNavBarAndTabBar(){
        switch navigationBarIsHide {
        case false:
            self.navigationBarIsHide.toggle()
            UIView.animate(withDuration: 0.5) {
                self.navigationController?.navigationBar.isHidden = true
                self.customTabBar?.isHidden = true
            }
        case true:
            self.navigationBarIsHide.toggle()
            UIView.animate(withDuration: 0.5) {
                self.navigationController?.navigationBar.isHidden = false
                self.customTabBar?.isHidden = false
            }
        }
    }
    
    @objc func panGestureAction(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            switch sender.translation(in: view).x {
            case 0:
                break
            case ...0:
                //left
                panAnimation(for: .left)
            case 0...:
                // right
                panAnimation(for: .right)
            default:
                break
            }
        case .changed:
            switch animationDirection {
            case .right:
                let procent = min(max(0, sender.translation(in: view).x/200),1)
                propertyAnimator.fractionComplete = procent
            case .left:
                let procent = min(max( -sender.translation(in: view).x/200, 0),1)
                propertyAnimator.fractionComplete = procent
            }
        case .ended:
            if propertyAnimator.fractionComplete >= 0.4 {
                propertyAnimator.continueAnimation(withTimingParameters: .none, durationFactor: 0.5)
            } else {
                propertyAnimator.isReversed = true
                propertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
                
            }
        case .cancelled:
            break
        case .failed:
            break
        default:
            break
        }
    }
    
    /// Анимирует ImageViews в соответствии с направлением жеста
    /// - Parameter diraction: направление жеста
    private func panAnimation(for diraction: AnimationDirection) {
        if diraction == .left {
            guard photoAlbum.count - 1 >= currentIndexPuthPhoto + 1 else {return}
        } else {
            guard currentIndexPuthPhoto >= 1 else {return}
        }
        self.animationDirection = diraction
        
        var firstViewPositionFactor: Double {
            get {
                switch diraction {
                case .right:
                    return 1.3
                case .left:
                    return -1.3
                }
            }
        }
        var secondViewPositionFactor: Double {
            get {
                switch diraction {
                case .right:
                    return -1.5
                case .left:
                    return 1.5
                }
            }
        }
        /// начальное положение заднего вью
        self.secondImageView.transform = CGAffineTransform(translationX: secondViewPositionFactor * self.secondImageView.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
        
        switch diraction {
        case .right:
            let imageUrl = photoAlbum[currentIndexPuthPhoto - 1].photo
            secondImageView.image = presenter?.getPhoto(url: imageUrl)
        case .left:
            let imageUrl = photoAlbum[currentIndexPuthPhoto + 1].photo
            secondImageView.image = presenter?.getPhoto(url: imageUrl)
        }
        /// анимация вью на переднем плане
        propertyAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                  curve: .linear,
                                                  animations: {
            self.firstImageView.transform = CGAffineTransform(translationX: firstViewPositionFactor * self.firstImageView.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
            self.secondImageView.transform = .identity
        })
        
        propertyAnimator.addCompletion { [weak self] position in
            guard let self = self else {return}
            switch position {
            case .end:
                switch diraction {
                case .right:
                    self.currentIndexPuthPhoto -= 1
                case .left:
                    self.currentIndexPuthPhoto += 1
                }
                let imageUrl = self.photoAlbum[self.currentIndexPuthPhoto].photo
                self.firstImageView.image = self.presenter?.getPhoto(url: imageUrl)
                self.firstImageView.transform = .identity
                self.secondImageView.image = nil
            case .start:
                self.secondImageView.transform = CGAffineTransform(translationX: secondViewPositionFactor * self.secondImageView.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
            case .current:
                break
            @unknown default:
                break
            }
            
            self.customTabBar?.likeButton.setConfig(for: self.photoAlbum[self.currentIndexPuthPhoto])
            self.navigationItem.title = "\(self.currentIndexPuthPhoto + 1) из \(self.photoAlbum.count)"
        }
    }
}

//MARK: - snap kit
private extension PhotoViewerViewController {
    
    func makeConstraints() {
        self.view.addSubview(firstImageView)
        firstImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.view.addSubview(secondImageView)
        self.view.sendSubviewToBack(secondImageView)
        secondImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.view.addSubview(customTabBar!)
        customTabBar?.snp.makeConstraints{ make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
    }
}

// MARK: - Navigation and Tab Bar
extension PhotoViewerViewController {
    func navigationBarApperians() {
        self.navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.imageViewingScreenNavigationControllerAppearance()
        self.navigationController?.navigationBar.compactAppearance = Appearance.data.imageViewingScreenNavigationControllerAppearance()
        self.navigationController?.navigationBar.standardAppearance = Appearance.data.imageViewingScreenNavigationControllerAppearance()
        self.navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.imageViewingScreenNavigationControllerAppearance()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = "\(self.currentIndexPuthPhoto + 1) из \(self.photoAlbum.count)"
    }
    
    func customTabBarAppereans(){
        tabBarController?.tabBar.isHidden = true // скрываем штатный таббар
        self.customTabBar = PhotoViewerTabBar(self.photoAlbum[currentIndexPuthPhoto])
    }
}
