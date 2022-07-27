//
//  StockListInteractor.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 27.07.2022.
//

import Foundation

protocol StockListInteractorInput {
    func obtainStockSymbols()
    func obtainCompanyProfiles(with stockSymbols: String)
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
        requestManager.perform(SymbolsRequest.init()) { [weak self] (result: Result<[StockSymbols], Error>) in
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
    
    func obtainCompanyProfiles(with stockSymbols: String) {
        
    }
    
//    func obtainCompanyProfiles(with stockSymbol: String) {
//        Task {
//            for index in stockSymbols {
//                await fetchCompanies(with: index)
//                companies.append(companyProfile)
//            }
//        }
//        output.didLoadCompanyProfiles(companies)
//    }
    


    
}
