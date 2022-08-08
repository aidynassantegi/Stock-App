//
//  TableViewModel.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 28.07.2022.
//

import Foundation
import UIKit

struct TableViewModel {
    let symbol: String
    let companyName: String
    let price: String
    let isFavorite: Bool
    let changeColor: UIColor // red or green
    let changePercentage: String
    let logo: String
    let currency: String
    let chartView: StockChartView.ViewModel
}
