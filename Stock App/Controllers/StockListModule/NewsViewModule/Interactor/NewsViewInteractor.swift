//
//  NewsViewInteractor.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 28.07.2022.
//

import Foundation

protocol NewsViewInteractorInput {
    func obtainNewsList(news: NewsType)
}

protocol NewsViewInteractorOutput: AnyObject {
    func didLoadNews(_ news: [News])
}

final class NewsViewInteractor: NewsViewInteractorInput {
    
    weak var newsInteractorOutput: NewsViewInteractorOutput!
    private var apiManager = APIManager()
    
    required init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    func obtainNewsList(news: NewsType) {
        apiManager.perform(MarketNewsRequest(type: news)) { [weak self] (result: Result<[News], Error>) in
            switch result {
            case .success(let data):
                self?.newsInteractorOutput.didLoadNews(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
