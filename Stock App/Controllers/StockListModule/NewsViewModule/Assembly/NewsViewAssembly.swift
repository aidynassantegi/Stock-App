//
//  NewsViewAssembly.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 28.07.2022.
//

import Foundation
import UIKit
import SafariServices

final class NewsViewAssembly {
    func assembly() -> NewsViewController {
        let vc = NewsViewController(type: .topNews)
        let newsTableDataManager = NewsTableDataManager()
        let apiManager = APIManager()
        let router = NewsViewRouter()
        let interactor = NewsViewInteractor(apiManager: apiManager)
        let presenter = NewsViewPresenter()
        
        vc.newsTableDataManager = newsTableDataManager
        vc.output = presenter
        presenter.newsView = vc
        presenter.newInteractor = interactor
        presenter.newRouter = router
        
        interactor.newsInteractorOutput = presenter
        router.viewController = vc
        return vc
    }
}
