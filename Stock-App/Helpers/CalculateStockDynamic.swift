//
//  CalculateStockDynamic.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 28.07.2022.
//

import Foundation

struct CalculateStockDynamic {
    static func getLatestPrice(from data: [CandleStick]) -> String {
        guard let closingPrice = data.first?.close else { return ""}
        
        return .formatted(from: closingPrice)
    }
    
    static func getChangePercentage(for data: [CandleStick]) -> Double {
        let latesDate = data[0].date
        guard let latestClose = data.first?.close, let priorClose = data.first(where: {
            !Calendar.current.isDate($0.date, inSameDayAs: latesDate)
        })?.close else { return 0 }
        print("prior \(priorClose) lates \(latestClose)")
        let difference = 1 - (priorClose / latestClose)
        return difference
    }
}
