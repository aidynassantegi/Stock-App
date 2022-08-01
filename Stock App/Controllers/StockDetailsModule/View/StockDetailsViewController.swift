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
    
    var collectionView: FinancialCollectionView?
    
    let timePeriodCollectionView: PeriodCollection = {
        let timePeriodView = PeriodCollection()
        timePeriodView.translatesAutoresizingMaskIntoConstraints = false
        return timePeriodView
    }()
    
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
        setViews()
        //setViews(subViews: [collectionView])
        configureTable()
        fetchNews()
    }
    
    func setViews() {
        guard let collectionView = collectionView else {
            return
        }
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                                             collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                             collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                             collectionView.heightAnchor.constraint(equalToConstant: (view.height * 0.45))])
    }
    
    private func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
//    private func fetchFinancialData() {
//        let group = DispatchGroup()
//
//        if candleStickdata.isEmpty {
//            group.enter()
//            apiManager.perform(MarketDataRequest.init(symbol: symbol, numberOfDays: 7)) { [weak self] (result: Result<MarketDataResponse, Error>) in
//                defer {
//                    group.leave()
//                }
//                switch result {
//                case .success(let data):
//                    print("Date \(data.candleSticks[0].date)")
//                    self?.candleStickdata = data.candleSticks
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
//
//        group.enter()
//        apiManager.perform(FinancialMetricsRequest(symbol: symbol)) { [weak self] (result: Result<FinancialMetrics, Error>) in
//            defer {
//                group.leave()
//            }
//            switch result {
//            case .success(let data):
//                self?.metrics = data.metric
//            case .failure(let error):
//                print("error \(error)")
//            }
//        }
//
//        group.notify(queue: .main) { [weak self] in
//            print("notify")
//            print(self?.metrics)
//            self?.renderChart()
//        }
//    }
    
    private func fetchNews() {
        apiManager.perform(MarketNewsRequest(type: .company(symbol: symbol))) { [weak self] (result: Result<[News], Error>) in
            switch result {
            case .success(let data):
                self?.news = data
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
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
    
//    private func renderChart() {
//       // let headerView = StockDetailsHeaderView(frame: CGRect(x: 0, y: 0, width: view.width, height: (view.height * 0.8) + 100))
//        var viewModels = [MetricCollectionViewCell.ViewModel]()
//
//        let change = CalculateStockDynamic.getChangePercentage(for: candleStickdata)
//
//        let data: [Double : Date] = [:]
//
//        headerView.configure(chartViewModel: .init(data: candleStickdata.reversed().map{ $0.close},
//                                                   showLegend: true,
//                                                   showAxis: true,
//                                                   fillColor: change < 0 ? .systemRed : .systemGreen,
//                                                   timeStamp: candleStickdata.reversed().map { $0.date.timeIntervalSince1970}),
//                             metricViewModels: viewModels)
//    }
//}

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
