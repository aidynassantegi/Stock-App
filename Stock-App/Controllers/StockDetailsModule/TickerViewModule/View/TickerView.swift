//
//  TickerView.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 04.08.2022.
//

import UIKit

class TickerView: UIView {

    let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let latestPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let symbolLabel: UILabel = {
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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        addSubviews(stackView, chartView)
        stackView.addArrangedSubview(symbolLabel)
        stackView.addArrangedSubview(priceChangeLabel)
        stackView.addArrangedSubview(latestPriceLabel)
        
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
                                     stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
                                     stackView.widthAnchor.constraint(equalTo: priceChangeLabel.frame.width > latestPriceLabel.frame.width ? priceChangeLabel.widthAnchor : latestPriceLabel.widthAnchor),
                                     stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
                                    
                                     chartView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
                                     chartView.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10),
                                     chartView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
                                     chartView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -2)])
    }

}
