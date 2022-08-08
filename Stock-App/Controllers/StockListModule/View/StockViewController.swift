//
//  StockVC.swift
//  Stock App
//
//  Created by Aidyn Assan on 19.07.2022.
//

import UIKit
import FloatingPanel
import SkeletonView

protocol StockListViewInput: AnyObject {
    func handleObtainedSymbols(_ symbols: [StockSymbols])
    func handleObtainedCompanyProfiles(_ companies: [CompanyProfile])
    func handleObtainedTableViewModel(_ tableViewModel: [TableViewModel])
    
    func showSkeleton()
    func hideSkeleton()
}

protocol StockListViewOutput: AnyObject {
    func didLoadView()
    func didSelectStockSell(with symbol: String, companyName: String)
}

class StockViewController: UIViewController, FloatingPanelControllerDelegate {
	
   // private var stockSymbols: [String] = ["AAPL", "MSFT", "GOOG", "AMZN", "TSLA", "META", "NVDA", "KO", "NFLX", "DHR", "VZ"]
        
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
        let vc = NewsViewAssembly().assembly(newsType: .topNews)
        let panel = FloatingPanelController(delegate: self)
        panel.surfaceView.backgroundColor = .secondarySystemBackground
        panel.set(contentViewController: vc)
        panel.addPanel(toParent: self)
        panel.track(scrollView: vc.newsTableView)
    }
    
	func configureUI() {
		view.backgroundColor = .systemBackground
		view.addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
		])
	}
    
    func configureTable() {
        tableView.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.reuseId)
        tableView.delegate = tableDataManager
        tableView.dataSource = tableDataManager
        
        tableDataManager?.onStockDidSelect = { [weak self] symbol, name in
            print("symbol \(symbol) name \(name)")
            self?.output?.didSelectStockSell(with: symbol, companyName: name)
        }
    }
        
}

extension StockViewController: StockListViewInput {
    func hideSkeleton() {
        tableView.stopSkeletonAnimation()
        view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
    }
    
    func showSkeleton() {
        tableView.isSkeletonable = true
        let gradient = SkeletonGradient(baseColor: .concrete)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
//        tableView.showGradientSkeleton()
        tableView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: nil, transition: .crossDissolve(0.25))
    }
    
    func handleObtainedSymbols(_ symbols: [StockSymbols]) {
      //  self.symbols = symbols
        print(symbols.count)
    }
    
    func handleObtainedCompanyProfiles(_ companies: [CompanyProfile]) {
        tableDataManager?.companies = companies
        //tableView.reloadData()
    }
    
    func handleObtainedTableViewModel(_ tableViewModel: [TableViewModel]) {
        tableDataManager?.viewModel = tableViewModel
        
        tableView.reloadData()
        print(tableViewModel)
    }
}

