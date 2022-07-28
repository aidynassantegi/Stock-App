//
//  TableViewDataManager.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 27.07.2022.
//

import Foundation
import UIKit

final class TableViewDataManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    var companies: [CompanyProfile] = []
    
    var companiesMap: [CompanyProfile: [CandleStick]] = [:]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.reuseId, for: indexPath) as! StockTableViewCell
        cell.set(company: companies[indexPath.row], index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = StockInfoVC()
//        guard let stocks = stocks else { return }
//        vc.title = stocks[indexPath.row].symbol
//        navigationController?.pushViewController(vc, animated: true)
    }
}
