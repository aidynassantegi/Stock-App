//
//  StockListModuleAssembly.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 27.07.2022.
//

import Foundation
import UIKit

final class StockListModuleAssembly {
    func assembly() -> StockViewController {
        let vc = StockViewController()
        let tableDataManager = TableViewDataManager()
        let presenter = StockListPresenter()
        let network = APIManager()
        let interactor = StockListInteractor(requestManager: network)
        let router = StockListRouter()
        
        vc.tableDataManager = tableDataManager
        vc.output = presenter
        
        presenter.view = vc
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        router.viewController = vc
        return vc
    }
}
