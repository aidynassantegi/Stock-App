//
//  TimeIntervalCollectionViewDataManager.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 02.08.2022.
//

import Foundation
import UIKit

final class TimeIntervalCollectionViewDataManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    private var timePeriod: [String] = ["1D", "1W", "3M", "6M" ,"1Y", "2Y"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        timePeriod.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimePeriodCollectionViewCell.identifier, for: indexPath) as! TimePeriodCollectionViewCell
        cell.set(title: timePeriod[indexPath.row])
        cell.layer.cornerRadius = 3
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
