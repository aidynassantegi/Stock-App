//
//  SearchInteractor.swift
//  Stock-App
//
//  Created by Aidyn Assan on 01.08.2022.
//

import UIKit
import CoreData

protocol SearchInteractorInput: AnyObject {
    func searchStock(with query: String)
}

final class SearchInteractor: SearchInteractorInput {
    
    weak var output: SearchInteractorOutput?
    
    private var requestManager = APIManager()
    private var companies: [CompanyProfile] = []
    private var stockSymbols: [StockSymbols] = []
    
    private var companiesMap: [CompanyProfile: [CandleStick]] = [:]
    var viewModel = [TableViewModel]()
    
    func searchStock(with query: String) {
        
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
        save(name: query)
    }

    private func save(name: String) {
        let searched = fetchFromCoreData()
        guard !searched.contains(name) else { return }
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        
        let entity =
        NSEntityDescription.entity(forEntityName: "LastSearchedStocks",
                                   in: managedContext)!
        
        let searches = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        searches.setValue(name, forKeyPath: "symbol")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private func fetchFromCoreData() -> [String] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LastSearchedStocks")
        var lastSearchedStocks = [NSManagedObject]()
        do {
            lastSearchedStocks = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        let stockSymbols = lastSearchedStocks.map { symbol in
            symbol.value(forKey: "symbol") as! String
        }
        return stockSymbols
    }
    
    
    
    required init(requestManager: APIManager){
        self.requestManager = requestManager
    }
    
    func obtainCandleSticks(with companies: [CompanyProfile]) {
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
            //Out
        }
    }
    
    func createViewModels() {
        viewModel = []
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
                                   chartView: .init(data: candleStick.reversed().map{ $0.close}, showLegend: false,
                                                    showAxis: false, fillColor: changePercentage < 0 ? .systemRed : .systemGreen, timeStamp: candleStick.reversed().map { $0.date.timeIntervalSince1970})
                                  ))
        }
        output?.setSearchResults(with: viewModel)
    }
    
}
