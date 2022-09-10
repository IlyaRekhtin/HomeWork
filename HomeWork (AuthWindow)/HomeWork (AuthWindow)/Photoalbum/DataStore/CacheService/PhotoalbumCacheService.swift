//
//  PhotoalbumCacheService.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import UIKit
import PromiseKit

final class PhotoalbumCacheService: PhotoalbumCacheServiceProtocol {
    
    private let cachesTimeInterval: TimeInterval = 30 * 24 * 60 * 60
    ///имя папки для изображения
    private static let pathName: String = {
        let pathName = "images"
        
        guard var cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return pathName}
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true) /// создаем путь
        
        if !FileManager.default.fileExists(atPath: url.path) { /// если папка по этому пути не найден, создаем папку
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()
    private var images = [String: UIImage]()
    
    func getPhoto(by url: String) -> Promise<UIImage?> {
        return Promise { resolver in
            if let photo = images[url] {
                resolver.fulfill(photo)
            } else if let photo = getImageFromCache(url: url) {
                resolver.fulfill(photo)
            } else {
                guard let imageURL = URL(string: url) else {
                    return resolver.reject(Errors.noDataAvailable)
                }
                let request = URLRequest(url: imageURL)
                URLSession.shared.dataTask(with: request) { data, _, _ in
                    guard let data = data,
                          let image = UIImage(data: data) else {return}
                    DispatchQueue.main.async {
                        self.images[url] = image /// сохраняем в массив
                    }
                    self.saveImageToCaches(url: url, image: image)
                    resolver.fulfill(image)
                }.resume()
            }
        }
    }
}


//MARK: - private methods
private extension PhotoalbumCacheService {
    /// Получаем путь с именем файла
    /// - Parameter url: адрес файла в интернете
    /// - Returns: путь к файлу в дериктории
    func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        let hashName = url.split(separator: "/").last ?? "default" /// получаем имя изображения из его адреса
        return cachesDirectory.appendingPathComponent(PhotoalbumCacheService.pathName + "/" + hashName).path
    }
    
    func saveImageToCaches(url: String, image: UIImage) {
        guard let filePath = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: filePath, contents: data,
                                       attributes: nil)
    }
    
    func getImageFromCache(url: String) -> UIImage? {
        guard
            let filePath = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: filePath),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else {return nil}
        
        let timeLife = Date().timeIntervalSince(modificationDate)
        guard timeLife <= cachesTimeInterval,
              let image = UIImage(contentsOfFile: filePath)
        else {return nil}
        
        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }
}
