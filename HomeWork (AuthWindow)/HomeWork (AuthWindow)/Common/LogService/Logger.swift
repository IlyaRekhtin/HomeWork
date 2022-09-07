//
//  Logger.swift
//  XO-game
//
//  Created by Alexander Rubtsov on 12.08.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class Logger {
    private static let pathName: String = {
        let pathName = "logService"
        
        guard var cachesDirectory = FileManager.default.urls(for: .developerDirectory, in: .userDomainMask).first else {return pathName}
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true) /// создаем путь
        
        if !FileManager.default.fileExists(atPath: url.path) { /// если папка по этому пути не найден, создаем папку
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()
    
    private func getFilePath(date: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .developerDirectory, in: .userDomainMask).first else { return nil }
        let pathName = "\(date) log network service"
        return cachesDirectory.appendingPathComponent(pathName).path
    }
    
    func writeMessageToLog(_ message: String) {
        let date = Date.now
        let dateForrmater = DateFormatter()
        
        guard let filePath = getFilePath(date: dateForrmater.string(from: date)),
              let data = try? JSONEncoder().encode(message) else { return }
        FileManager.default.createFile(atPath: filePath,
                                       contents: data,
                                       attributes: nil)
        print(message)
    }
}
