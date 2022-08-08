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
	var deleteItem: ((Int) -> Void)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResultCount?() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoriteTableCell.reuseId,
            for: indexPath) as! FavoriteTableCell
        if let stock = setCellWithStock?(indexPath.row) {
            cell.configure(with: stock, index: indexPath.row)
        }
		cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectStock?(indexPath.row)
    }
    
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
			-> UISwipeActionsConfiguration? {
			let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
				self.deleteItem?(indexPath.row)
				completionHandler(true)
			}
			deleteAction.image = UIImage(systemName: "trash")
			deleteAction.backgroundColor = .systemRed
			let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
			return configuration
	}
    
}
