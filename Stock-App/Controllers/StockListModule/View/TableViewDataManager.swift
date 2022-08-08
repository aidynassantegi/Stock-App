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
    
    var viewModel: [TableViewModel] = []
    
    var onStockDidSelect: ((String, String) -> Void)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.reuseId, for: indexPath) as! StockTableViewCell
        cell.configure(with: viewModel[indexPath.row], index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onStockDidSelect?(viewModel[indexPath.row].symbol, viewModel[indexPath.row].companyName)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
