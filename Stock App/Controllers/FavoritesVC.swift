//
//  FavoritesVC.swift
//  Stock App
//
//  Created by Aidyn Assan on 19.07.2022.
//

import UIKit

class FavoritesVC: UIViewController {

	let stocks = Stock.stocks.filter{ $0.isFavorite }
	
	let tableVCView = UIView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
		configureTable()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	func configureTable() {
		tableVCView.translatesAutoresizingMaskIntoConstraints = false
		let vc = StocksTableVC()
		vc.stocks = stocks
		add(childVC: vc, to: tableVCView)
	}

	func configureUI() {
		view.backgroundColor = .systemBackground
		
		view.addSubview(tableVCView)
		NSLayoutConstraint.activate([
			tableVCView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableVCView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			tableVCView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			tableVCView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
}
