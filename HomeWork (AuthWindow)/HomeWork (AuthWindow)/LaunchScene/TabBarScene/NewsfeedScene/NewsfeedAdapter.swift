//
//  NewsfeedAdapter.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 24.08.2022.
//

import Foundation

final class NewsfeedAdapter {
    
    private let service = NewsfeedService()
    
    func fetchNewsfeed(complition:@escaping (Newsfeed) -> ()){
        service.getURL()
            .then(on: .global(), service.fetchData(_:))
            .then(on: .global(), service.parsedData(_:))
            .done(on: .main) { newsfeed in
                complition(newsfeed)
            }.catch { error in
                print(error.localizedDescription)
            }
    }
    
    func fetchNewsfeed(from date: String, complition:@escaping (Newsfeed) -> ()){
        service.getURL(from: date)
            .then(on: .global(), service.fetchData(_:))
            .then(on: .global(), service.parsedData(_:))
            .done(on: .main) { newsfeed in
                complition(newsfeed)
            }.catch { error in
                print(error.localizedDescription)
            }
    }
    
    func fetchNewsfeed(with nextform: String, complition:@escaping (Newsfeed) -> ()){
        service.getURL(with: nextform)
            .then(on: .global(), service.fetchData(_:))
            .then(on: .global(), service.parsedData(_:))
            .done(on: .main) { newsfeed in
                complition(newsfeed)
            }.catch { error in
                print(error.localizedDescription)
            }
    }
}
