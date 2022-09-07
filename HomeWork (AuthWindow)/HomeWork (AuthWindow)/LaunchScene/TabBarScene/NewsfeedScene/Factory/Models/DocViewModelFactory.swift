//
//  DocViewModelFactory.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 25.08.2022.
//

import Foundation

class DocViewModelFactory {
    
    private let mbait = 0.0000009537
    
    func constructViewModel(_ attachments: [Attachment]?) -> [DocViewModel]? {
        let docs = self.sortAttachmentForDocs(attachments)
        return docs.compactMap(self.docViewModel(for:))
    }
    
  private func sortAttachmentForDocs(_ attachments: [Attachment]?) -> [Doc] {
        guard let attachments = attachments else {
            return []
        }
        var items = [Doc]()
        attachments.forEach { attachment in
            guard let doc = attachment.doc else {return}
            items.append(doc)
        }
        return items
    }
    
    private func docViewModel(for doc: Doc) -> DocViewModel? {
        guard let docNameLable = doc.title else {return nil}
        let size = doc.size
        let docSize = NSString(format: "%.1f", Double(size ?? 0) * mbait)
        let docDate = getCurrentTime(for: doc.date ?? 0)
        let docSubLable = "\(docSize) Mb ・ \(docDate)"
        return DocViewModel(docNameLable: docNameLable, docSubLable: docSubLable)
    }
    
    private func getCurrentTime(for timeInterval: Int) -> String {
        let dateNews = Date(timeIntervalSince1970: Double(timeInterval))
        let dateFormatterForTime = DateFormatter()
        dateFormatterForTime.timeZone = .current
        dateFormatterForTime.locale = .current
        dateFormatterForTime.dateFormat = "dd.MM.yy HH:mm"
        return dateFormatterForTime.string(from: dateNews)
    }
}
