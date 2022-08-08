//
//  LastSearchPresenter.swift
//  Stock-App
//
//  Created by Aidyn Assan on 04.08.2022.
//

import Foundation


protocol LastSearchOutput: AnyObject {
    func fetch(with symbols: [String])
}

final class LastSearchPresenter: LastSearchedViewOutput, LastSearchOutput {
    var interactor: LastSearchInput?
    weak var view: LastSearchedViewInput?
    
    func fetch(with symbols: [String]) {
        view?.set(with: symbols)
    }
    
    func viewWillAppear() {
        interactor?.getStockSymbols()
    }
}
