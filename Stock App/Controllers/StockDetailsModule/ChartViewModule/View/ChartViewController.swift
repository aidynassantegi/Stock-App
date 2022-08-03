//
//  ChartViewController.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 02.08.2022.
//

import UIKit

protocol ChartViewInput: AnyObject {
    func handleObtainedChartViewModel(_ viewModel: StockChartView.ViewModel)
}

protocol ChartViewOutput: AnyObject {
    func didLoadView()
}

class ChartViewController: UIViewController {

    var timePeriodCollectionDataManager: TimeIntervalCollectionViewDataManager?
    var chartViewOutput: ChartViewOutput?
    
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
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TimePeriodCollectionViewCell.self, forCellWithReuseIdentifier: TimePeriodCollectionViewCell.identifier)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.layer.cornerRadius = 10
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartViewOutput?.didLoadView()
        collectionView.delegate = timePeriodCollectionDataManager
        collectionView.dataSource = timePeriodCollectionDataManager
        setUpConstraints()
    }

    private func setUpConstraints() {
        view.addSubviews(label, chartView, collectionView)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
           // label.heightAnchor.constraint(equalToConstant: 20),
            
            chartView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            chartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            chartView.heightAnchor.constraint(equalToConstant: 150),
            
            collectionView.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

extension ChartViewController: ChartViewInput {
    func handleObtainedChartViewModel(_ viewModel: StockChartView.ViewModel) {
        print(viewModel)
        chartView.configure(with: viewModel)
        //Do not forget chart view delegate
    }
}
