//
//  Extensions.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 21.07.2022.
//

import Foundation

extension DateFormatter {
    static let newsDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }()
}
