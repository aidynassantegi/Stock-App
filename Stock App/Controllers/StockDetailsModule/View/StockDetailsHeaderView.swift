//
//  StockDetailsHeaderView.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 29.07.2022.
//

import Foundation
import UIKit

class StockDetailsHeaderView: UIView {
    
    private var metricViewModels: [MetricCollectionViewCell.ViewModel] = []
    
    private var showData: String?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chartView: StockChartView = {
        let chartView = StockChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        return chartView
    }()
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews(label, chartView, collectionView)
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                                     label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                                     label.heightAnchor.constraint(equalToConstant: 20),
                                     label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                                     
                                     chartView.topAnchor.constraint(equalTo: label.bottomAnchor),
                                     chartView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                                     chartView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                                     chartView.heightAnchor.constraint(equalToConstant: 250),
                                     
                                     collectionView.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 20),
                                     collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
                                     collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
                                     collectionView.heightAnchor.constraint(equalToConstant: 100)
                                    ])
        
    }
    
    func configure(chartViewModel: StockChartView.ViewModel, metricViewModels: [MetricCollectionViewCell.ViewModel]) {
        chartView.configure(with: chartViewModel)
        chartView.delegate = self
        print(showData)
        self.metricViewModels = metricViewModels
        collectionView.reloadData()
    }
}

extension StockDetailsHeaderView: ChartData {
    func showValue(x: Double, y: Double) {
        let date = Date(timeIntervalSince1970: x)
        showData = "\(date.converToMonthYearHourFormat()) \(y) USD"
        label.text = showData
    }
}

extension StockDetailsHeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        metricViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = metricViewModels[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MetricCollectionViewCell.identifier, for: indexPath) as! MetricCollectionViewCell
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: width * 0.7, height: 100 / 3) // collectionView height / 3
    }
}


