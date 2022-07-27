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

