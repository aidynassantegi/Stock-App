//
//  APIError.swift
//  Stock App
//
//  Created by Айгерим Абдурахманова on 26.07.2022.
//

import Foundation

enum APIError: Error {
    case noDataReturned
    case invalidUrl
    case httpRequestFailed
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noDataReturned:
            return "Error: Did bot receive data"
        case .invalidUrl:
            return "Error: Invalid url"
        case .httpRequestFailed:
            return "Error: HTTP request failed"
        }
    }
}
