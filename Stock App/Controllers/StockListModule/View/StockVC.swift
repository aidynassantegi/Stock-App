//
//  StockVC.swift
//  Stock App
//
//  Created by Aidyn Assan on 19.07.2022.
//

import UIKit
import FloatingPanel

protocol StockListViewInput: AnyObject {
    func handleObtainedSymbols(_ symbols: [StockSymbols])
    func handleObtainedCompanyProfiles(_ companies: [CompanyProfile])
}

protocol StockListViewOutput: AnyObject {
    func didLoadView()
    func didSelectStockSell(with index: Int)
}

class StockVC: UIViewController, FloatingPanelControllerDelegate {
	
	let stocks = Stock.stocks
   // private var stockSymbols: [String] = ["AAPL", "MSFT", "GOOG", "AMZN", "TSLA", "META", "NVDA", "KO", "NFLX", "DHR", "VZ"]
    
    private var companies: [CompanyProfile] = []
    private var symbols: [StockSymbols] = []
    
    private var stocksMap: [String: [CandleStick]] = [:]
    
    var tableDataManager: TableViewDataManager?
    var output: StockListViewOutput?
    
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
        configureTable()
		configureUI()
        setUpChild()
        output?.didLoadView()
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
    
    func configureTable() {
        tableView.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.reuseId)
        tableView.delegate = tableDataManager
        tableView.dataSource = tableDataManager
    }
    
//    private func loadData() {
//        let group = DispatchGroup()
//
//        for symbol in stockSymbols{
//            group.enter()
//                }
    //            NetworkManager.shared.marketData(for: symbol) { [weak self] result in
    //                defer{
    //                    group.leave()
//
//                switch result {
//                case .success(let data):
//                    self?.stocksMap[symbol] = data.candleSticks
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
//        group.notify(queue: .main) { [weak self] in
//
//        }
//    }
    
	
}

extension StockVC: StockListViewInput {
    func handleObtainedSymbols(_ symbols: [StockSymbols]) {
        self.symbols = symbols
        print(symbols.count)
        tableDataManager?.stocks = symbols
        tableView.reloadData()
    }
    
    func handleObtainedCompanyProfiles(_ companies: [CompanyProfile]) {
        self.companies = companies
        //table view reload data
    }
}

