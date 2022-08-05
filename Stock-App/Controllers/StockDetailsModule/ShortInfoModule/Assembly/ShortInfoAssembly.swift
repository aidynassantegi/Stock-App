//
//  ShortInfoAssembly.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 04.08.2022.
//

import Foundation

protocol ShortInfoViewModuleInput {
    func configure(with stockSymbol: String, and name: String)
}

typealias ShortInfoModuleConfiguration = (ShortInfoViewModuleInput) -> Void

final class ShortInfoAssembly {
    func assemble(_ configuration: ShortInfoModuleConfiguration) -> ShortInfoViewController {
        let vc = ShortInfoViewController()
        let requestManager = APIManager()
        
        let interactor = ShortInfoInteractor(requestManager: requestManager)
        let presenter = ShortViewPresenter()
        
        presenter.shortInfoView = vc
        presenter.shortInfoInteractor = interactor
        
        configuration(presenter)
        
        vc.shortInfoViewOutput = presenter
        interactor.shortInforInteractorOutput = presenter
        return vc
    }
}
