//
//  StockChartView.swift
//  Stock App
//
//  Created by Aidyn Assan on 20.07.2022.
//

import UIKit
import Charts

class StockChartView: LineChartView {
	
//	override init(frame: CGRect) {
//		super.init(frame: frame)
//		delegate = self
//		configureChart()
//		configureData()
//	}
//
//	required init?(coder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//
//	}
//
//	private func configureChart() {
//		rightAxis.enabled = false
//		leftAxis.enabled = false
//		xAxis.enabled = false
//		animate(xAxisDuration: 1)
//		legend.enabled = false
//		translatesAutoresizingMaskIntoConstraints = false
//	}
//
//	func reset() {
//		chartView.data = nil
//	}
//
//	private func configureData() {
//		let chartData: [ChartDataEntry]	= [
//			ChartDataEntry(x: 1, y: 2),
//			ChartDataEntry(x: 2, y: 3),
//			ChartDataEntry(x: 3, y: 5),
//			ChartDataEntry(x: 4, y: 1),
//			ChartDataEntry(x: 5, y: 7),
//			ChartDataEntry(x: 6, y: 9),
//			ChartDataEntry(x: 7, y: 4),
//			ChartDataEntry(x: 8, y: 5),
//			ChartDataEntry(x: 9, y: 9),
//			ChartDataEntry(x: 10, y: 13),
//			ChartDataEntry(x: 11, y: 10),
//			ChartDataEntry(x: 12, y: 8),
//			ChartDataEntry(x: 13, y: 3),
//			ChartDataEntry(x: 14, y: 2),
//			ChartDataEntry(x: 15, y: 3),
//			ChartDataEntry(x: 16, y: 5),
//			ChartDataEntry(x: 17, y: 1),
//			ChartDataEntry(x: 18, y: 7),
//			ChartDataEntry(x: 19, y: 9),
//			ChartDataEntry(x: 20, y: 4),
//			ChartDataEntry(x: 21, y: 5),
//			ChartDataEntry(x: 22, y: 9)
//		]
//
//		let set1 = LineChartDataSet(entries: chartData)
//
//		set1.drawCirclesEnabled = false
//		set1.mode = .cubicBezier
//		set1.lineWidth = 3
//		set1.lineCapType = .round
//		set1.setColor(.black)
//
//		let coloTop = UIColor.systemGray.cgColor
//		let colorBottom = UIColor.white.cgColor
//		let gradientColors = [coloTop, colorBottom] as CFArray // Colors of the gradient
//		let colorLocations:[CGFloat] = [0.7, 0.0] // Positioning of the gradient
//		let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(),
//									   colors: gradientColors, locations: colorLocations) // Gradient Object
//		set1.fill = LinearGradientFill(gradient: gradient!, angle: 90.0) // Set the Gradient
//		set1.drawFilledEnabled = true // Draw the Gradient
//
//		set1.highlightColor = .black
//		set1.drawHorizontalHighlightIndicatorEnabled = false
//
//		set1.drawFilledEnabled = true
//		let data = LineChartData(dataSet: set1)
//		data.setDrawValues(false)
//
//		self.data = data
//	}
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

extension StockChartView: ChartViewDelegate {
	func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
		print(entry)
	}
}
