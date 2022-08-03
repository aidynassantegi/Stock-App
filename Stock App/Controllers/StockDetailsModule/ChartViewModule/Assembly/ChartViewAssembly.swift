//
//  ChartViewAssembly.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 02.08.2022.
//

import Foundation

protocol ChartViewModuleInput {
    func configure(with stockSymbol: String)
}

typealias ChartViewModuleConfiguration = (ChartViewModuleInput) -> Void

final class ChartViewAssembly {
    func assemble(_ configuration: ChartViewModuleConfiguration) -> ChartViewController {
        let vc = ChartViewController()
        let dataManager = TimeIntervalCollectionViewDataManager()
        vc.timePeriodCollectionDataManager = dataManager
        
        let presenter = ChartViewPresenter()
        
        configuration(presenter)
        
        let requestManager = APIManager()
        let interactor = ChartViewInteractor(requestManager: requestManager)
        
        vc.chartViewOutput = presenter
        presenter.chartView = vc
        presenter.chartViewInteractor = interactor
        interactor.chartViewInteractorOutput = presenter
        
        return vc
    }
}
