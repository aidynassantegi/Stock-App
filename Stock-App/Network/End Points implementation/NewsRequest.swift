//
//  NewsRequest.swift
//  Stock App
//
//  Created by Айгерим Абдурахманова on 26.07.2022.
//

import Foundation

struct MarketNewsRequest: RequestProtocol {
    
    var type: NewsType
    
    init(type: NewsType) {
        self.type = type
    }
    
    var path: String {
        switch type {
        case .topNews:
            print(EndPoint.news.rawValue)
            return EndPoint.news.rawValue
        case .company(let symbol):
            return "/company-news"
        }
    }
    
    var requestType: RequestType {
        .GET
    }
    
    var urlParams: [String : String] {
        var params: [String: String] = [:]
        switch type {
        case .topNews:
            params = ["category" : "general"]
        case .company(let symbol):
            let today = Date()
            let oneMonthBack = today.addingTimeInterval(-(3600 * 24 * 30))
            params = ["symbol" : symbol, "from" : DateFormatter.newsDateFormatter.string(from: oneMonthBack), "to" : DateFormatter.newsDateFormatter.string(from: today)]
        }
        return params
    }
    
}
