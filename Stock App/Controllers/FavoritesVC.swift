//
//  FavoritesVC.swift
//  Stock App
//
//  Created by Aidyn Assan on 19.07.2022.
//

import UIKit

class FavoritesVC: UIViewController {

	let stocks = Stock.stocks.filter{ $0.isFavorite }
	
	let tableView: UITableView = {
		let tableView = UITableView()
		tableView.rowHeight = 68
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.reuseId)
	}
	
	func configureUI() {
		view.backgroundColor = .systemBackground
		view.addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		stocks.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.reuseId, for: indexPath) as! StockTableViewCell
		cell.set(stock: stocks[indexPath.row], index: indexPath.row)
		return cell
	}
	
	
}
