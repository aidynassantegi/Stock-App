//
//  StockListPresenter.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 27.07.2022.
//

import Foundation

final class StockListPresenter: StockListInteractorOutput, StockListViewOutput {
    
    weak var view: StockListViewInput!
    var interactor: StockListInteractorInput!
    var router: StockListRouterInput!
    
    func didLoadStockSymbols(_ symbols: [StockSymbols]) {
        //view.handleObtainedSymbols(symbols)
        interactor.obtainCompanyProfiles(with: symbols)
    }
    
    func didLoadCompanyProfiles(_ companies: [CompanyProfile]) {
        view.handleObtainedCompanyProfiles(companies)
    }
    
    func didLoadView() {
        interactor.obtainStockSymbols()
//        print(symbols)
//        interactor.obtainCompanyProfiles(with: symbols)
    }
    
    func didSelectStockSell(with index: Int) {
        router.openChart(with: index)
    }
}
