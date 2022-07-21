//
//  StockChartView.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 21.07.2022.
//

import UIKit
import Charts

class StockChartView: UIView {

    struct ViewModel {
        let data: [Double]
        let showLegend: Bool
        let showAxis: Bool
    }
    
    private let chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.pinchZoomEnabled = false
        chartView.setScaleEnabled(true)
        chartView.xAxis.enabled = false
        chartView.drawGridBackgroundEnabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        return chartView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(chartView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chartView.frame = bounds
    }

    func reset() {
        chartView.data = nil
    }
    
    func configure(with viewModel: ViewModel) {
//        var entries = [ChartDataEntry]()
//        
//        for (index, value) in viewModel.data.enumerated() {
//            entries.append(.init(x: Double(index), y: value))
//        }
//        
//        let dataSet = LineChartDataSet(entries: entries, label: "Label")
//        let data = LineChartData(dataSets: dataSet)
//        chartView.data = data
    }
}
