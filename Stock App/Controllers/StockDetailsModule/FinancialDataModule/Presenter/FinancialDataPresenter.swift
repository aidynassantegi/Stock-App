//
//  FinancialDataPresenter.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 01.08.2022.
//

import Foundation

final class FinancialDataPresenter: FinancialDataViewOutput, FinancialDataInteractorOutput, FinancialDataModuleInput {
    
    weak var financialDataView: FinancialDataViewInput!
    var financialDataInteractor: FinancailDataInteractorInput!
    
    private var stockSymbol: String!
    private var companyName: String!
    
    func didLoadView() {
        financialDataInteractor.obtainFinancialMetrics(with: stockSymbol)
    }
    
    func didLoadFinancialMetricsModel(_ entity: [MetricCollectionViewEntity]) {
        financialDataView.handleObtainedEntity(entity)
    }
    
    func configure(with stockSymbol: String, and companyName: String) {
        self.stockSymbol = stockSymbol
    }
    
}
