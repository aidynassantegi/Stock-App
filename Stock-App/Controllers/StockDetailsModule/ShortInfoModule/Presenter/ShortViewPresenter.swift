//
//  ShortViewPresenter.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 04.08.2022.
//

import Foundation

final class ShortViewPresenter: ShortInfoViewInteractorOutput, ShortInfoViewOutput, ShortInfoViewModuleInput {
    weak var shortInfoView: ShortInfoViewInput!
    var shortInfoInteractor: ShortInfoViewInteractorInput!
    
    private var stockSymbol: String!
    private var name: String!
    
    func didLoadCandles(_ candles: [CandleStick]) {
        let viewModel = createViewModel(candles, stockSymbol, name)
        shortInfoView.handleObtainedEntity(viewModel)
    }
    
    func didLoadView() {
        shortInfoInteractor.obtainCandleSticks(with: stockSymbol, and: name)
    }
    
    func configure(with stockSymbol: String, and name: String) {
        self.stockSymbol = stockSymbol
        self.name = name
    }
    
    private func createViewModel(_ candles: [CandleStick], _ symbol: String, _ name: String) -> ShortInfoEntity{
        let changePercentage = CalculateStockPriceDynamic.getChangePercentage(for: candles)
        let entity = ShortInfoEntity(symbol: symbol, name: name, price: CalculateStockPriceDynamic.getLatestPrice(from: candles), changePercentage: String.percentage(from: changePercentage), color: changePercentage < 0 ? .systemRed : .systemGreen)
        return entity
    }
    
}
