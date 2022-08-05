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
    
    func didLoadEntity(_ entity: ShortInfoEntity) {
        shortInfoView.handleObtainedEntity(entity)
    }
    
    func didLoadView() {
        shortInfoInteractor.obtainCandleSticks(with: stockSymbol, and: name)
    }
    
    func configure(with stockSymbol: String, and name: String) {
        self.stockSymbol = stockSymbol
        self.name = name
    }
    
}
