//
//  MarketDataRequest.swift
//  Stock App
//
//  Created by Айгерим Абдурахманова on 26.07.2022.
//

import Foundation

struct MarketDataRequest: RequestProtocol {
    var symbol: String
    var numberOfDays: TimeInterval
    
    init(symbol: String, numberOfDays: TimeInterval) {
        self.symbol = symbol
        self.numberOfDays = numberOfDays
    }
    
    var path: String {
        EndPoint.marketData.rawValue
    }
    
    var requestType: RequestType {
        .GET
    }
    
    var urlParams: [String : String] {
        let today = Date().addingTimeInterval(-(86400))
        let prior = today.addingTimeInterval(-(86400 * numberOfDays))
        var params = ["symbol" : symbol, "resolution" : "1", "from" : "\(Int(prior.timeIntervalSince1970))", "to" : "\(Int(today.timeIntervalSince1970))"]
        return params
    }
}
