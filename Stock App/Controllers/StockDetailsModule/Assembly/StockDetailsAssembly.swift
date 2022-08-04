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
        
        let shortInfoView = ShortInfoAssembly().assemble { input in
            input.configure(with: stockSymbol, and: companyName)
        }
        
        let chartView = ChartViewAssembly().assemble { input in
            input.configure(with: stockSymbol)
        }
        
        let collectionView = FinancialDataAssembly().assemble { input in
            input.configure(with: stockSymbol, and: companyName)
        }
        
        let newsVc = NewsViewAssembly().assembly(newsType: .company(symbol: stockSymbol))
        
        vc.symbol = stockSymbol
        vc.companyName = companyName
        
        vc.shortInfoView =  shortInfoView
        vc.chartView = chartView
        vc.collectionView = collectionView
        vc.newsController = newsVc
        
        return vc
    }
}
