//
//  SearchPresenter.swift
//  Stock-App
//
//  Created by Aidyn Assan on 01.08.2022.
//

import Foundation

protocol SearchViewOutput: AnyObject {
    func searchFor(query: String)
    func showDetails(of stock: String, and companyName: String)
    func searchedStocks() -> LastSearchedViewController?
}

protocol SearchInteractorOutput: AnyObject {
    func setSearchResults(with stocks: [TableViewModel])
}

final class SearchPresenter: SearchViewOutput, SearchInteractorOutput, SearchRouterOutput {
    // MARK: - Interactor
    var interactor: SearchInteractorInput?
    func searchFor(query: String) {
        interactor?.searchStock(with: query)
    }
    
    weak var view: SearchViewInput?
    func setSearchResults(with stocks: [TableViewModel]) {
        view?.setSearcResults(with: stocks)
    }
    
    // MARK: - View
    
    // Search results
    
    var router: SearchRouterInput?
    weak var searchedColection: LastSearchedViewController?
    
    func searchedStocks() -> LastSearchedViewController? {
        return LastSearchAssembler().assemble()
    }
    func searchedStocks(vc: LastSearchedViewController) {
        searchedColection = vc
    }
    
    func showDetails(of stock: String, and companyName: String) {
        router?.openChart(with: stock, and: companyName)
    }
}

