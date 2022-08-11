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
        "finnhub.io"
    }
    
    var params: [String : String] {
        [:]
    }
    
    var urlParams: [String: String] {
        [:]
    }
    
    func createURL() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = "/api/v1" + path
        
        var query = [URLQueryItem]()
        for (name, value) in urlParams {
            query.append(.init(name: name, value: value))
        }
        query.append(.init(name: "token", value: APIConstants.apiKey))
        
        components.queryItems = query
        
        return components.url!
    }
}


