//
//  FavoriteAssemble.swift
//  Stock-App
//
//  Created by Aidyn Assan on 06.08.2022.
//

import Foundation

final class FavoriteAssemble {
    func assemble() -> FavoriteViewController {
        let apiManager = APIManager()
        let view = FavoriteViewController()
        let presenter = FavoritePresenter()
        let interactor = FavoriteInteractor(requestManager: apiManager)
		let router = FavoriteRouter()
		
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
		presenter.router = router
		interactor.output = presenter
        
        let tableManager = FavoriteManager()
        view.favoriteManager = tableManager
		
		router.viewController = view
		
        return view
    }
}
