//
//  ImageShowViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 27.02.2022.
//

import UIKit
import SnapKit
import Kingfisher

class ImagePresentViewController: UIViewController {
    
    //NavigationView
    private var customNavView =  UIView()
    private var customNavBar = UINavigationBar()
    private var navItems = UINavigationItem(title: "")
    /// State flag for GRecognizer
    private var navBarIsHide = false
    
    //CustomTabBar
    private var customTabBar: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        return view
    }()
    private var stackView: UIStackView = {
        let stackView = UIStackView(frame:.zero)
        stackView.alignment = .top
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    private var likeButton: LikeButton = {
        let button = LikeButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.configuration = .plain()
        return button
    }() 
    private let spacer: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        return view
        //TODO кнопка коментариев
    }()
    private let spacer2: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        return view
        //TODO просмотры
    }()
    
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
    private var secondImageView: UIImageView! = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // Animation
    private var propertyAnimator = UIViewPropertyAnimator()
    private enum AnimationDirection {
        case right, left
    }
    private var animationDirection: AnimationDirection = .left
    
    //Data
    var currentIndexPuthFoto: Int!
    var photoAlbum = [Photo]()
    var currentSizePhotos = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigForMainView()
    }
}

//MARK: - Configuration view private methods
private extension ImagePresentViewController {
    func setConfigForMainView() {
        self.view.backgroundColor = .black
        navigationBarApperians()
        customTabBarAppereans()
        addGestureRecognizer()
        makeConstraints()
    }
}

//MARK: - GestureRecognaze Metods
private extension ImagePresentViewController {
    
    func addGestureRecognizer() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(hideNavBarAndTabBar))
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        let swipeDownGR = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownAction))
        self.view.addGestureRecognizer(swipeDownGR)
        self.view.addGestureRecognizer(tapGR)
        self.view.addGestureRecognizer(panGR)
        swipeDownGR.direction = .down
        
    }
    
    @objc func swipeDownAction(){
        self.dismiss(animated: true)
    }
    
    @objc func hideNavBarAndTabBar(){
        switch navBarIsHide {
        case false:
            self.navBarIsHide.toggle()
            UIView.animate(withDuration: 0.5) {
                self.customNavView.alpha = 0
                self.customTabBar.alpha = 0
            }
        case true:
            self.navBarIsHide.toggle()
            UIView.animate(withDuration: 0.5) {
                self.customNavView.alpha = 1
                self.customTabBar.alpha = 1
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
            guard photoAlbum.count - 1 >= currentIndexPuthFoto + 1 else {return}
        } else {
            guard currentIndexPuthFoto >= 1 else {return}
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
            secondImageView.kf.setImage(with: currentSizePhotos[currentIndexPuthFoto - 1])
        case .left:
            secondImageView.kf.setImage(with: currentSizePhotos[currentIndexPuthFoto + 1])
        }
        /// анимация вью на переднем плане
        propertyAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                  curve: .linear,
                                                  animations: {
            self.firstImageView.transform = CGAffineTransform(translationX: firstViewPositionFactor * self.firstImageView.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
            self.secondImageView.transform = .identity
        })
        
        propertyAnimator.addCompletion { [self] position in
            switch position {
            case .end:
                switch diraction {
                case .right:
                    currentIndexPuthFoto -= 1
                case .left:
                    currentIndexPuthFoto += 1
                }
                firstImageView.kf.setImage(with: currentSizePhotos[currentIndexPuthFoto])
                firstImageView.transform = .identity
                secondImageView.image = nil
            case .start:
                secondImageView.transform = CGAffineTransform(translationX: secondViewPositionFactor * secondImageView.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
            case .current:
                break
            @unknown default:
                break
            }
            likeButton.setConfig(for: photoAlbum[currentIndexPuthFoto])
            navItems.title = "\(currentIndexPuthFoto + 1) из \(photoAlbum.count)"
        }
    }
}

//MARK: - Make constraints
private extension ImagePresentViewController {
    
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
        
        self.view.addSubview(customNavView)
        customNavView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
            
        }
        self.customNavView.addSubview(customNavBar)
        customNavBar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        self.view.addSubview(customTabBar)
        customTabBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(100)
            make.left.right.equalToSuperview()
        }
        self.customTabBar.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - Navigation and Tab Bar
private extension ImagePresentViewController {
    func navigationBarApperians() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonAction))
        backButton.tintColor = .white
        let shareButton = UIBarButtonItem(systemItem: .action)
        shareButton.tintColor = .white
        
        navItems.leftBarButtonItem = backButton
        navItems.rightBarButtonItem = shareButton
        navItems.title = "\(currentIndexPuthFoto + 1) из \(photoAlbum.count)"
        
        customNavView = UIView(frame: CGRect.zero)
        customNavView.backgroundColor = .black
        customNavBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        customNavBar.setItems([navItems], animated: false)
        
        customNavBar.scrollEdgeAppearance = Appearance.data.appearanceForNavBarImageShowVC()
        customNavBar.compactAppearance = Appearance.data.appearanceForNavBarImageShowVC()
        customNavBar.standardAppearance = Appearance.data.appearanceForNavBarImageShowVC()
        customNavBar.compactScrollEdgeAppearance = Appearance.data.appearanceForNavBarImageShowVC()
        customNavBar.tintColor = .white
    }
    
    func customTabBarAppereans(){
        tabBarController?.tabBar.isHidden = true // скрываем штатный таббар
        configTabBarStackView()
    }
    
    func configTabBarStackView(){
        stackView.addArrangedSubview(likeButton)
        configLikeButton()
        stackView.addArrangedSubview(spacer)
        stackView.addArrangedSubview(spacer2)
    }
    
    func configLikeButton(){
        likeButton.setConfig(for: photoAlbum[currentIndexPuthFoto])
        ///likeButton add Action
        likeButton.addAction(UIAction(handler: { [self] _ in
            likeButton.updateLikeButton(for: photoAlbum[currentIndexPuthFoto])
        }), for: .touchUpInside)
    }
    
    @objc func backButtonAction(){
        self.dismiss(animated: true)
    }
}
