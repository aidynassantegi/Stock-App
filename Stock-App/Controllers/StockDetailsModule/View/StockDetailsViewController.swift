//
//  StockDetailsViewController.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 29.07.2022.
//

import UIKit
import FloatingPanel
import CoreData

class StockDetailsViewController: UIViewController, FloatingPanelControllerDelegate {
    var symbol: String!
    var companyName: String!
    
    var shortInfoView: ShortInfoViewController?
    var shortInfoViewPlaceholder = UIView()
    
    var collectionView: FinancialCollectionViewController?
    var collectionViewPlaceholder = UIView()

    var chartView: ChartViewController?
    var chartViewPlaceholder = UIView()
    
    var newsController: NewsViewController?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableHeaderView.self, forHeaderFooterViewReuseIdentifier: NewsTableHeaderView.identifier)
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController()
        view.backgroundColor = .systemBackground
        
        setViews()
        
        setUpFloatingPanel()
    }
    
    private func setUpNavigationController() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(saveTapped))
    }
    
    @objc func saveTapped() {
        save(name: symbol)
    }
    
    
    private func save(name: String) {
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
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private func fetchFromCoreData() -> [String] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteStocks")
        var lastSearchedStocks = [NSManagedObject]()
        do {
            lastSearchedStocks = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        let stockSymbols = lastSearchedStocks.map { symbol in
            symbol.value(forKey: "symbol") as! String
        }
        return stockSymbols
    }
    
    
    private func setViews() {
        guard let shortInfoView = shortInfoView else { return }
        guard let collectionView = collectionView else { return }
        guard let chartView = chartView else { return }
        
        add(childVC: shortInfoView, to: shortInfoViewPlaceholder)
        add(childVC: collectionView, to: collectionViewPlaceholder)
        add(childVC: chartView, to: chartViewPlaceholder)
        
        chartViewPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        collectionViewPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        shortInfoViewPlaceholder.translatesAutoresizingMaskIntoConstraints = false
       
        view.addSubviews(shortInfoViewPlaceholder, chartViewPlaceholder, collectionViewPlaceholder)
        NSLayoutConstraint.activate([shortInfoViewPlaceholder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -50),
                                     shortInfoViewPlaceholder.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                                     shortInfoViewPlaceholder.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     shortInfoViewPlaceholder.heightAnchor.constraint(equalToConstant: 50),
                                     
                                     chartViewPlaceholder.topAnchor.constraint(equalTo: shortInfoViewPlaceholder.bottomAnchor, constant: 10),
                                     chartViewPlaceholder.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                                     chartViewPlaceholder.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     chartViewPlaceholder.heightAnchor.constraint(equalToConstant: 250),
                                     
                                     collectionViewPlaceholder.topAnchor.constraint(equalTo: chartViewPlaceholder.bottomAnchor, constant: 20),
                                     collectionViewPlaceholder.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     collectionViewPlaceholder.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     collectionViewPlaceholder.heightAnchor.constraint(equalToConstant: (view.height * 0.45))])
    }
    
    private func setUpFloatingPanel() {
        guard let vc = newsController else { return }
        
        let panel = FloatingPanelController(delegate: self)
        panel.surfaceView.backgroundColor = .secondarySystemBackground
        panel.set(contentViewController: vc)
        panel.addPanel(toParent: self)
        panel.track(scrollView: vc.newsTableView)
    }
    
}
    
