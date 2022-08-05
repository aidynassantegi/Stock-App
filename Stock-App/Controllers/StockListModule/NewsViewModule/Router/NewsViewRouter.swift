//
//  NewsViewRouter.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 28.07.2022.
//

import Foundation
import SafariServices

protocol NewsViewRouterInput {
    func openNews(with url: URL)
}

final class NewsViewRouter: NewsViewRouterInput {
    weak var viewController: UIViewController?
    
    func openNews(with url: URL) {
        let vc = SFSafariViewController(url: url)
        viewController?.present(vc, animated: true)
    }
}
