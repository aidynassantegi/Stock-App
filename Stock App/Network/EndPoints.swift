//
//  EndPoints.swift
//  Stock App
//
//  Created by Айгерим Абдурахманова on 26.07.2022.
//

import Foundation
import SwiftUI

enum EndPoint: String {
    case search = "/search"
    case news = "/news"
    case companyNEws = "/company-news"
    case marketData = "/stock/candles"
    case financials = "/stock/metrics"
    case symbols = "/stock/symbol"
}
