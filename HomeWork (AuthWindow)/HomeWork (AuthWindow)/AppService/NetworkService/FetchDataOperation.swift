//
//  FetchDataOperation.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 17.06.2022.
//

import Foundation

class FetchDataOperation: AsyncOperation {
    
    private var request: URLRequest
    var data: Data?
    
    override func cancel() {
        self.cancel()
    }
    
    override func main() {
            URLSession.shared.dataTask(with: self.request) { data, _, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let data = data else {return}
                self.data = data
                self.state = .finished
            }.resume()
    }
    
    init(for request: URLRequest) {
        self.request = request
    }
    
    
    
}
