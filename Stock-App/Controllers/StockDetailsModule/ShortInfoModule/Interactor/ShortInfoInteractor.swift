//
//  ShortInfoInteractor.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 04.08.2022.
//

import Foundation
import UIKit

protocol ShortInfoViewInteractorInput {
    func obtainCandleSticks(with stockSymbol: String, and name: String)
}

protocol ShortInfoViewInteractorOutput: AnyObject {
    func didLoadCandles(_ candles: [CandleStick])
}

final class ShortInfoInteractor: ShortInfoViewInteractorInput {
    
    private var requestManager = APIManager()
    private var symbol: String!
    private var name: String!
    
    weak var shortInforInteractorOutput: ShortInfoViewInteractorOutput!
    
    required init(requestManager: APIManager) {
        self.requestManager = requestManager
    }
    
    func obtainCandleSticks(with stockSymbol: String, and name: String) {
        symbol = stockSymbol
        self.name = name
        requestManager.perform(MarketDataRequest.init(symbol: stockSymbol, numberOfDays: 7)) { [weak self] (result: Result<MarketDataResponse, Error>) in
            switch result {
            case .success(let data):
                self?.shortInforInteractorOutput.didLoadCandles(data.candleSticks)
            case .failure(let error):
                print(error)
            }
        }
    }
}
