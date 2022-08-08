//
//  FavoriteManager.swift
//  Stock-App
//
//  Created by Aidyn Assan on 06.08.2022.
//

import UIKit

//FavoriteManager

class FavoriteManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var searchResultCount: (() -> Int)?
    var setCellWithStock: ((Int) -> TableViewModel?)?
    var didSelectStock: ((Int) -> Void)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResultCount?() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: StockTableViewCell.reuseId,
            for: indexPath) as! StockTableViewCell
        if let stock = setCellWithStock?(indexPath.row) {
            cell.configure(with: stock, index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectStock?(indexPath.row)
    }
    
    
}
