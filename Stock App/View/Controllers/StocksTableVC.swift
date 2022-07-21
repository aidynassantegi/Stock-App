//
//  StocksTableVC.swift
//  Stock App
//
//  Created by Aidyn Assan on 21.07.2022.
//

import UIKit

class StocksTableVC: UIViewController {

	var stocks: [Stock]? {
		didSet {
			tableView.reloadData()
		}
	}
	
	private let tableView: UITableView = {
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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	private func configureUI() {
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

extension StocksTableVC: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		stocks?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.reuseId, for: indexPath) as! StockTableViewCell
		guard let stocks = stocks else { return StockTableViewCell()}
		cell.set(stock: stocks[indexPath.row], index: indexPath.row)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = StockInfoVC()
		guard let stocks = stocks else { return }
		vc.title = stocks[indexPath.row].symbol
		navigationController?.pushViewController(vc, animated: true)
	}
}
