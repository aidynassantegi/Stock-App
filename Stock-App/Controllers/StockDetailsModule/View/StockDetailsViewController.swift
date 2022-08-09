//
//  StockDetailsViewController.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 29.07.2022.
//

import UIKit
import FloatingPanel
import CoreData

protocol StockDetailViewInput: AnyObject {
    func fillStar()
    func setUpNavigationController(isFavorite: Bool)
}

protocol StockDetailViewOutput: AnyObject {
    func save(name: String, companyName: String)
    func delete(name: String, companyName: String)
    func viewDidAppear(with symbol: String)
}

class StockDetailsViewController: UIViewController, FloatingPanelControllerDelegate, StockDetailViewInput {
    var output: StockDetailViewOutput?
    
    var symbol: String!
    var companyName: String!
    
    var shortInfoView: ShortInfoViewController?
    var shortInfoViewPlaceholder = UIView()
    
    var collectionView: FinancialCollectionViewController?
    var collectionViewPlaceholder = UIView()

    var chartView: ChartViewController?
    var chartViewPlaceholder = UIView()
    
    var newsController: NewsViewController?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableHeaderView.self, forHeaderFooterViewReuseIdentifier: NewsTableHeaderView.identifier)
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output?.viewDidAppear(with: symbol)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setViews()
        
        setUpFloatingPanel()
    }
    
    func setUpNavigationController(isFavorite: Bool) {
        self.isFavorite = isFavorite
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(saveTapped))
		if isFavorite {
			fillStar()
		}
    }
	
	func fillStar() {
		navigationItem.rightBarButtonItem?.tintColor = .systemYellow
		navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
	}
    func unFillStar() {
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
    }
    private var isFavorite = false
    @objc func saveTapped() {
		if !isFavorite{
            output?.save(name: symbol, companyName: companyName)
			fillStar()
        }else {
            output?.delete(name: symbol, companyName: companyName)
            unFillStar()
        }
    }
    
    private func setViews() {
        guard let shortInfoView = shortInfoView else { return }
        guard let collectionView = collectionView else { return }
        guard let chartView = chartView else { return }
        
        add(childVC: shortInfoView, to: shortInfoViewPlaceholder)
        add(childVC: collectionView, to: collectionViewPlaceholder)
        add(childVC: chartView, to: chartViewPlaceholder)
        
        chartViewPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        collectionViewPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        shortInfoViewPlaceholder.translatesAutoresizingMaskIntoConstraints = false
       
        view.addSubviews(shortInfoViewPlaceholder, chartViewPlaceholder, collectionViewPlaceholder)
        NSLayoutConstraint.activate([shortInfoViewPlaceholder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -50),
                                     shortInfoViewPlaceholder.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                                     shortInfoViewPlaceholder.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     shortInfoViewPlaceholder.heightAnchor.constraint(equalToConstant: 50),
                                     
                                     chartViewPlaceholder.topAnchor.constraint(equalTo: shortInfoViewPlaceholder.bottomAnchor, constant: 10),
                                     chartViewPlaceholder.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                                     chartViewPlaceholder.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     chartViewPlaceholder.heightAnchor.constraint(equalToConstant: 250),
                                     
                                     collectionViewPlaceholder.topAnchor.constraint(equalTo: chartViewPlaceholder.bottomAnchor, constant: 20),
                                     collectionViewPlaceholder.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     collectionViewPlaceholder.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     collectionViewPlaceholder.heightAnchor.constraint(equalToConstant: (view.height * 0.45))])
    }
    
    private func setUpFloatingPanel() {
        guard let vc = newsController else { return }
        
        let panel = FloatingPanelController(delegate: self)
        panel.surfaceView.backgroundColor = .secondarySystemBackground
        panel.set(contentViewController: vc)
        panel.addPanel(toParent: self)
        panel.track(scrollView: vc.newsTableView)
    }
    
}
    
