//
//  URLEncoding.swift
//  Network
//
//  Created by Aigerim Abdurakhmanova on 20.07.2022.
//

import Foundation

enum EndPoint: String {
    case search
    case news
    case companyNews = "company-news"
}

struct URLParametersEncoder {

    public static var urlEncoder = URLParametersEncoder()
    
    private struct Constants {
        static let apiKey = "cbbpt1aad3ibhoa29210"
        static let sandboxApiKey = "sandbox_cbbpt1aad3ibhoa2921g"
        static let baseUrl = "https://finnhub.io/api/v1/"
    }
    
    public func url(for endPoint: EndPoint, queryParams: [String: String] = [:]) -> URL? {
        var urlString = Constants.baseUrl + endPoint.rawValue
        
        var queryItems = [URLQueryItem]()
        queryItems.append(.init(name: "token", value: Constants.apiKey))
        for (name, value) in queryParams {
            queryItems.append(.init(name: name, value: value))
        }
        
        let queryString = queryItems.map { "\($0.name)=\($0.value ?? "")"}.joined(separator: "&")
        urlString += "?" + queryString
        
        print(urlString)
        return URL(string: urlString)
    }
}
