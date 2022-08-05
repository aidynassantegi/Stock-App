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
    func removeText(_ deselected: Bool)
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
    
    private let customMarkerView = CustomMarkerView()
    
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
        chartView.notifyDataSetChanged()
        
        var entries = [ChartDataEntry]()
                
        for index in 0...viewModel.data.count - 1 {
            entries.append(.init(x: viewModel.timeStamp[index], y: viewModel.data[index]))
        }
        
      //  chartView.rightAxis.enabled = viewModel.showAxis
        chartView.leftAxis.enabled = viewModel.showAxis
        chartView.xAxis.enabled = viewModel.showAxis
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.valueFormatter = CustomAxis()
        
        customMarkerView.chartView = chartView
        chartView.marker = customMarkerView

        let dataSet = LineChartDataSet(entries: entries, label: "")
        let colorTop = viewModel.fillColor.cgColor
        let colorBottom = UIColor.systemBackground.cgColor
        let gradientColors = [colorTop, colorBottom] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [0.75, 0.0] // Positioning of the gradient
        
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                       colors: gradientColors, locations: colorLocations) // Gradient Object
        dataSet.fill = LinearGradientFill(gradient: gradient!, angle: 90.0) // Set the Gradient
        
        dataSet.drawFilledEnabled = true
        dataSet.drawIconsEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        
        dataSet.setColor(viewModel.fillColor)
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.highlightColor = viewModel.fillColor
        dataSet.highlightLineWidth = 1.5
        
        let data = LineChartData(dataSet: dataSet)
        chartView.data = data
        
    }
}

extension StockChartView: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        delegate?.showValue(x: entry.x, y: entry.y)
    }
    
    func chartViewDidEndPanning(_ chartView: ChartViewBase) {
        delegate?.removeText(true)
        chartView.highlightValue(nil, callDelegate: false)
    }

}
