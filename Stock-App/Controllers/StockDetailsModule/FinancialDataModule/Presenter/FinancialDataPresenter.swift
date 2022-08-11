//
//  FinancialDataPresenter.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 01.08.2022.
//

import Foundation

final class FinancialDataPresenter: FinancialDataViewOutput, FinancialDataInteractorOutput, FinancialDataModuleInput {

    weak var financialDataView: FinancialDataViewInput!
    var financialDataInteractor: FinancailDataInteractorInput!
    
    private var stockSymbol: String!
    private var companyName: String!
    private var metrics: Metrics?
    private var candles: [CandleStick] = []
    
    func didLoadView() {
        financialDataInteractor.obtainFinancialMetrics(with: stockSymbol)
    }
    
    func didLoadFinancialMetrics(_ metrics: Metrics, _ candles: [CandleStick]) {
        self.metrics = metrics
        self.candles = candles
        let viewModel = createViewModel()
        financialDataView.handleObtainedEntity(viewModel)
    }
    
    func configure(with stockSymbol: String, and companyName: String) {
        self.stockSymbol = stockSymbol
    }
    
    private func createViewModel() -> [MetricCollectionViewModel] {
        var viewModel = [MetricCollectionViewModel]()
        if let metrics = metrics{
            
            if candles[0].open != nil {
                viewModel.append(.init(name: "Open", value: "\(candles[0].open)"))
            } else {
                viewModel.append(.init(name: "Open", value: "-"))
            }
            
            if candles[0].high != nil {
                viewModel.append(.init(name: "High", value: "\(candles[0].high)"))
            } else {
                viewModel.append(.init(name: "High", value: "-"))
            }
            
            if candles[0].low != nil {
                viewModel.append(.init(name: "Low", value: "\(candles[0].low)"))
            }else {
                viewModel.append(.init(name: "Low", value: "-"))
            }
            
            if let annualWeekHigh = metrics.AnnualWeekHigh {
                viewModel.append(.init(name: "52W High", value: "\(annualWeekHigh)"))
            } else {
                viewModel.append(.init(name: "52W High", value: "-"))
            }
            
            if  let annualWeekLow = metrics.AnnualWeekLow {
                viewModel.append(.init(name: "52W Low", value: "\(annualWeekLow)"))
            } else {
                viewModel.append(.init(name: "52W High", value: "-"))
            }
            
            if let annualWeekLowDate = metrics.AnnualWeekLowDate {
                viewModel.append(.init(name: "52W Low Date", value: "\(annualWeekLowDate)"))
            } else {
                viewModel.append(.init(name: "52W Low Date", value: "-"))
            }
            
            if let annualWeekPriceReturnDaily = metrics.AnnualWeekPriceReturnDaily {
                viewModel.append(.init(name: "52W Return", value: "\(annualWeekPriceReturnDaily)"))
            }else {
                viewModel.append(.init(name: "52W Return", value: "-"))
            }
            
            if let beta = metrics.beta {
                viewModel.append(.init(name: "Beta", value: "\(beta)"))
            }else {
                viewModel.append(.init(name: "Beta", value: "-"))
            }
            
            if let tenDayAverageTradingVolume = metrics.TenDayAverageTradingVolume {
                viewModel.append(.init(name: "Avg Vol", value: "\(tenDayAverageTradingVolume)"))
            }else {
                viewModel.append(.init(name: "Avg Vol", value: "-"))
            }
        }
        return viewModel
    }
    
}
