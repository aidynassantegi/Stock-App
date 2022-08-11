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
    func didLoadCandles(_ candles: [CandleStick])
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
            self.chartViewInteractorOutput.didLoadCandles(self.candleStickData)
        }
    }
    
}
