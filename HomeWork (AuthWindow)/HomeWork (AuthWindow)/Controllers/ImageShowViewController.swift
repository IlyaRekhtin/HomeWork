//
//  ImageShowViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 27.02.2022.
//

import UIKit
import SnapKit

class ImageShowViewController: UIViewController {
    
    private let likeButton: Like = {
        let button = Like(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.configuration = .plain()
        return button
    }()
    
    var firstImageView: UIImageView! {
        didSet{
            firstImageView.isUserInteractionEnabled = true
        }
    }
    
    var secondImageView: UIImageView!
    private var stackView: UIStackView!
    private var customTabBar: UIView!
    private var customNavView: UIView!
    private var customNavBar: UINavigationBar!
    private var navItems = UINavigationItem(title: "")
    
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
    
    private var propertyAnimator = UIViewPropertyAnimator()
    
    private enum AnimationDirection {
        case right, left
    }
    
    private var animationDirection: AnimationDirection = .left
    
    private var navBarIsHide = false
    
    var currentIndexPuthFoto: Int!
    
    var fotoAlbum: [Foto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        navigationBarApperians()
        setupImageViews()
        configTabBar()
        configStackView()
        configLikeButton()
        makeConstraints()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(hideNavBarAndTabBar))
        view.addGestureRecognizer(tapGR)
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        view.addGestureRecognizer(panGR)
        let swipeDownGR = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownAction))
        swipeDownGR.direction = .down
        firstImageView.addGestureRecognizer(swipeDownGR)
    }
    
    private func setupImageViews() {
        firstImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        firstImageView.image = fotoAlbum[currentIndexPuthFoto].image
        firstImageView.contentMode = .scaleAspectFit
        
        secondImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        secondImageView.contentMode = .scaleAspectFit
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
        //TODO переделать через configurations
        likeButton.setConfig(for: fotoAlbum[currentIndexPuthFoto])
        likeButton.addAction(UIAction(handler: { [self] _ in
            fotoAlbum[currentIndexPuthFoto].myLike.toggle()
            likeButton.animationImageChange()
            likeButton.setConfig(for: fotoAlbum[currentIndexPuthFoto])
        }), for: .touchUpInside)
    }
    
    
    private func navigationBarApperians() {
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(leftNavBarAction))
        leftBarButton.tintColor = .white
        let rigthBarButton = UIBarButtonItem(systemItem: .action)
        rigthBarButton.tintColor = .white
        
        navItems.leftBarButtonItem = leftBarButton
        navItems.rightBarButtonItem = rigthBarButton
        navItems.title = "\(currentIndexPuthFoto + 1) из \(fotoAlbum.count)"
        
        customNavView = UIView(frame: CGRect.zero)
        customNavView.backgroundColor = .black
        customNavBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        customNavBar.setItems([navItems], animated: false)
        
        customNavBar.scrollEdgeAppearance = Appearance.data.appearanceForNavBarImageShowVC()
        customNavBar.compactAppearance = Appearance.data.appearanceForNavBarImageShowVC()
        customNavBar.standardAppearance = Appearance.data.appearanceForNavBarImageShowVC()
        customNavBar.compactScrollEdgeAppearance = Appearance.data.appearanceForNavBarImageShowVC()
        customNavBar.tintColor = .white
        tabBarController?.tabBar.isHidden = true
    }
    
    @objc private func leftNavBarAction(){
        self.dismiss(animated: true)
    }
}

//MARK: GestureRecognaze Metods
extension ImageShowViewController {
    
    @objc private func swipeDownAction(){
        self.dismiss(animated: true)
    }
    
    @objc private func hideNavBarAndTabBar(){
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
    
     @objc private func panGestureAction(_ sender: UIPanGestureRecognizer) {
         switch sender.state {
         case .began:
             switch sender.translation(in: view).x {
             case 0:
                 break
             case ...0:
                 //left
                 guard fotoAlbum.count - 1 >= currentIndexPuthFoto + 1 else {return}
                 animationDirection = .left
                 self.secondImageView.transform = CGAffineTransform(translationX: 1.5*self.secondImageView.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                 secondImageView.image = fotoAlbum[currentIndexPuthFoto + 1].image
                 
                 propertyAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                           curve: .linear,
                                                           animations: {
                     self.firstImageView.transform = CGAffineTransform(translationX: -1.3*self.firstImageView.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
                     self.secondImageView.transform = .identity
                 })
                 
                 propertyAnimator.addCompletion { [self] position in
                     switch position {
                     case .end:
                         currentIndexPuthFoto += 1
                         firstImageView.image = fotoAlbum[currentIndexPuthFoto].image
                         firstImageView.transform = .identity
                         secondImageView.image = nil
                     case .start:
                         secondImageView.transform = CGAffineTransform(translationX: 1.5*secondImageView.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                     case .current:
                         break
                     @unknown default:
                         break
                     }
                     likeButton.setConfig(for: fotoAlbum[currentIndexPuthFoto])
                     navItems.title = "\(currentIndexPuthFoto + 1) из \(fotoAlbum.count)"
                 }
             case 0...:
                 // right
                 guard currentIndexPuthFoto >= 1 else {return}
                 animationDirection = .right
                 self.secondImageView.transform = CGAffineTransform(translationX: -1.5*self.secondImageView.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                 self.secondImageView.image = fotoAlbum[currentIndexPuthFoto - 1].image
                 propertyAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                           curve: .linear,
                                                           animations: {
                     self.firstImageView.transform = CGAffineTransform(translationX: 1.3*self.firstImageView.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
                     self.secondImageView.transform = .identity
                 })
                 
                 propertyAnimator.addCompletion { [self] position in
                     switch position {
                     case .end:
                         currentIndexPuthFoto -= 1
                         firstImageView.image = fotoAlbum[currentIndexPuthFoto].image
                         firstImageView.transform = .identity
                         secondImageView.image = nil
                     case .start:
                         secondImageView.transform = CGAffineTransform(translationX: -1.5*secondImageView.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                     case .current:
                         break
                     @unknown default:
                         break
                     }
                     likeButton.setConfig(for: fotoAlbum[currentIndexPuthFoto])
                     navItems.title = "\(currentIndexPuthFoto + 1) из \(fotoAlbum.count)"
                 }
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
    
    
}

//MARK: Make constraints
extension ImageShowViewController {
    
    private func makeConstraints() {
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

