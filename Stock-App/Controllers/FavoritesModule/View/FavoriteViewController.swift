//
//  FavoritesVC.swift
//  Stock App
//
//  Created by Aidyn Assan on 19.07.2022.
//

import UIKit

protocol FavoriteViewInput: AnyObject {
    
}


protocol FavoriteViewOutput: AnyObject {
    
}

class FavoriteViewController: UIViewController, FavoriteViewInput {
    
    var output: FavoriteViewOutput?
    
    var favoriteManager: FavoriteManager!
    
    var favoriteStocks: [TableViewModel] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(StockTableViewCell.self,
                           forCellReuseIdentifier: StockTableViewCell.reuseId)
        return tableView
    }()
    
    
    
    func setSearcResults(with stocks: [TableViewModel]) {
        favoriteStocks = stocks
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
    }
    
    
    private func setupTableView() {
        favoriteManager.setCellWithStock = { [weak self] index in
            self?.favoriteStocks[index]
        }
        favoriteManager.searchResultCount = { [ weak self ] in
            self?.favoriteStocks.count ?? 0
        }
//        favoriteManager.didSelectStock = { [weak self] index in
//            guard let symbol = self?.favoriteStocks[index].symbol else { return }
//            guard let companyName = self?.favoriteStocks[index].companyName else { return }
//            self?.output?.showDetails(of: symbol, and: companyName)
//        }
        tableView.delegate = favoriteManager
        tableView.dataSource = favoriteManager
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    
    
}
