//
//  LastSearchInteractor.swift
//  Stock-App
//
//  Created by Aidyn Assan on 04.08.2022.
//

import Foundation
import CoreData
import UIKit

protocol LastSearchInput: AnyObject {
    func getStockSymbols()
}

final class LastSeachInteractor: LastSearchInput {
    weak var output: LastSearchOutput?
    
    private var lastSearchedStocks: [NSManagedObject] = []
    
    private func fetchFromCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LastSearchedStocks")
        
        do {
            lastSearchedStocks = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getStockSymbols() {
        fetchFromCoreData()
        let stockSymbols = lastSearchedStocks.map { symbol in
            symbol.value(forKey: "symbol") as! String
        }
        output?.fetch(with: stockSymbols)
    }
}
