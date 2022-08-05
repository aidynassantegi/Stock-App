//
//  NewsViewPresenter.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 28.07.2022.
//

import Foundation

final class NewsViewPresenter: NewsViewOutput, NewsViewInteractorOutput {
    
    weak var newsView: NewsViewInput!
    var newInteractor: NewsViewInteractorInput!
    var newRouter: NewsViewRouterInput!
    var news = NewsType.topNews
    
    func didLoadNews(_ news: [News]) {
        newsView.handleObtainedNews(news)
    }
    
    func didLoadView() {
        newInteractor.obtainNewsList(news: news)
    }
    
    func didSelectNew(with url: URL) {
        newRouter.openNews(with: url)
    }

}
