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
        
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.output = presenter
        
        var tableManager = FavoriteManager()
        view.favoriteManager = tableManager
        
        return view
    }
}
