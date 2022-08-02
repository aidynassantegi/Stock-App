//
//  StockDetailsHeaderView.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 29.07.2022.
//

import Foundation
import UIKit

protocol FinancialDataViewInput: AnyObject {
    func handleObtainedMetrics(_ metrics: Metrics)
    func handleObtainedEntity(_ entity: [MetricCollectionViewEntity])
}

protocol FinancialDataViewOutput: AnyObject {
    func didLoadView()
}

class FinancialCollectionView: UIView {
    
    private var showData: String?
    
    var financialMetricDataManager: FinancialMetricDataManager?
    var financialDataViewOutput: FinancialDataViewOutput?
//
//    private let label: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.font = .systemFont(ofSize: 15)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let chartView: StockChartView = {
//        let chartView = StockChartView()
//        chartView.translatesAutoresizingMaskIntoConstraints = false
//        return chartView
//    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MetricCollectionViewCell.self, forCellWithReuseIdentifier: MetricCollectionViewCell.identifier)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        financialDataViewOutput?.didLoadView()
        collectionView.delegate = financialMetricDataManager
        collectionView.dataSource = financialMetricDataManager
    }
    
    func didLoadAgain() {
        financialDataViewOutput?.didLoadView()
        collectionView.delegate = financialMetricDataManager
        collectionView.dataSource = financialMetricDataManager
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(collectionView)
        NSLayoutConstraint.activate([
                                     collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
                                     collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
                                     collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
                                     collectionView.heightAnchor.constraint(equalToConstant: 100)
                                    ])
        
    }
    
//    func configure(chartViewModel: StockChartView.ViewModel, metricViewModels: [MetricCollectionViewEntity]) {
//        chartView.configure(with: chartViewModel)
//        chartView.delegate = self
//        print(showData)
//        //self.metricViewModels = metricViewModels
//        collectionView.reloadData()
//    }
}

extension FinancialCollectionView: FinancialDataViewInput {
    func handleObtainedEntity(_ entity: [MetricCollectionViewEntity]) {
        print("entity \(entity)")
        if financialMetricDataManager != nil {
            financialMetricDataManager?.metricViewModels = entity
        }
        collectionView.reloadData()
    }
    
    func handleObtainedMetrics(_ metrics: Metrics) {
        print(metrics)
    }
}

//extension StockDetailsHeaderView: ChartData {
//    func showValue(x: Double, y: Double) {
//        let date = Date(timeIntervalSince1970: x)
//        showData = "\(date.converToMonthYearHourFormat()) \(y) USD"
//        label.text = showData
//    }
//}


