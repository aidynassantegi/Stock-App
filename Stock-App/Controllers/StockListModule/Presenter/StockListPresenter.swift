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
        interactor.obtainCandleSticks(with: companies)
        view.handleObtainedCompanyProfiles(companies)
    }
    
    func didLoadCandleSticks(_ tableViewModel: [TableViewModel]) {
        view.handleObtainedTableViewModel(tableViewModel)
    }
    
//    func didLoadCandleSticks(_ companiesMap: [CompanyProfile : [CandleStick]]) {
//        print("didLoadCandleSticks")
//        view.handleObtaindeCompaniesMap(companiesMap)
//    }
    
    func didLoadView() {
        interactor.obtainStockSymbols()
    }
    
    func didSelectStockSell(with symbol: String, companyName: String) {
        router.openChart(with: symbol, and: companyName)
    }
}
