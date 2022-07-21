//
//  StockVC.swift
//  Stock App
//
//  Created by Aidyn Assan on 19.07.2022.
//

import UIKit
import FloatingPanel

class StockVC: UIViewController, FloatingPanelControllerDelegate {
	
	let stocks = Stock.stocks
	
	let tableVCView = UIView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
		configureTable()
        setUpChild()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
    private func setUpChild(){
        let vc = NewsViewController(type: .topNews)
        let panel = FloatingPanelController(delegate: self)
        panel.surfaceView.backgroundColor = .secondarySystemBackground
        panel.set(contentViewController: vc)
        panel.addPanel(toParent: self)
        panel.track(scrollView: vc.tableView)
    }
    
	func configureTable() {
		tableVCView.translatesAutoresizingMaskIntoConstraints = false
		let vc = StocksTableVC()
		vc.stocks = stocks
		add(childVC: vc, to: tableVCView)
	}

	func add(childVC: UIViewController, to containerView: UIView) {
		addChild(childVC)
		containerView.addSubview(childVC.view)
		childVC.view.frame = containerView.bounds
		childVC.didMove(toParent: self)
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
