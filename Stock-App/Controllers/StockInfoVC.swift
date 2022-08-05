//
//  StockInfoVC.swift
//  Stock App
//
//  Created by Aidyn Assan on 20.07.2022.
//

import UIKit
import Charts

class StockInfoVC: UIViewController {

	let chart = StockChartView()
    
	let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
		layout.itemSize = CGSize(width: 50, height: 50)
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
	let intervals = ["D", "W", "M", "6M", "1Y", "All"]
	
	let buyButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Buy for $151.04", for: .normal)
		button.tintColor = .white
		button.titleLabel?.font = .boldSystemFont(ofSize: 24)
		button.backgroundColor = .black
		button.layer.cornerRadius = 16
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	let priceLabel: UILabel = {
		let label = UILabel()
		label.text = "$151.04"
		label.textAlignment = .center
		label.font = .boldSystemFont(ofSize: 36)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let changeLabel: UILabel = {
		let label = UILabel()
		label.text = "+1.23%"
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 14)
		label.textColor = .systemGreen
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureUI()
		navigationController?.navigationBar.prefersLargeTitles = false
    }
	
	func configureUI() {
		view.backgroundColor = .systemBackground
		view.addSubview(chart)
		collectionView.dataSource = self
		collectionView.delegate = self
		view.addSubview(collectionView)
		view.addSubview(buyButton)
		view.addSubview(priceLabel)
		view.addSubview(changeLabel)
		NSLayoutConstraint.activate([
			buyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
			buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
			buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
			buyButton.heightAnchor.constraint(equalToConstant: 65),
			
			collectionView.bottomAnchor.constraint(equalTo: buyButton.topAnchor, constant: -10),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			collectionView.heightAnchor.constraint(equalToConstant: 60),
			
			chart.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -20),
			chart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10),
			chart.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
			chart.heightAnchor.constraint(equalToConstant: 240),
			
			changeLabel.bottomAnchor.constraint(equalTo: chart.topAnchor, constant: -50),
			changeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
			changeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
			changeLabel.heightAnchor.constraint(equalToConstant: 16),
			
			priceLabel.bottomAnchor.constraint(equalTo: changeLabel.topAnchor, constant: -5),
			priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
			priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
			priceLabel.heightAnchor.constraint(equalToConstant: 32)
		])
		
		collectionView.register(IntervalCVCell.self, forCellWithReuseIdentifier: IntervalCVCell.reuseId)
	}
	
}

extension StockInfoVC: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		intervals.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IntervalCVCell.reuseId, for: indexPath) as! IntervalCVCell
		cell.set(title: intervals[indexPath.row])
		return cell
	}
	
	
}
