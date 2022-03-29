//
//  ImageShowViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 27.02.2022.
//

import UIKit
import SnapKit

class ImageShowViewController: UIViewController {
    
    
    @IBOutlet weak var imageViewForFoto: UIImageView!
    @IBOutlet weak var bottomViewForButton: UIView!
    private let likeButton: Like = {
        let button = Like(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.configuration = .plain()
        return button
    }()
    var foto: Foto!
//    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSetup()
        imageShowVCApperians()
        makeConstraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    
    private func setSetup() {
//        guard let index = index else {return}
        
        likeButton.setConfig(for: foto)
        
        likeButton.addAction(UIAction(handler: { [self] _ in
            foto.myLike.toggle()
            likeButton.animationImageChange()
            likeButton.setConfig(for: foto)
            
        }), for: .touchUpInside)
        imageViewForFoto.image = foto.image
    }
    
    private func imageShowVCApperians() {
        
        navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.appearanceForNavBarImageShowVC()
        navigationController?.navigationBar.compactAppearance = Appearance.data.appearanceForNavBarImageShowVC()
        navigationController?.navigationBar.standardAppearance = Appearance.data.appearanceForNavBarImageShowVC()
        navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.appearanceForNavBarImageShowVC()
       
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Фотография"
        navigationItem.backButtonTitle = ""
        
        tabBarController?.tabBar.isHidden = true
    }
    
    private func makeConstraints() {
        bottomViewForButton.addSubview(likeButton)
        
        likeButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
    }
    
   
}
