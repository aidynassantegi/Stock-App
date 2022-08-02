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
    
    required init(requestManager: APIManager){
        self.requestManager = requestManager
    }
    
    func obtainFinancialMetrics(with stockSymbol: String) {
        let group = DispatchGroup()
        
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
        if let metrics = metrics {
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
