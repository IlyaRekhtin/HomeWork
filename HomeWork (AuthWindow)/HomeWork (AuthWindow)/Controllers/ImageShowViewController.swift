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
    private let buttonLike: Like = {
        let button = Like(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.configuration = .plain()
        return button
    }()
    var user: User!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSetup()
        imageShowVCApperians()
        makeConstraints()
    }
    
    private func setSetup() {
        let foto = user.fotoAlbum[index]
        
        buttonLike.setConfig(for: foto)
        
        buttonLike.addAction(UIAction(handler: { [self] _ in
            switch user.fotoAlbum[index].myLike {
            case true:
                user.fotoAlbum[index].deleteLikes()
                buttonLike.configuration?.image = UIImage(systemName: "heart")
                buttonLike.configuration?.title = String(user.fotoAlbum[index].likesCount)
            case false:
                user.fotoAlbum[index].addLikes()
                buttonLike.configuration?.image = UIImage(systemName: "heart.fill")
                buttonLike.configuration?.title = String(user.fotoAlbum[index].likesCount)
            }
        }), for: .touchDown)
        
        imageViewForFoto.image = foto.image
    }
    
    private func imageShowVCApperians() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .black
        tabBarController?.tabBar.isHidden = true
        let titleForNavBar: UILabel = {
            let lable = UILabel()
            lable.text = "Фотография"
            lable.font = UIFont(name: "Apple Color Emoji", size: 22)
            lable.textColor = .white
            return lable
        }()
        navigationItem.titleView = titleForNavBar
        navigationItem.backButtonTitle = ""
    }
    
    private func makeConstraints() {
        bottomViewForButton.addSubview(buttonLike)
        
        buttonLike.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
    }
    
   
}
