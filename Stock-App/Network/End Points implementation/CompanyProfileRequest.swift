//
//  CompanyProfileRequest.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 27.07.2022.
//

import Foundation

struct CompanyProfileRequest: RequestProtocol {
    
    var symbol: String
    
    init(symbol: String) {
        self.symbol = symbol
    }
    
    var path: String {
        EndPoint.companyProfile.rawValue
    }
    
    var requestType: RequestType {
        .GET
    }
    
    var urlParams: [String : String] {
        let params = ["symbol" : symbol]
        return params
    }
}
