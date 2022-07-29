//
//  Search.swift
//  Stock App
//
//  Created by Айгерим Абдурахманова on 26.07.2022.
//

import Foundation

struct SearchSymbolsRequest: RequestProtocol {
    var query: String
    
    init(query: String) {
        self.query = query
    }
    
    var path: String {
        "/search"
    }
    
    var requestType: RequestType {
        .GET
    }
    
    var urlParams: [String : String] {
        var params = ["q": query]
        return params
    }
}

