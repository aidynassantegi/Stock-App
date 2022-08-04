//
//  ChartViewPresenter.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 02.08.2022.
//

import Foundation

final class ChartViewPresenter: ChartViewInteractorOutput, ChartViewOutput, ChartViewModuleInput{
   
    weak var chartView: ChartViewInput!
    var chartViewInteractor: ChartViewInteractorInput!
    
    private var stockSymbol: String!
    private var numberOfDays: Double!
    
    func didLoadChartViewModel(_ viewModel: StockChartView.ViewModel) {
        print("chart view  got view model \(viewModel)")
        chartView.handleObtainedChartViewModel(viewModel)
    }
    
    func didLoadView() {
        chartViewInteractor.obtainCandles(with: stockSymbol, numberOfDays: 7)
    }
    
    func configure(with stockSymbol: String) {
        print("chart view \(stockSymbol)")
        self.stockSymbol = stockSymbol
    }
    
    func didSelectTimeCell(with timePeriod: Double) {
        numberOfDays = timePeriod
        chartViewInteractor.obtainCandles(with: stockSymbol, numberOfDays: timePeriod)
    }
    
}
