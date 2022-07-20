//
//  RequestManager.swift
//  Network
//
//  Created by Aigerim Abdurakhmanova on 20.07.2022.
//

import Foundation

enum APIError: Error {
    case noDataReturned
    case invalidUrl
    case httpRequestFailed
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noDataReturned:
            return "Error: Did bot receive data"
        case .invalidUrl:
            return "Error: Invalid url"
        case .httpRequestFailed:
            return "Error: HTTP request failed"
        }
    }
}

struct RequestManager {
    
    static var requestManangerShared = RequestManager()
    
    public func request<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

        guard let url = url else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }else {
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                completion(.failure(APIError.httpRequestFailed))
                return
            }

            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
