//
//  StockDetailInteractor.swift
//  Stock-App
//
//  Created by Aidyn Assan on 09.08.2022.
//

import UIKit
import CoreData

protocol StockDetailInteractorInput: AnyObject  {
    func save(name: String, companyName: String)
    func checkIsFavorite(symbol: String)
    func delete(name: String, companyName: String)
}

protocol StockDetailInteractorOutput: AnyObject {
    func checkFavorite(_ isFavorite: Bool)
}

final class StockDetailInteractor: StockDetailInteractorInput {
    
    
    
    weak var output: StockDetailInteractorOutput?
    
    func save(name: String, companyName: String) {
        let searched = fetchFromCoreData()
        guard !searched.contains(name) else { return }
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        
        let entity =
        NSEntityDescription.entity(forEntityName: "FavoriteStocks",
                                   in: managedContext)!
        
        let searches = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        searches.setValue(name, forKeyPath: "symbol")
        searches.setValue(companyName, forKey: "companyName")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    func delete(name: String, companyName: String) {
        guard let data = fetchObjects() else { return }
        var deleteObject: NSManagedObject?
        for object in data {
            if object.value(forKey: "symbol") as? String == name {
                deleteObject = object
            }
        }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let deleteObject = deleteObject else { return }
        
        do {
            managedContext.delete(deleteObject)
            try managedContext.save()
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func fetchFromCoreData() -> [String] {
        guard let lastSearchedStocks = fetchObjects() else { return [] }
        let stockSymbols = lastSearchedStocks.map { symbol in
            symbol.value(forKey: "symbol") as! String
        }
        return stockSymbols
    }
    
    private func fetchObjects() -> [NSManagedObject]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteStocks")
        var lastSearchedStocks = [NSManagedObject]()
        do {
            lastSearchedStocks = try managedContext.fetch(fetchRequest)
            return lastSearchedStocks
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func checkIsFavorite(symbol: String) {
        output?.checkFavorite(fetchFromCoreData().contains(symbol))
    }
}
