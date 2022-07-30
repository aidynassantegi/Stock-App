//
//  APIManager.swift
//  Stock App
//
//  Created by Айгерим Абдурахманова on 25.07.2022.
//

import Foundation

protocol APIManagerProtocol {
    func perform<T: Codable>(_ request: RequestProtocol, completion: @escaping (Result< T,Error>) -> Void)
}

class APIManager: APIManagerProtocol {
   
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func perform<T: Codable>(_ request: RequestProtocol, completion: @escaping (Result<T, Error>) -> Void) {
        
        let task = urlSession.dataTask(with: request.createURL()) { data, response, error in
            guard let data = data, error == nil else {
    
                if let error = error {
                    completion(.failure(error))
                }else {
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200  else {
                completion(.failure(APIError.httpRequestFailed))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
               //print(result)
                DispatchQueue.main.async{
                    completion(.success(result))
                }
            }catch {
                DispatchQueue.main.async{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

