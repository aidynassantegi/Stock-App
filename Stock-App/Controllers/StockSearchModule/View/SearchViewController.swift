//
//  SearchVC.swift
//  Stock App
//
//  Created by Aidyn Assan on 19.07.2022.
//

import UIKit

protocol SearchViewInput: AnyObject {
    func setSearcResults(with stocks: [TableViewModel])
}

class SearchViewController: UIViewController, SearchViewInput {
    
    var output: SearchViewOutput?
    
    var searchManager: SearchManager!
    
    var searchResults: [TableViewModel] = [] {
        didSet {
            if searchResults.isEmpty {
                searchedView.isHidden = false
                tableView.isHidden = true
            }else {
                searchedView.isHidden = true
                tableView.isHidden = false
            }
        }
    }
    
    let searchedView = UIView()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(StockTableViewCell.self,
                           forCellReuseIdentifier: StockTableViewCell.reuseId)
        return tableView
    }()
    
    
    
    func setSearcResults(with stocks: [TableViewModel]) {
        searchResults = stocks
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchVC()
        configureSearchedStocks()
        setupTableView()
    }
    
    func configureSearchVC() {
        searchManager.searchForQuery = { [weak self] query in
            self?.output?.searchFor(query: query)
        }
        searchManager.canselSearch = { [weak self] in
            let _ = self?.searchResults.first
            self?.searchResults = []
            self?.tableView.reloadData()
        }
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search for a stock"
        searchController.searchBar.delegate = searchManager
        searchController.searchResultsUpdater = searchManager
        navigationItem.searchController = searchController
    }

    func configureSearchedStocks() {
        tableView.isHidden = true
        guard let vc = output?.searchedStocks() else { return }
        
        add(childVC: vc, to: searchedView)
        searchedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchedView)
        NSLayoutConstraint.activate([
            searchedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchedView.heightAnchor.constraint(equalToConstant: 122),
            searchedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchedView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupTableView() {
        searchManager.setCellWithStock = { [weak self] index in
            self?.searchResults[index]
        }
        searchManager.searchResultCount = { [ weak self ] in
            self?.searchResults.count ?? 0
        }
        searchManager.didSelectStock = { [weak self] index in
            guard let symbol = self?.searchResults[index].symbol else { return }
            guard let companyName = self?.searchResults[index].companyName else { return }
            self?.output?.showDetails(of: symbol, and: companyName)
        }
        tableView.delegate = searchManager
        tableView.dataSource = searchManager
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







