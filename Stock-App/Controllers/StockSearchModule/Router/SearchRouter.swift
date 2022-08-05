//
//  SearchRouter.swift
//  Stock-App
//
//  Created by Aidyn Assan on 04.08.2022.
//

import UIKit

protocol SearchRouterInput: AnyObject {
    func openChart(with symbol: String, and companyName: String)
}

protocol SearchRouterOutput: AnyObject {
    func searchedStocks(vc: LastSearchedViewController)
}

final class SearchRouter: SearchRouterInput {
    weak var presenter: SearchRouterOutput?
    weak var viewController: UIViewController?
    func openChart(with symbol: String, and companyName: String) {        
        let vc = StockDetailsAssembly().assemble(symbol, companyName)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showSearchedStocks() {
        presenter?.searchedStocks(vc: LastSearchAssembler().assemble())
    }
}
