//
//  FinancialMetrics.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 21.07.2022.
//

import Foundation

struct FinancialMetrics: Codable {
    let metric: Metrics
    let symbol: String
}

struct Metrics: Codable {
    let TenDayAverageTradingVolume: Float?
    let AnnualWeekHigh: Double?
    let AnnualWeekLow: Double?
    let AnnualWeekLowDate: String?
    let AnnualWeekPriceReturnDaily: Float?
    let beta: Float?
    
    enum CodingKeys: String, CodingKey {
        case TenDayAverageTradingVolume = "10DayAverageTradingVolume"
        case AnnualWeekHigh = "52WeekHigh"
        case AnnualWeekLow = "52WeekLow"
        case AnnualWeekLowDate = "52WeekLowDate"
        case AnnualWeekPriceReturnDaily = "52WeekPriceReturnDaily"
        case beta
    }
}
