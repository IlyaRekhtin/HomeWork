//
//  PhotoalbumRouter.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import UIKit

final class PhotoalbumRouter: PhotoalbumRouterProtocol {
    
    weak var entryPoint: EntryPoint?
    
    init(_ view: PhotoalbumViewProtocol) {
        self.entryPoint = view as? EntryPoint
    }
    
    func presentPhotoViewer( _ photoalbum: [Likeble & Reposteble], _ index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "PhotoViewerViewController") as? PhotoViewerViewController else {return}
        vc.assembly.configure(with: vc, photoalbum, index)
        entryPoint?.navigationController?.pushViewController(vc, animated: true)
    }
}

