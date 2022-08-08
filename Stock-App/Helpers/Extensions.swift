//
//  Extensions.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 21.07.2022.
//

import Foundation
import UIKit


extension NumberFormatter {
    static let percentFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 4
        return formatter
    }()
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        return formatter
    }()
}


extension String {
    static func string(from timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        return DateFormatter.readableDateFormatter.string(from: date)
    }
    
    static func percentage(from double: Double) -> String {
        let formatter = NumberFormatter.percentFormatter
        return formatter.string(from: NSNumber(value: double)) ?? "\(double)"
    }
    
    static func formatted(from number: Double) -> String {
        let formatter = NumberFormatter.numberFormatter
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current

        return dateFormatter.date(from: self)
    }

    func converToDisplayFullFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.converToMonthYearHourFormat()
    }
    
    func converToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.converToMonthYearFormat()
    }
}

extension Date {
    func converToMonthYearHourFormat() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "E, d MMM yyyy HH:mm:ss"
        return dateFormater.string(from: self)
    }
    
    func converToMonthYearFormat() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM d, yyyy"
        return dateFormater.string(from: self)
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

extension UIViewController {
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}
