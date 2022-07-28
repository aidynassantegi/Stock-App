//
//  StockListInteractor.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 27.07.2022.
//

import Foundation
import UIKit

struct TableViewModel {
    let symbol: String
    let companyName: String
    let price: String
    let isFavorite: Bool
    let changeColor: UIColor // red or green
    let changePercentage: String
    let logo: String
    let currency: String
}

protocol StockListInteractorInput {
    func obtainStockSymbols() 
    func obtainCompanyProfiles(with stockSymbol: [StockSymbols])
    func obtainCandleSticks(with companies: [CompanyProfile])
}

protocol StockListInteractorOutput: AnyObject {
    func didLoadStockSymbols(_ symbols: [StockSymbols])
    func didLoadCompanyProfiles(_ companies: [CompanyProfile])
    func didLoadCandleSticks(_ tableViewModel: [TableViewModel])
}

final class StockListInteractor: StockListInteractorInput {
    
    weak var output: StockListInteractorOutput!
    private var requestManager = APIManager()
    private var companies: [CompanyProfile] = []
    private var stockSymbols: [StockSymbols] = []
    
    private var companiesMap: [CompanyProfile: [CandleStick]] = [:]
    var viewModel = [TableViewModel]()
    
    required init(requestManager: APIManager){
        self.requestManager = requestManager
    }
    
    func obtainCandleSticks(with companies: [CompanyProfile]) {
        let group = DispatchGroup()
        for company in companies {
            group.enter()
            requestManager.perform(MarketDataRequest.init(symbol: company.ticker, numberOfDays: 7)) { [weak self] (result: Result<MarketDataResponse, Error>) in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let data):
                    self?.companiesMap[company] = data.candleSticks
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.createViewModels()
            self.output.didLoadCandleSticks(self.viewModel)
        }
    }
    
    func temp () {}
    
    func createViewModels() {
        for (company, candleStick) in companiesMap {
            let changePercentage = CalculateStockDynamic.getChangePercentage(for: candleStick)
            viewModel.append(.init(symbol: company.ticker,
                                   companyName: company.name,
                                   price: CalculateStockDynamic.getLatestPrice(from: candleStick),
                                   isFavorite: false,
                                   changeColor: changePercentage < 0 ? .systemRed : .systemGreen,
                                   changePercentage: String.percentage(from: changePercentage),
                                   logo: company.logo,
                                   currency: company.currency
                                  ))
        }
    }
    
    func obtainStockSymbols() {
            self.requestManager.perform(SymbolsRequest.init()) { [weak self] (result: Result<[StockSymbols], Error>) in
                switch result {
                case .success(let data):
                    for index in 0...50 {
                        self?.stockSymbols.append(data[index])
                    }
                    self?.output.didLoadStockSymbols(self!.stockSymbols)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func obtainCompanyProfiles(with stockSymbol: [StockSymbols]) {
        let group = DispatchGroup()
        for symbol in stockSymbol {
            group.enter()
            requestManager.perform(CompanyProfileRequest.init(symbol: symbol.symbol)) { [weak self] (result: Result<CompanyProfile, Error>) in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let data):
                    self?.companies.append(data)
                case .failure(let error):
                    print(error)
                }
            }
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.output.didLoadCompanyProfiles(self.companies)
        }
    }
    
}
