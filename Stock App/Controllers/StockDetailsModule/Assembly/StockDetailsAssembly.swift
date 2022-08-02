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
    
    func assemble(_ stockSymbol: String) -> StockDetailsViewController {
    
        let vc = StockDetailsViewController()
        
        let collectionView = FinancialDataAssembly().assemble { input in
            input.configure(with: stockSymbol, and: "Apple Inc.")
        }
        
        vc.collectionView = collectionView
        return vc
    }
}
