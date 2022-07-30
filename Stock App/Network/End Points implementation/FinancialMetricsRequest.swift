//
//  FinancialMetricsRequest.swift
//  Stock App
//
//  Created by Айгерим Абдурахманова on 26.07.2022.
//

import Foundation

struct FinancialMetricsRequest: RequestProtocol{
    var symbol: String
    
    init(symbol: String) {
        self.symbol = symbol
    }
    
    var path: String {
        "/stock/metric"
    }
    
    var requestType: RequestType {
        .GET
    }
    
    var urlParams: [String : String] {
        var params = ["symbol" : symbol,
                      "metric" : "all"]
        return params
    }
    
}
