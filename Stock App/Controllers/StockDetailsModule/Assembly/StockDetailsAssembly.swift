//
//  StockDetailsAssembly.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 01.08.2022.
//

import Foundation

protocol StockDetailsModuleInput {
    func configure(with stockSymbol: String, and companyName: String)
}

typealias StockDetailsModuleConfiguration = (StockDetailsModuleInput) -> Void

final class StockDetailsAssembly{
    func assemble(_ configuration: StockDetailsModuleConfiguration) -> StockDetailsViewController {
        let vc = StockDetailsViewController()
        let collectionView = FinancialDataAssembly().assemble { [weak self] input in
            input.configure(with: vc.symbol, and: vc.companyName)
        }
        vc.collectionView = collectionView
       // vc.setViews(subViews: [collectionView])
        return vc
    }
}


