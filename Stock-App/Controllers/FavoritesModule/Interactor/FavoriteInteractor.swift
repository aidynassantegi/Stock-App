//
//  FavoriteInteractor.swift
//  Stock-App
//
//  Created by Aidyn Assan on 06.08.2022.
//

import UIKit
import CoreData

protocol FavoriteInteractorOutput: AnyObject {
    func fetchWithFavoritesPresenter(stocks: [TableViewModel])
}

protocol FavoriteInteractorInput: AnyObject {
    func fetchFromCoreData()
	func deleteItem(at index: Int)

}

final class FavoriteInteractor: FavoriteInteractorInput {
    
    weak var output: FavoriteInteractorOutput?
    
    private var requestManager = APIManager()
    private var companiesMap: [CompanyProfile: [CandleStick]] = [:]
	private var viewModel = [TableViewModel]()
    
	var stocksCore = [NSManagedObject]()
	
    required init(requestManager: APIManager){
        self.requestManager = requestManager
    }
    
    private func obtainCandleSticks(with company: CompanyProfile) {
        let group = DispatchGroup()
        
		group.enter()
		requestManager.perform(MarketDataRequest.init(symbol: company.ticker, numberOfDays: 7))
		{ [weak self] (result: Result<MarketDataResponse, Error>) in
			defer {
				group.leave()
			}
			switch result {
			case .success(let data):
				self?.companiesMap[company] = data.candleSticks
			case .failure(let error):
				print(error)
			}
		}
		
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.createViewModels()
        }
    }
    
    private func createViewModels() {
        viewModel = []
        for (company, candleStick) in companiesMap {
            let changePercentage = CalculateStockPriceDynamic.getChangePercentage(for: candleStick)
            viewModel.append(.init(symbol: company.ticker,
                                   companyName: company.name,
                                   price: CalculateStockPriceDynamic.getLatestPrice(from: candleStick),
                                   isFavorite: false,
                                   changeColor: changePercentage < 0 ? .systemRed : .systemGreen,
                                   changePercentage: String.percentage(from: changePercentage),
                                   logo: company.logo,
                                   currency: company.currency,
                                   chartView: .init(data: candleStick.reversed().map{ $0.close}, showLegend: false,
                                                    showAxis: false, fillColor: changePercentage < 0 ? .systemRed : .systemGreen, timeStamp: candleStick.reversed().map { $0.date.timeIntervalSince1970})
                                  ))
        }
        output?.fetchWithFavoritesPresenter(stocks: viewModel)
        
    }
    
    func fetchFromCoreData() {
        companiesMap = [:]
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteStocks")
        
        do {
			stocksCore = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
		var stockSymbols: [CompanyProfile] = []
		stocksCore.forEach { symbol in
            let sym = symbol.value(forKey: "symbol") as! String
			let com = symbol.value(forKey: "companyName") as! String
			stockSymbols.append(CompanyProfile.init(currency: "USD", name: com, ticker: sym, logo: "logo"))
        }
        stockSymbols.forEach{ obtainCandleSticks(with: $0) }
    }
	
	func deleteItem(at index: Int) {
		var deleteObject: NSManagedObject?
		for (i,object) in stocksCore.enumerated() {
			if object.value(forKey: "symbol") as? String == viewModel[index].symbol {
				deleteObject = object
				let _ = stocksCore.dropFirst(i)
				break
			}
		}
		
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
		
		let managedContext = appDelegate.persistentContainer.viewContext
		
		guard let deleteObject = deleteObject else {
			return
		}

		do {
			viewModel.remove(at: index)
			managedContext.delete(deleteObject)
			try managedContext.save()
		} catch let error as NSError {
			print(error.localizedDescription)
		}
		
		companiesMap = [:]
		
	}

}
