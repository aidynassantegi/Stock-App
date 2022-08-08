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
	var router: FavoriteRouterInput?
    
    func viewDidAppear() {
        interactor?.fetchFromCoreData()
    }
    
    func fetchWithFavoritesPresenter(stocks: [TableViewModel]) {
        view?.setWithStocksTable(stocks: stocks)
    }
    
	func showDetails(of symbol: String, and companyName: String) {
		router?.openChart(with: symbol, and: companyName)
	}
	
	func deleteItem(at index: Int) {
		interactor?.deleteItem(at: index)
	}
	
	func goToSearchView() {
		router?.goToSearchView()
	}
}
