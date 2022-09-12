//
//  PhotoViewerTabBar.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 12.09.2022.
//


import UIKit
import SnapKit

final class PhotoViewerTabBar: UIView {
    //CustomTabBar
    private var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    var likeButton: PhotoViewerLikeButton = {
        let button = PhotoViewerLikeButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        stackView.addArrangedSubview(likeButton)
        stackView.addArrangedSubview(spacer)
        stackView.addArrangedSubview(spacer2)
        self.addSubview(stackView)
        makeConstraints()
    }
    
    convenience init(_ item: Likeble & Reposteble) {
        self.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        likeButton.setConfig(for: item)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - snap kit
private extension PhotoViewerTabBar {
    func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview().inset(3)
        }
    }
}
