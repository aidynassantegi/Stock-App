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
    
    func assemble(_ configuration: StockDetailsModuleConfiguration) -> StockDetailsViewController {
        let vc = StockDetailsViewController()
        
        let collectionView = FinancialDataAssembly().assemble { input in
            input.configure(with: "AAPL", and: "Apple Inc.")
        }
        
        vc.collectionView = collectionView
        return vc
    }
}

//
//final class StockDetailsPresenter: StockDetailsModuleInput {
//    private var symbol: String!
//    var stockDetailsRouter: StockDetailsRouterInput!
//    
//    func configure(with stockSymbol: String, and companyName: String) {
//        self.symbol = stockSymbol
//    }
//}
//
//protocol StockDetailsRouterInput {
//    func sendStockSymbol(_ symbol: String)
//}
//
//final class StockDetailsRouter: StockDetailsRouterInput {
//    weak var financeDataView: UIView?
//    
//    func sendStockSymbol(_ symbol: String) {
//        let view = FinancialDataAssembly().assemble {  input in
//            input.configure(with: symbol, and: "name")
//        }
//    }
//}
