//
//  StockDetailsAssembly.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 01.08.2022.
//

import Foundation
import UIKit

protocol StockDetailsModuleInput {
    func configure(with stockSymbol: String, and companyName: String)
}

typealias StockDetailsModuleConfiguration = (StockDetailsModuleInput) -> Void

final class StockDetailsAssembly{
    
    func assemble(_ stockSymbol: String, _ companyName: String) -> StockDetailsViewController {
    
        let vc = StockDetailsViewController()
        
        let chartView = ChartViewAssembly().assemble { input in
            input.configure(with: stockSymbol)
        }
        
        let collectionView = FinancialDataAssembly().assemble { input in
            input.configure(with: stockSymbol, and: companyName)
        }
        
        vc.chartView = chartView
        vc.collectionView = collectionView
        return vc
    }
}
