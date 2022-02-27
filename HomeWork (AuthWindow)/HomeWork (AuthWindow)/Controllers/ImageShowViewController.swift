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
    var foto: Foto!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewForFoto.image = foto.image
        likeCountLable.text = String(foto.likesCount)
    
        imageShowVCApperians()
    }
    
    private func imageShowVCApperians() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .black
        tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
        switch foto.myLike {
        case true:
            foto.deleteLikes()
            likeButton.configuration?.image = UIImage(systemName: "heart")
            likeCountLable.text = String(foto.likesCount)
        case false:
            foto.addLikes()
            likeButton.configuration?.image = UIImage(systemName: "heart.fill")
            likeCountLable.text = String(foto.likesCount)
        }
    }
}
