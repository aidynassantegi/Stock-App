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
    func didLoadEntity(_ entity: ShortInfoEntity)
}

final class ShortInfoInteractor: ShortInfoViewInteractorInput {
    
    private var requestManager = APIManager()
    private var candles: [CandleStick] = []
    private var symbol: String!
    private var name: String!
    
    weak var shortInforInteractorOutput: ShortInfoViewInteractorOutput!
    
    required init(requestManager: APIManager) {
        self.requestManager = requestManager
    }
    
    func obtainCandleSticks(with stockSymbol: String, and name: String) {
        let group = DispatchGroup()
        symbol = stockSymbol
        self.name = name
        
        group.enter()
        requestManager.perform(MarketDataRequest.init(symbol: stockSymbol, numberOfDays: 1)) { [weak self] (result: Result<MarketDataResponse, Error>) in
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
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.createEntity()
        }
    }
    
    private func createEntity() {
        let changePercentage = CalculateStockDynamic.getChangePercentage(for: candles)
        let entity = ShortInfoEntity(symbol: symbol, name: name, price: CalculateStockDynamic.getLatestPrice(from: candles), changePercentage: String.percentage(from: changePercentage), color: changePercentage < 0 ? .systemRed : .systemGreen)
        shortInforInteractorOutput.didLoadEntity(entity)
    }

}
