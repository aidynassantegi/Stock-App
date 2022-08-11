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
    
    func didLoadCandles(_ candles: [CandleStick]) {
        let viewModel = createViewModel(candles)
        chartView.handleObtainedChartViewModel(viewModel)
    }
    
    func didLoadView() {
        chartViewInteractor.obtainCandles(with: stockSymbol, numberOfDays: 7)
    }
    
    func configure(with stockSymbol: String) {
        self.stockSymbol = stockSymbol
    }
    
    func didSelectTimeCell(with timePeriod: Double) {
        numberOfDays = timePeriod
        chartViewInteractor.obtainCandles(with: stockSymbol, numberOfDays: timePeriod)
    }
    
    private func createViewModel(_ candles: [CandleStick]) -> StockChartView.ViewModel {
        let change = CalculateStockPriceDynamic.getChangePercentage(for: candles)
        let viewModel: StockChartView.ViewModel = StockChartView.ViewModel(data: candles.reversed().map{ $0.close},
                                                                           showLegend: true,
                                                                           showAxis: true,
                                                                           fillColor: change < 0 ? .systemRed : .systemGreen,
                                                                           timeStamp: candles.reversed().map { $0.date.timeIntervalSince1970})
      return viewModel
    }
    
}
