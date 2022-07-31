//
//  StockChartView.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 21.07.2022.
//

import UIKit
import Charts

protocol ChartData: AnyObject {
    func showValue(x: Double, y: Double)
}

class StockChartView: UIView {

    weak var delegate: ChartData?
    
    struct ViewModel {
        let data: [Double]
        let showLegend: Bool
        let showAxis: Bool
        let fillColor: UIColor
        let timeStamp: [TimeInterval]
    }
    
    private let chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.pinchZoomEnabled = false
        chartView.setScaleEnabled(true)
        chartView.xAxis.enabled = false
        chartView.drawGridBackgroundEnabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
        return chartView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(chartView)
        chartView.delegate = self
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
        var entries = [ChartDataEntry]()
                
        for index in 0...viewModel.data.count - 1 {
            entries.append(.init(x: viewModel.timeStamp[index], y: viewModel.data[index]))
        }
        
        chartView.rightAxis.enabled = viewModel.showAxis
//        chartView.leftAxis.enabled =
        chartView.legend.enabled = viewModel.showLegend
        
        let dataSet = LineChartDataSet(entries: entries, label: "7 Days")
        dataSet.fillColor = viewModel.fillColor
        dataSet.drawFilledEnabled = true
        dataSet.drawIconsEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        let data = LineChartData(dataSet: dataSet)
        chartView.data = data
    }
}

extension StockChartView: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//        let date = Date(timeIntervalSince1970: entry.x)
//        print("Chart value \(date) \(entry.y)")
        delegate?.showValue(x: entry.x, y: entry.y)
    }
}
