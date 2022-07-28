//
//  StockListInteractor.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 27.07.2022.
//

import Foundation

protocol StockListInteractorInput {
    func obtainStockSymbols() 
    func obtainCompanyProfiles(with stockSymbol: [StockSymbols])
}

protocol StockListInteractorOutput: AnyObject {
    func didLoadStockSymbols(_ symbols: [StockSymbols])
    func didLoadCompanyProfiles(_ companies: [CompanyProfile])
}

final class StockListInteractor: StockListInteractorInput {
    
    weak var output: StockListInteractorOutput!
    private var requestManager = APIManager()
    
    private var companyProfile: CompanyProfile!
    
    private var companies: [CompanyProfile] = []
    private var stockSymbols: [StockSymbols] = []
    
    required init(requestManager: APIManager){
        self.requestManager = requestManager
    }
    
    func obtainStockSymbols() {
        let group = DispatchGroup()
        var tempSymbols: [StockSymbols] = []
            self.requestManager.perform(SymbolsRequest.init()) { [weak self] (result: Result<[StockSymbols], Error>) in
                switch result {
                case .success(let data):
                    for index in 0...50 {
                        self?.stockSymbols.append(data[index])
                    }
                    self?.output.didLoadStockSymbols(self!.stockSymbols)
                    //return self!.stockSymbols
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
            print("companies \(self.companies)")
            self.output.didLoadCompanyProfiles(self.companies)
        }
        print(self.companies)
    }
    
}
