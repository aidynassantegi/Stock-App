//
//  StockDetailPresenter.swift
//  Stock-App
//
//  Created by Aidyn Assan on 09.08.2022.
//

import Foundation

final class StockDetailPresenter: StockDetailInteractorOutput, StockDetailViewOutput {
    var interactor: StockDetailInteractorInput?
    weak var view: StockDetailViewInput?
    
    func save(name: String, companyName: String) {
        interactor?.save(name: name, companyName: companyName)
    }
    
    func viewDidAppear(with symbol: String) {
        interactor?.checkIsFavorite(symbol: symbol)
    }
    
    func checkFavorite(_ isFavorite: Bool) {
        view?.setUpNavigationController(isFavorite: isFavorite)
    }
    
}
