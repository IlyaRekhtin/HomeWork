//
//  PhotoService.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 24.06.2022.
//

import Foundation
import UIKit

protocol DataReloadable {
    func reloadRow(at indexPath: IndexPath)
}

final class PhotoService {
    
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
    private var container: DataReloadable
    
    init(tableView: UITableView) {
        self.container = Table(table: tableView)
    }
    
    init(collectionView: UICollectionView) {
        self.container = Collection(collection: collectionView)
    }
    
    func photo(at indexPath: IndexPath, by url: String) -> UIImage? {
        var image: UIImage?
        
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(at: indexPath, by: url)
        }
        return image
    }
}


//MARK: - private methods
private extension PhotoService {
    /// Получаем путь с именем файла
    /// - Parameter url: адрес файла в интернете
    /// - Returns: путь к файлу в дериктории
    func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        let hashName = url.split(separator: "/").last ?? "default" /// получаем имя изображения из его адреса
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
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
    
    func loadPhoto(at indexPath: IndexPath, by url: String) {
        guard let imageURL = URL(string: url) else {return}
        let request = URLRequest(url: imageURL)
        URLSession.shared.dataTask(with: request) { data, _, _ in
           
                guard let data = data,
                      let image = UIImage(data: data) else {return}
                DispatchQueue.main.async {
                    self.images[url] = image /// сохраняем в массив
                }
                self.saveImageToCaches(url: url, image: image) /// заполняем кеш
                DispatchQueue.main.async {
                    self.container.reloadRow(at: indexPath)
                }
        }.resume()
    }
}
