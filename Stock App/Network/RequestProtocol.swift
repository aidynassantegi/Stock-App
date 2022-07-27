//
//  RequestProtocol.swift
//  Stock App
//
//  Created by Айгерим Абдурахманова on 25.07.2022.
//

import Foundation

protocol RequestProtocol {
    var path: String { get }
    
    var params: [String : String] { get }
    var urlParams: [String: String] { get }
    
    var requestType: RequestType { get }
}

extension RequestProtocol {
    
    var host: String {
        APIConstants.baseUrl
    }
    
    var params: [String : String] {
        [:]
    }
    
    var urlParams: [String: String] {
        [:]
    }
    
    func createURL() -> URL {
        var urlString = host + path
        if !urlParams.isEmpty {
            var queryItems = [URLQueryItem]()
            for (name, value) in urlParams {
                queryItems.append(.init(name: name, value: value))
            }
            
            queryItems.append(.init(name: "token", value: APIConstants.apiKey))
            urlString += "?" + queryItems.map { "\($0.name)=\($0.value ?? "")"}.joined(separator: "&")
            print(urlString)
        }
        
        return URL(string: urlString)!
    }
}


