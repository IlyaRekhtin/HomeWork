//
//  ImageShowViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 27.02.2022.
//

import UIKit


class ImageShowViewController: UIViewController {
    
    
    @IBOutlet weak var imageViewForFoto: UIImageView!
    @IBOutlet weak var likeCountLable: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var user: User!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSetup()
        imageShowVCApperians()
    }
    
    private func setSetup() {
        let foto = user.fotoAlbum[index]
        
        imageViewForFoto.image = foto.image
        likeCountLable.text = String(foto.likesCount)
        likeButton.configuration?.image = user.fotoAlbum[index].myLike ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
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
    
    @IBAction func likeButtonAction(_ sender: Any) {
        switch user.fotoAlbum[index].myLike {
        case true:
            user.fotoAlbum[index].deleteLikes()
            likeButton.configuration?.image = UIImage(systemName: "heart")
            likeCountLable.text = String(user.fotoAlbum[index].likesCount)
        case false:
            user.fotoAlbum[index].addLikes()
            likeButton.configuration?.image = UIImage(systemName: "heart.fill")
            likeCountLable.text = String(user.fotoAlbum[index].likesCount)
        }
    }
    
   
}
