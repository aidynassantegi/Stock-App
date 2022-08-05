//
//  CustomAxis.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 05.08.2022.
//

import Foundation
import Charts

final class CustomAxis: AxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("dd MMM")
        dateFormatter.locale = .current
        
        let date = Date(timeIntervalSince1970: value)
        
        return dateFormatter.string(from: date)
    }
}
