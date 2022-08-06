//
//  ChartViewController.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 02.08.2022.
//

import UIKit
import Charts

protocol ChartViewInput: AnyObject {
    func handleObtainedChartViewModel(_ viewModel: StockChartView.ViewModel)
}

protocol ChartViewOutput: AnyObject {
    func didLoadView()
    func didSelectTimeCell(with timePeriod: Double)
}

class ChartViewController: UIViewController {

    var timePeriodCollectionDataManager: TimeIntervalCollectionViewDataManager?
    var chartViewOutput: ChartViewOutput?
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: 46, height: 40)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TimePeriodCollectionViewCell.self, forCellWithReuseIdentifier: TimePeriodCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.delegate = self
        setUpCollectionView()
        chartViewOutput?.didLoadView()
        setUpConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let indexPath = IndexPath(item: 1, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = timePeriodCollectionDataManager
        collectionView.dataSource = timePeriodCollectionDataManager
        
        timePeriodCollectionDataManager?.onTimeDidSelect = { [weak self] timePeriod in
            self?.chartViewOutput?.didSelectTimeCell(with: timePeriod)
        }
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
            chartView.heightAnchor.constraint(equalToConstant: 200),
            
            collectionView.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}

extension ChartViewController: ChartData {
    func showValue(x: Double, y: Double) {
        let date = Date(timeIntervalSince1970: x)
        let showData = "\(date.converToMonthYearHourFormat())"
        label.text = showData
    }
    
    func removeText(_ deselected: Bool) {
        if deselected {
            label.text = nil
        }
    }
}

extension ChartViewController: ChartViewInput {
    func handleObtainedChartViewModel(_ viewModel: StockChartView.ViewModel) {
        chartView.configure(with: viewModel)
    }
}
