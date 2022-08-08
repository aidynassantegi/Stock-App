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

class FinancialCollectionViewController: UIViewController {
    
    private var showData: String?
    
    var financialMetricDataManager: FinancialMetricDataManager?
    var financialDataViewOutput: FinancialDataViewOutput?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MetricCollectionViewCell.self, forCellWithReuseIdentifier: MetricCollectionViewCell.identifier)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 5
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        financialDataViewOutput?.didLoadView()
        collectionView.delegate = financialMetricDataManager
        collectionView.dataSource = financialMetricDataManager
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                                    collectionView.heightAnchor.constraint(equalToConstant: 100)
                                    ])
    }
   
}
    
extension FinancialCollectionViewController: FinancialDataViewInput {
    func handleObtainedEntity(_ entity: [MetricCollectionViewEntity]) {
        if financialMetricDataManager != nil {
            financialMetricDataManager?.metricViewModels = entity
        }
        collectionView.reloadData()
    }
    
    func handleObtainedMetrics(_ metrics: Metrics) {
       // print(metrics)
    }
}



