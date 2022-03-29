//
//  CollectionViewCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 18.03.2022.
//

import UIKit
import SnapKit

class ImagesCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "images"
    
    var foto: Foto?
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config (_ image: Foto) {
        imageView.image = image.image
        foto = image
    }
    
    
    private func setConstraints() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
}
