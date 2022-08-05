//
//  SearchRouter.swift
//  Stock-App
//
//  Created by Aidyn Assan on 04.08.2022.
//

import UIKit

protocol SearchRouterInput: AnyObject {
    func searchedCollection() -> LastSearchedViewController
    func openChart(with symbol: String, and companyName: String)
}


final class SearchRouter: SearchRouterInput {
    var lastSearched: LastSearchedViewController?
    weak var viewController: UIViewController?
    func openChart(with symbol: String, and companyName: String) {        
        let vc = StockDetailsAssembly().assemble(symbol, companyName)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchedCollection() -> LastSearchedViewController {
        return lastSearched ?? LastSearchedViewController()
    }
}
