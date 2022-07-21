//
//  SearchResponse.swift
//  Network
//
//  Created by Aigerim Abdurakhmanova on 20.07.2022.
//

import Foundation

struct SearchResponse: Codable {
    let count: Int
    let result: [SearchResults]
}

struct SearchResults: Codable {
    let description: String
    let displaySymbol: String
    let symbol: String
    let type: String
}
