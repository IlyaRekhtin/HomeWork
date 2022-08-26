//
//  LinkViewModelFactory.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 25.08.2022.
//

import Foundation

class LinkViewModelFactory {
    func constructViewModel(for attachments: [Attachment]?) -> LinkViewModel? {
        let link = sortAttachmentForLinks(attachments)
        let linkURL = link.url
        guard let photos = link.photo else {return nil}
        let photoURL = Photo.preview(in: Array(photos.sizes))
        guard let url = URL(string: photoURL) else {return nil}
        let linkTitle = link.title ?? ""
        let linkSubTitle = link.caption ?? ""
        return LinkViewModel(linkURL: linkURL, linkImage: url, linkTitle: linkTitle, linkSubTitle: linkSubTitle)
    }
    
    func sortAttachmentForLinks(_ attachments: [Attachment]?) -> Link {
        var items = [Link]()
        if let attachments = attachments {
            attachments.forEach { attachment in
                guard let link = attachment.link else {return}
                items.append(link)
            }
        }
        return items.first!
    }
}
