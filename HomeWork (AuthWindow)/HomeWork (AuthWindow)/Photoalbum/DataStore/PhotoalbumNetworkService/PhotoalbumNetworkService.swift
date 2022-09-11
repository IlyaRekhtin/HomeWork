//
//  PhotoalbumNetworkService.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//
import PromiseKit
import UIKit

final class PhotoalbumNetworkService: PhotoalbumNetworkServiceProtocol {
    enum AppError: String, Error {
        case urlError = "url not found"
        case decodeError = "don't decode"
        case fetchError = "don't fetch"
    }
    
    func getURL(for userID: Int) -> Promise<URL> {
        let params = ["owner_id": String(userID),
                      "extended": "1",
                      "photo_sizes": "0",
                      "count": "20",
                      "no_service_albums":"1",
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
        ]
        return Promise { resolver in
            guard let url = URL.configureURL(method: .photosGetAll, baseURL: .api, params: params) else {
                resolver.reject(AppError.urlError)
                return
            }
            resolver.fulfill(url)
        }
    }
    
    func fetchData(_ url: URL) -> Promise<Data> {
        return Promise { resolver in
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else {
                    resolver.reject(AppError.fetchError)
                    return
                }
                resolver.fulfill(data)
            }.resume()
        }
    }
    
    func parsedData(_ data: Data) -> Promise<[Photo]> {
        return Promise { resolver in
            do {
                let items = try JSONDecoder().decode(PhotosResponse.self, from: data).photos.items
                resolver.fulfill(items)
            }catch{
                resolver.reject(AppError.decodeError)
            }
        }
    }
    
    
    func getCurrentUrl(_ photos: [Photo]) -> Promise<[String]> {
        return Promise { resolver in
            let imagesURL = photos.map { photo in
                getPhotoUrl(photo.sizes)
            }
            resolver.fulfill(imagesURL)
        }
    }
    
    private func getPhotoUrl(_ sizes: [Size]) -> String {
        sizes.filter({$0.type?.rawValue == "x"}).first?.url ?? ""
    }
}