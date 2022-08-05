//
//  SymbolsRequest.swift
//  Stock App
//
//  Created by Айгерим Абдурахманова on 26.07.2022.
//

import Foundation

struct SymbolsRequest: RequestProtocol {
    
    var path: String {
        EndPoint.symbols.rawValue
    }
    
    var requestType: RequestType {
        .GET
    }
    
    var urlParams: [String : String] {
        let params = ["exchange" : "US"]
        return params
    }
}
