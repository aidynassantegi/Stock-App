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

        interactor.obtainCompanyProfiles(with: symbols)
    }
    
    func didLoadCompanyProfiles(_ companies: [CompanyProfile]) {
        interactor.obtainCandleSticks(with: companies)
    }
    
    func didLoadCandleSticks(_ companiesCandles: [CompanyProfile : [CandleStick]]) {
        let viewModel = createViewModel(companiesCandles)
        view.handleObtainedTableViewModel(viewModel)
    }
    
    func didLoadCandleSticks(_ tableViewModel: [TableViewModel]) {
        view.handleObtainedTableViewModel(tableViewModel)
    }
        
    func didLoadView() {
        interactor.obtainStockSymbols()
    }
    
    func didSelectStockSell(with symbol: String, companyName: String) {
        router.openChart(with: symbol, and: companyName)
    }
    
    private func createViewModel(_ companiesMap: [CompanyProfile: [CandleStick]]) -> [TableViewModel] {
        var viewModel = [TableViewModel]()
        for (company, candleStick) in companiesMap {
            let changePercentage = CalculateStockPriceDynamic.getChangePercentage(for: candleStick)
            viewModel.append(.init(symbol: company.ticker,
                                   companyName: company.name,
                                   price: CalculateStockPriceDynamic.getLatestPrice(from: candleStick),
                                   isFavorite: false,
                                   changeColor: changePercentage < 0 ? .systemRed : .systemGreen,
                                   changePercentage: String.percentage(from: changePercentage),
                                   logo: company.logo,
                                   currency: company.currency,
                                   chartView: .init(data: candleStick.reversed().map{ $0.close}, showLegend: false, showAxis: false, fillColor: changePercentage < 0 ? .systemRed : .systemGreen, timeStamp: candleStick.reversed().map { $0.date.timeIntervalSince1970})
                                  ))
        }
        return viewModel
    }
}
