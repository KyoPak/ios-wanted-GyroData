//
//  FileSystemManager.swift
//  GyroData
//
//  Created by Kyo, JPush on 2023/01/30.
//

import Foundation

final class FileSystemManager {
    private enum FileConstant {
        static let directoryName = "Sensor_JSON_Folder"
        static let jsonExtensionName = ".json"
    }
    
    private let fileManager = FileManager.default
    private let documentPath: URL
    private let directoryPath: URL
    
    init() {
        documentPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[.zero]
        directoryPath = documentPath.appendingPathExtension(FileConstant.directoryName)
        createDirectory()
    }
    
    private func createDirectory() {
        guard !fileManager.fileExists(atPath: directoryPath.path) else { return }
        do {
            try fileManager.createDirectory(
                at: directoryPath,
                withIntermediateDirectories: false
            )
        } catch let error {
            //TODO: - Error Alert
            print(error.localizedDescription)
        }
    }
    
    private func convertJSON(from data: MeasureData) -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601
        
        guard let data = try? encoder.encode(data) else { return nil }
        return data
    }
}
