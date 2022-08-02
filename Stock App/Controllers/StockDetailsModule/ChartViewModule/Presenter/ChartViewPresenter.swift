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
    
    func handleObtainedChartViewModel(_ viewModel: StockChartView.ViewModel) {
        chartView.handleObtainedChartViewModel(viewModel)
    }
    
    func didLoadView() {
        chartViewInteractor.obtainCandles(with: stockSymbol)
    }
    
    func configure(with stockSymbol: String) {
        self.stockSymbol = stockSymbol
    }
}
