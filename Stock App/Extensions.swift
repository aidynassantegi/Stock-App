//
//  Extensions.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 21.07.2022.
//

import Foundation
import UIKit

extension String {
    static func string(from timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        return DateFormatter.readableDateFormatter.string(from: date)
    }
}

extension DateFormatter {
    static let newsDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }()
    
    static let readableDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}

extension UIView {
    func addSubviews(_ view: UIView...){
        view.forEach {
            addSubview($0)
        }
    }
}

extension UIView {
    var width: CGFloat {
        frame.size.width
    }
    
    var height: CGFloat {
        frame.size.height
    }
    
    var left: CGFloat {
        frame.origin.x
    }
    
}
