//
//  StockDetailsViewController.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 29.07.2022.
//

import UIKit
import FloatingPanel

class StockDetailsViewController: UIViewController, FloatingPanelControllerDelegate {
    var symbol: String!
    var companyName: String!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = symbol
        
        guard let collectionView = collectionView else { return }
        guard let chartView = chartView else { return }
        
        add(childVC: collectionView, to: collectionViewPlaceholder)
        add(childVC: chartView, to: chartViewPlaceholder)
        setViews()
        
        setUpFloatingPanel()
    }
    
    private func setViews() {
        chartViewPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        collectionViewPlaceholder.translatesAutoresizingMaskIntoConstraints = false

        view.addSubviews(chartViewPlaceholder, collectionViewPlaceholder)
        NSLayoutConstraint.activate([ chartViewPlaceholder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                                      chartViewPlaceholder.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                      chartViewPlaceholder.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                      chartViewPlaceholder.heightAnchor.constraint(equalToConstant: 200),
                                      
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
    
