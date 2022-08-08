//
//  FavoriteRouter.swift
//  Stock-App
//
//  Created by Aidyn Assan on 06.08.2022.
//

import UIKit

protocol FavoriteRouterInput: AnyObject {
	func openChart(with symbol: String, and companyName: String)
	
	func goToSearchView()
}


final class FavoriteRouter: FavoriteRouterInput {
	
	weak var viewController: UIViewController?
	func openChart(with symbol: String, and companyName: String) {
		let vc = StockDetailsAssembly().assemble(symbol, companyName)
		viewController?.navigationController?.pushViewController(vc, animated: true)
	}
	
	func goToSearchView() {
		let vc = SearchModuleAssemble().assemble()
		viewController?.navigationController?.pushViewController(vc, animated: true)
	}
}
