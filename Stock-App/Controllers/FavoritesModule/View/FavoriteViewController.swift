//
//  FavoritesVC.swift
//  Stock App
//
//  Created by Aidyn Assan on 19.07.2022.
//

import UIKit

protocol FavoriteViewInput: AnyObject {
    func setWithStocksTable(stocks: [TableViewModel])
    
}


protocol FavoriteViewOutput: AnyObject {
    func viewDidAppear()
	func showDetails(of symbol: String, and companyName: String)
	func deleteItem(at index: Int)
	func goToSearchView()
}

class FavoriteViewController: UIViewController, FavoriteViewInput {
    
    var output: FavoriteViewOutput?
    
    var favoriteManager: FavoriteManager!
    
	var favoriteStocks: [TableViewModel] = [] {
		didSet {
			if favoriteStocks.isEmpty {
				noFavsLabel.isHidden = false
			}else {
				noFavsLabel.isHidden = true
			}
		}
	}
    
    func setWithStocksTable(stocks: [TableViewModel]) {
        favoriteStocks = stocks
        tableView.reloadData()
    }
    
	let noFavsLabel: UILabel = {
		let label = UILabel()
		label.text = "No Favorites Yet"
		label.font = .boldSystemFont(ofSize: 34)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private func setLabelUI() {
		view.addSubviews(noFavsLabel)
		NSLayoutConstraint.activate([
			noFavsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			noFavsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}
	
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(FavoriteTableCell.self,
                           forCellReuseIdentifier: FavoriteTableCell.reuseId)
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
		setLabelUI()
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(gotoSearch))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output?.viewDidAppear()
    }
	
	@objc func gotoSearch() {
		output?.goToSearchView()
	}
    
    
    private func setupTableView() {
        favoriteManager.setCellWithStock = { [weak self] index in
            self?.favoriteStocks[index]
        }
        favoriteManager.searchResultCount = { [ weak self ] in
            
            return self?.favoriteStocks.count ?? 0
        }
        favoriteManager.didSelectStock = { [weak self] index in
            guard let symbol = self?.favoriteStocks[index].symbol else { return }
            guard let companyName = self?.favoriteStocks[index].companyName else { return }
            self?.output?.showDetails(of: symbol, and: companyName)
        }
		favoriteManager.deleteItem = { [weak self] index in
			self?.favoriteStocks.remove(at: index)
			self?.output?.deleteItem(at: index)
			self?.tableView.reloadData()
		}
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
