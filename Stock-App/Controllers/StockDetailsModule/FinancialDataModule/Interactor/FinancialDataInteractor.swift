//
//  FinancialDataInteractor.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 01.08.2022.
//

import Foundation

protocol FinancailDataInteractorInput {
    func obtainFinancialMetrics(with stockSymbol: String)
}

protocol FinancialDataInteractorOutput: AnyObject {
    func didLoadFinancialMetrics(_ metrics: Metrics, _ candles: [CandleStick])
}

final class FinancialDataInteractor: FinancailDataInteractorInput {
    
    weak var financialDataInteractorOutput: FinancialDataInteractorOutput!
    private var requestManager = APIManager()
    private var metrics: Metrics!
    private var candles: [CandleStick] = []
    
    required init(requestManager: APIManager){
        self.requestManager = requestManager
    }
    
    func obtainFinancialMetrics(with stockSymbol: String) {
        let group = DispatchGroup()
        
        if candles.isEmpty {
            group.enter()
            requestManager.perform(MarketDataRequest(symbol: stockSymbol, numberOfDays: 7)) { [weak self] (result: Result<MarketDataResponse, Error>) in
                defer {
                    group.leave()
                }
                
                switch result {
                case .success(let data):
                    self?.candles = data.candleSticks
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        group.enter()
        requestManager.perform(FinancialMetricsRequest(symbol: stockSymbol)) { [weak self] (result: Result<FinancialMetrics, Error>) in
            defer {
                group.leave()
            }
            switch result {
            case .success(let data):
                self?.metrics = data.metric
            case .failure(let error):
                print("error \(error)")
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.financialDataInteractorOutput.didLoadFinancialMetrics(self.metrics, self.candles)
        }
    }
    
}
