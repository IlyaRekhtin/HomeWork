//
//  PhotoAlbumService.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 30.05.2022.
//

import Foundation

final class PhotoAlbumService: PhotoServiceProtocol {
    
    func getPhotos(for userID: Int, complition:@escaping (Photos) -> ()){
        DispatchQueue.global(qos: .userInteractive).async {
            let params = ["owner_id": String(userID),
                     "extended": "1",
                     "photo_sizes": "1",
                     "count": "20",
                     "no_service_albums":"1",
                     "access_token": Session.data.token,
                     "v": Api.shared.apiVersion
             ]
            guard let url = URL.configureURL(method: .photosGetAll, baseURL: .api, params: params) else {return}
             let request = URLRequest(url: url)
             URLSession.shared.dataTask(with: request) { data, _, error in
                 if let error = error {
                     print(error.localizedDescription)
                 }
                 guard let data = data else {return}
                 do {
                     let photos = try JSONDecoder().decode(PhotosResponse.self, from: data).photos
                     complition(photos)
                 }catch{
                     print(String(describing: error))
                 }
             }.resume()
        }
    }
}
