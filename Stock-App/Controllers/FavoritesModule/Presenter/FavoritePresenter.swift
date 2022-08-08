//
//  FavoritePresenter.swift
//  Stock-App
//
//  Created by Aidyn Assan on 06.08.2022.
//

import Foundation

final class FavoritePresenter: FavoriteViewOutput,  FavoriteInteractorOutput {
    
    var interactor: FavoriteInteractorInput?
    weak var view: FavoriteViewInput?
    
    func viewDidAppear() {
        interactor?.fetchFromCoreData()
    }
    
    func fetchWithFavoritesPresenter(stocks: [TableViewModel]) {
        view?.setWithStocksTable(stocks: stocks)
    }
    
    
}
