//
//  StockListRouter.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 27.07.2022.
//

import Foundation
import UIKit

protocol StockListRouterInput {
    func openChart(with index: Int)
}

final class StockListRouter: StockListRouterInput {
    weak var viewController: UIViewController?
    func openChart(with index: Int) {
        print(index)
    }
}
