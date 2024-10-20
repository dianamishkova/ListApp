//
//  DefaultNetworkingService.swift
//  testAPI
//
//  Created by Диана Мишкова on 19.10.24.
//

import UIKit
import UniformTypeIdentifiers
import MobileCoreServices

class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    private let baseURL = "https://junior.balinasoft.com"
    
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getItems(page: Int, completion: @escaping getItemsListAPIResponse) {
        guard let url = URL(string: baseURL + "/api/v2/photo/type?page=\(page)") else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ = error {
                completion(.failure(.networkError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let items = try decoder.decode(PagePhotoTypeDtoOut.self, from: data)
                completion(.success(items))
            } catch {
                completion(.failure(.parsingError))
            }
        }
        task.resume()
    }
    
    func postItem(photo: Photo, completion: @escaping getItemAPIResponse) {
        
        let url = URL(string: "https://junior.balinasoft.com/api/v2/photo")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("*/*", forHTTPHeaderField: "accept")
        request.setValue("multipart/form-data; boundary=Boundary", forHTTPHeaderField: "Content-Type")
        
        let boundary = "Boundary"
        
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"name\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(photo.name)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"typeId\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(photo.typeId)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"\(photo.filename).jpeg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(photo.imageData)
        body.append("\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response code: \(response.statusCode)")
            }
            
            if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("Response data: \(responseString ?? "No data")")
            }
        }
        
        task.resume()
    }
    
}
