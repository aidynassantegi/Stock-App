//
//  TimeIntervalCollectionViewDataManager.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 02.08.2022.
//

import Foundation
import UIKit


struct Timeintervals {
    let stringValue: String
    let timeValue: TimeInterval
}

final class TimeIntervalCollectionViewDataManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    private var timePeriod: [String] = ["1D", "1W", "3M", "6M" ,"1Y", "2Y"]
    
    private var timeIntervals: [Timeintervals] = [.init(stringValue: "1D", timeValue: 1),
                                                  .init(stringValue: "1W", timeValue: 7),
                                                  .init(stringValue: "1M", timeValue: 31),
                                                  .init(stringValue: "3M", timeValue: 93),
                                                  .init(stringValue: "6M", timeValue: 183),
                                                  .init(stringValue: "1Y", timeValue: 365),
                                                  .init(stringValue: "2Y", timeValue: 730)]
    
    var onTimeDidSelect: ((Double) -> Void)?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        timeIntervals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimePeriodCollectionViewCell.identifier, for: indexPath) as! TimePeriodCollectionViewCell
        cell.set(title: timeIntervals[indexPath.row].stringValue)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        onTimeDidSelect?(timeIntervals[indexPath.row].timeValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 42, height: 28) // collectionView height / 3
    }
}
