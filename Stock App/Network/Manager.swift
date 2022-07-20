//
//  Manager.swift
//  Network
//
//  Created by Aigerim Abdurakhmanova on 20.07.2022.
//

import Foundation

protocol StocksData: AnyObject {
    func searchStocks(query: String, completion: @escaping (Result<SearchResponse, Error>) -> Void)
    func news(query: String, completion: @escaping (Result<[News], Error>) -> Void)
    
}

class NetworkManager: StocksData {
    
    static let shared = NetworkManager()
    private var requestManager: RequestManager = .requestManangerShared
    private var urlEncoder: URLParametersEncoder = .urlEncoder
        
    private init() {}
    
    func searchStocks(query: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        requestManager.request(url: urlEncoder.url(for: .search, queryParams: ["q":query]), expecting: SearchResponse.self, completion: completion)
    }
    
    func news(query: String, completion: @escaping (Result<[News], Error>) -> Void) {
        
        //market news
        requestManager.request(url: urlEncoder.url(for: .news, queryParams: ["category":"general"]), expecting: [News].self, completion: completion)
        
        //write end point for company news, use enum
    }
    
}
