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
    //func didLoadFinancialMetrics(_ metrics: Metrics)
    func didLoadFinancialMetricsModel(_ entity: [MetricCollectionViewEntity])
}

final class FinancialDataInteractor: FinancailDataInteractorInput {
    
    weak var financialDataInteractorOutput: FinancialDataInteractorOutput!
    private var requestManager = APIManager()
    private var metrics: Metrics?
    private var entity = [MetricCollectionViewEntity]()
    private var candles: [CandleStick] = []
    
    required init(requestManager: APIManager){
        self.requestManager = requestManager
    }
    
    func obtainFinancialMetrics(with stockSymbol: String) {
        let group = DispatchGroup()
        
        if candles.isEmpty {
            group.enter()
            requestManager.perform(MarketDataRequest(symbol: stockSymbol, numberOfDays: 1)) { [weak self] (result: Result<MarketDataResponse, Error>) in
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
            self.createEntity()
//            self.financialDataInteractorOutput.didLoadFinancialMetricsModel(self.entity)
        }
    }
    
    private func createEntity() {
        if let metrics = metrics{
            
            if candles[0].open != nil {
                entity.append(.init(name: "Open", value: "\(candles[0].open)"))
            } else {
                entity.append(.init(name: "Open", value: "-"))
            }
            
            if candles[0].high != nil {
                entity.append(.init(name: "High", value: "\(candles[0].high)"))
            } else {
                entity.append(.init(name: "High", value: "-"))
            }
                              
            if candles[0].low != nil {
                entity.append(.init(name: "Low", value: "\(candles[0].low)"))
            }else {
                entity.append(.init(name: "Low", value: "-"))
            }
            
            if let annualWeekHigh = metrics.AnnualWeekHigh {
                entity.append(.init(name: "52W High", value: "\(annualWeekHigh)"))
            } else {
                entity.append(.init(name: "52W High", value: "-"))
            }
    
            if  let annualWeekLow = metrics.AnnualWeekLow {
                entity.append(.init(name: "52W Low", value: "\(annualWeekLow)"))
            } else {
                entity.append(.init(name: "52W High", value: "-"))
            }
            
            if let annualWeekLowDate = metrics.AnnualWeekLowDate {
                entity.append(.init(name: "52W Low Date", value: "\(annualWeekLowDate)"))
            } else {
                entity.append(.init(name: "52W Low Date", value: "-"))
            }
            
            if let annualWeekPriceReturnDaily = metrics.AnnualWeekPriceReturnDaily {
                entity.append(.init(name: "52W Return", value: "\(annualWeekPriceReturnDaily)"))
            }else {
                entity.append(.init(name: "52W Return", value: "-"))
            }
            
            if let beta = metrics.beta {
                entity.append(.init(name: "Beta", value: "\(beta)"))
            }else {
                entity.append(.init(name: "Beta", value: "-"))
            }
            
            if let tenDayAverageTradingVolume = metrics.TenDayAverageTradingVolume {
                entity.append(.init(name: "Avg Vol", value: "\(tenDayAverageTradingVolume)"))
            }else {
                entity.append(.init(name: "Avg Vol", value: "-"))
            }
            
            self.financialDataInteractorOutput.didLoadFinancialMetricsModel(self.entity)
        }
    }
    
}
