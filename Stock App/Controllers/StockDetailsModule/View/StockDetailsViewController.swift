//
//  StockDetailsViewController.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 29.07.2022.
//

import UIKit


class StockDetailsViewController: UIViewController {
    var symbol: String!
    var companyName: String!
    private var candleStickdata: [CandleStick] = []
    private var news: [News] = []
    private let apiManager = APIManager()
    private var metrics: Metrics?
    
    var collectionView: FinancialCollectionViewController?
    var collectionViewPlaceholder = UIView()

    var chartView: ChartViewController?
    var chartViewPlaceholder = UIView()
    
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
        title = companyName
        
        guard let collectionView = collectionView else { return }
        guard let chartView = chartView else { return }
        
        add(childVC: collectionView, to: collectionViewPlaceholder)
        add(childVC: chartView, to: chartViewPlaceholder)
        setViews()
        configureTable()
    }
    
    func setViews() {
        chartViewPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        collectionViewPlaceholder.translatesAutoresizingMaskIntoConstraints = false

        view.addSubviews(chartViewPlaceholder, collectionViewPlaceholder)
        NSLayoutConstraint.activate([ chartViewPlaceholder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
                                      chartViewPlaceholder.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                      chartViewPlaceholder.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                      chartViewPlaceholder.heightAnchor.constraint(equalToConstant: 200),
                                      
                                      collectionViewPlaceholder.topAnchor.constraint(equalTo: chartViewPlaceholder.bottomAnchor, constant: 10),
                                      collectionViewPlaceholder.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                      collectionViewPlaceholder.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                      collectionViewPlaceholder.heightAnchor.constraint(equalToConstant: (view.height * 0.45))])
    }
    
    private func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    
//    private func fetchNews() {
//        apiManager.perform(MarketNewsRequest(type: .company(symbol: symbol))) { [weak self] (result: Result<[News], Error>) in
//            switch result {
//            case .success(let data):
//                self?.news = data
//                self?.tableView.reloadData()
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
//    func setUpConstraints() {
//        view.addSubviews(collectionView,timePeriodCollectionView, tableView)
//        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
//                                     collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//                                     collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//                                     collectionView.heightAnchor.constraint(equalToConstant: (view.height * 0.45)),
//
//                                     timePeriodCollectionView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
//                                     timePeriodCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//                                     timePeriodCollectionView.heightAnchor.constraint(equalToConstant: 30),
//                                     timePeriodCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//
//                                     tableView.topAnchor.constraint(equalTo: timePeriodCollectionView
//                                        .bottomAnchor),
//                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
//                                    ])
}
    
extension StockDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        cell.configure(with: .init(model: news[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        NewsTableViewCell.prefferedHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsTableHeaderView.identifier) as! NewsTableHeaderView
        header.configure(with: .init(title: symbol.uppercased(), showButton: false))
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        NewsTableHeaderView.preferredHeight
    }
}
