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
            collectionView.widthAnchor.constraint(equalToConstant: 312),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 30)
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
        print("time stamp count \(viewModel.timeStamp.count)")
        chartView.configure(with: viewModel)
        //Do not forget chart view delegate
    }
}
