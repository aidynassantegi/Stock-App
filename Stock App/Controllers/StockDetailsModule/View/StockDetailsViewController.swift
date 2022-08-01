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
    
    let headerView: StockDetailsHeaderView = {
        let headerView = StockDetailsHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
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
       setUpConstraints()
        configureTable()
        fetchFinancialData()
        fetchNews()
    }
    
    private func configureTable() {
      //view.addSubviews(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.frame = view.bounds
    }
    
    private func fetchFinancialData() {
        let group = DispatchGroup()
        
        if candleStickdata.isEmpty {
            group.enter()
            apiManager.perform(MarketDataRequest.init(symbol: symbol, numberOfDays: 7)) { [weak self] (result: Result<MarketDataResponse, Error>) in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let data):
                    print("Date \(data.candleSticks[0].date)")
                    self?.candleStickdata = data.candleSticks
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        group.enter()
        apiManager.perform(FinancialMetricsRequest(symbol: symbol)) { [weak self] (result: Result<FinancialMetrics, Error>) in
            defer {
                group.leave()
            }
            switch result {
            case .success(let data):
                self?.metrics = data.metric
            case .failure(let error):
                print("error \(error)")
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            print("notify")
            print(self?.metrics)
            self?.renderChart()
        }
    }
    
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
    
    func setUpConstraints() {
        view.addSubviews(headerView, tableView)
        NSLayoutConstraint.activate([headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                                     headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     headerView.heightAnchor.constraint(equalToConstant: (view.height * 0.45)),
                                     
                                     tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
                                    ])
    }
    
    private func renderChart() {
       // let headerView = StockDetailsHeaderView(frame: CGRect(x: 0, y: 0, width: view.width, height: (view.height * 0.8) + 100))
        var viewModels = [MetricCollectionViewCell.ViewModel]()
        
        if let metrics = metrics {
            if let annualWeekHigh = metrics.AnnualWeekHigh {
                viewModels.append(.init(name: "52W High", value: "\(annualWeekHigh)"))
            } else {
                viewModels.append(.init(name: "52W High", value: "-"))
            }
    
            if  let annualWeekLow = metrics.AnnualWeekLow {
                viewModels.append(.init(name: "52W Low", value: "\(annualWeekLow)"))
            } else {
                viewModels.append(.init(name: "52W High", value: "-"))
            }
            
            if let annualWeekLowDate = metrics.AnnualWeekLowDate {
                viewModels.append(.init(name: "52W Low Date", value: "\(annualWeekLowDate)"))
            } else {
                viewModels.append(.init(name: "52W Low Date", value: "-"))
            }
            
            if let annualWeekPriceReturnDaily = metrics.AnnualWeekPriceReturnDaily {
                viewModels.append(.init(name: "52W Return", value: "\(annualWeekPriceReturnDaily)"))
            }else {
                viewModels.append(.init(name: "52W Return", value: "-"))
            }
            
            if let beta = metrics.beta {
                viewModels.append(.init(name: "Beta", value: "\(beta)"))
            }else {
                viewModels.append(.init(name: "Beta", value: "-"))
            }
            
            if let tenDayAverageTradingVolume = metrics.TenDayAverageTradingVolume {
                viewModels.append(.init(name: "Avg Vol", value: "\(tenDayAverageTradingVolume)"))
            }else {
                viewModels.append(.init(name: "Avg Vol", value: "-"))
            }
        }
        let change = CalculateStockDynamic.getChangePercentage(for: candleStickdata)
        
        let data: [Double : Date] = [:]
        
        headerView.configure(chartViewModel: .init(data: candleStickdata.reversed().map{ $0.close},
                                                   showLegend: true,
                                                   showAxis: true,
                                                   fillColor: change < 0 ? .systemRed : .systemGreen,
                                                   timeStamp: candleStickdata.reversed().map { $0.date.timeIntervalSince1970}),
                             metricViewModels: viewModels)
        //tableView.tableHeaderView = headerView
    }
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
