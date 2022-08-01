//
//  FinancialDataAssembly.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 01.08.2022.
//

import Foundation

protocol FinancialDataModuleInput {
    func configure(with stockSymbol: String, and companyName: String)
}

typealias FinancialDataModuleConfiguration = (FinancialDataModuleInput) -> Void

final class FinancialDataAssembly{
    func assemble(_ configuration: FinancialDataModuleConfiguration) -> FinancialCollectionView {
        let view = FinancialCollectionView()
        let dataDisplayManager = FinancialMetricDataManager()
        let presenter = FinancialDataPresenter()
        let requestManager = APIManager()
        let interactor = FinancialDataInteractor(requestManager: requestManager)
        
        configuration(presenter)
        
        view.financialMetricDataManager = dataDisplayManager
        view.financialDataViewOutput = presenter
        presenter.financialDataView = view
        presenter.financialDataInteractor = interactor
        interactor.financialDataInteractorOutput = presenter
        return view
    }
}
