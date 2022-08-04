//
//  TickerViewEntity.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 04.08.2022.
//

import Foundation

struct TickerViewEntity {
    let stockSymbol: String
    let latestPrice: String
    let changePercentage: String
    let chartView: StockChartView.ViewModel
}
