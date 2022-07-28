//
//  MarketDataResponse.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 21.07.2022.
//

import Foundation

struct MarketDataResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case open = "o"
        case close = "c"
        case high = "h"
        case low = "l"
        case status = "s"
        case timeStamps = "t"
    }
    
    let open: [Double]
    let close: [Double]
    let high: [Double]
    let low: [Double]
    let status: String
    let timeStamps: [TimeInterval]
    
    var candleSticks: [CandleStick] {
        var result = [CandleStick]()
        for index in 0..<open.count {
            result.append(.init(date: Date(timeIntervalSince1970: timeStamps[index]), high: high[index], low: low[index], open: open[index], close: close[index]))
        }
        let sorted = result.sorted(by: {$0.date > $1.date})
        return sorted
    }

}

struct CandleStick {
    let date: Date
    let high: Double
    let low: Double
    let open: Double
    let close: Double
}
