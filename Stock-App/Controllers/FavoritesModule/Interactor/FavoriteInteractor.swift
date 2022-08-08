//
//  FavoriteInteractor.swift
//  Stock-App
//
//  Created by Aidyn Assan on 06.08.2022.
//

import UIKit
import CoreData

protocol FavoriteInteractorOutput: AnyObject {
    func fetchWithFavoritesPresenter(stocks: [TableViewModel])
}

protocol FavoriteInteractorInput: AnyObject {
    func fetchFromCoreData()
}

final class FavoriteInteractor: FavoriteInteractorInput {
    
    weak var output: FavoriteInteractorOutput?
    
    private var requestManager = APIManager()
    private var companiesMap: [CompanyProfile: [CandleStick]] = [:]
    private var viewModel = [TableViewModel]()
    
    required init(requestManager: APIManager){
        self.requestManager = requestManager
    }
    
    private func searchStock(with query: String) {
        viewModel = []
        requestManager.perform(SearchSymbolsRequest(query: query))
        { [weak self] (result: Result<SearchResponse, Error>) in
            switch result {
            case .success(let data):
                let company = data.result.map { searchResult in
                    CompanyProfile.init(currency: "USD", name: searchResult.description,
                                        ticker: searchResult.symbol, logo: "no logo")
                }
                self?.obtainCandleSticks(with: company)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    private func obtainCandleSticks(with companies: [CompanyProfile]) {
        let group = DispatchGroup()
        for company in companies {
            group.enter()
            requestManager.perform(MarketDataRequest.init(symbol: company.ticker, numberOfDays: 7))
            { [weak self] (result: Result<MarketDataResponse, Error>) in
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
        }
    }
    
    private func createViewModels() {
        for (company, candleStick) in companiesMap {
            let changePercentage = CalculateStockDynamic.getChangePercentage(for: candleStick)
            viewModel.append(.init(symbol: company.ticker,
                                   companyName: company.name,
                                   price: CalculateStockDynamic.getLatestPrice(from: candleStick),
                                   isFavorite: false,
                                   changeColor: changePercentage < 0 ? .systemRed : .systemGreen,
                                   changePercentage: String.percentage(from: changePercentage),
                                   logo: company.logo,
                                   currency: company.currency,
                                   chartView: .init(data: candleStick.reversed().map{ $0.close}, showLegend: false,
                                                    showAxis: false, fillColor: changePercentage < 0 ? .systemRed : .systemGreen, timeStamp: candleStick.reversed().map { $0.date.timeIntervalSince1970})
                                  ))
        }
        output?.fetchWithFavoritesPresenter(stocks: viewModel)
        
    }
    
    func fetchFromCoreData() {
        viewModel = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteStocks")
        var lastSearchedStocks = [NSManagedObject]()
        do {
            lastSearchedStocks = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        let stockSymbols = lastSearchedStocks.map { symbol in
            symbol.value(forKey: "symbol") as! String
        }
        stockSymbols.forEach{ searchStock(with: $0) }
//        return stockSymbols
    }
}
