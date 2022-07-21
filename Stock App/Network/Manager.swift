//
//  Manager.swift
//  Network
//
//  Created by Aigerim Abdurakhmanova on 20.07.2022.
//

import Foundation

protocol StocksServiceProtocol: AnyObject {
    func searchStocks(query: String, completion: @escaping (Result<SearchResponse, Error>) -> Void)
    func news(query: String, completion: @escaping (Result<[News], Error>) -> Void)
    func marketData(for symbol: String, numberOfDays: TimeInterval, completion: @escaping (Result<MarketDataResponse, Error>) -> Void)
    func financialMetrics(for symbol: String, completion: @escaping (Result<FinancialMetrics, Error>) -> Void)
}

class NetworkManager: StocksServiceProtocol {
    
    static let shared = NetworkManager()
    private var requestManager: RequestManager = .requestManangerShared
    private var urlEncoder: URLParametersEncoder = .urlEncoder
        
    private init() {}
    
    func financialMetrics(for symbol: String, completion: @escaping (Result<FinancialMetrics, Error>) -> Void) {
        let url = urlEncoder.url(for: .financials, queryParams: ["symbol" : symbol, "metric" : "all"])
        requestManager.request(url: url, expecting: FinancialMetrics.self, completion: completion)
    }
    
    func marketData(for symbol: String, numberOfDays: TimeInterval = 7, completion: @escaping (Result<MarketDataResponse, Error>) -> Void){
        let today = Date().addingTimeInterval(-(86400))
        let prior = today.addingTimeInterval(-(86400 * numberOfDays))
        let url = urlEncoder.url(for: .marketData, queryParams: ["symbol": symbol, "resolution": "1", "from": "\(Int(prior.timeIntervalSince1970))", "to": "\(Int(today.timeIntervalSince1970))"])
        requestManager.request(url: url, expecting: MarketDataResponse.self, completion: completion)
    }
    
    func searchStocks(query: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        guard let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        requestManager.request(url: urlEncoder.url(for: .search, queryParams: ["q":query]), expecting: SearchResponse.self, completion: completion)
    }
    
    func news(query: String, completion: @escaping (Result<[News], Error>) -> Void) {
        
        //market news
        requestManager.request(url: urlEncoder.url(for: .news, queryParams: ["category":"general"]), expecting: [News].self, completion: completion)
        
        //write end point for company news, use enum
    }
    
}
