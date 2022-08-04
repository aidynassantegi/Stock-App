//
//  ChartViewInteractor.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 02.08.2022.
//

import Foundation

protocol ChartViewInteractorInput {
    func obtainCandles(with stockSymbol: String, numberOfDays: TimeInterval)
}

protocol ChartViewInteractorOutput: AnyObject{
    func didLoadChartViewModel(_ viewModel: StockChartView.ViewModel)
}

final class ChartViewInteractor: ChartViewInteractorInput {
    weak var chartViewInteractorOutput: ChartViewInteractorOutput!
    var requestManager = APIManager()
    
    private var candleStickData: [CandleStick] = []
    
    required init(requestManager: APIManager) {
        self.requestManager = requestManager
    }
    
    func obtainCandles(with stockSymbol: String, numberOfDays: TimeInterval) {
        let group = DispatchGroup()
        var resolution: String!
        group.enter()
        
        requestManager.perform(MarketDataRequest.init(symbol: stockSymbol, numberOfDays: numberOfDays)) { [weak self] (result: Result<MarketDataResponse, Error>) in
            defer {
                group.leave()
            }
            
            switch result {
                case .success(let data):
                print(data.candleSticks)
                    self?.candleStickData = data.candleSticks
                case .failure(let error):
                    print(error)
            }
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.createViewModel()
        }
    }
    
    private func createViewModel() {
        let change = CalculateStockDynamic.getChangePercentage(for: candleStickData)
        print("last element \(candleStickData[candleStickData.count - 1].date)")
        var viewModel: StockChartView.ViewModel = StockChartView.ViewModel(data: candleStickData.reversed().map{ $0.close},
                                                                           showLegend: true,
                                                                           showAxis: true,
                                                                           fillColor: change < 0 ? .systemRed : .systemGreen,
                                                                           timeStamp: candleStickData.reversed().map { $0.date.timeIntervalSince1970})
        chartViewInteractorOutput.didLoadChartViewModel(viewModel)
    }
}
