//
//  StockListRouter.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 27.07.2022.
//

import Foundation
import UIKit

protocol StockListRouterInput {
    func openChart(with symbol: String, and companyName: String)
}

final class StockListRouter: StockListRouterInput {
    weak var viewController: UIViewController?
    func openChart(with symbol: String, and companyName: String) {
        let vc = StockDetailsViewController()
        vc.symbol = symbol
        vc.companyName = companyName
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
