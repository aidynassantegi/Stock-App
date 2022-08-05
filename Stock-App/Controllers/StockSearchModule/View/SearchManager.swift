//
//  SearchManager.swift
//  Stock-App
//
//  Created by Aidyn Assan on 04.08.2022.
//

import UIKit

class SearchManager: NSObject, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var searchForQuery: ((String) -> Void)?
    var canselSearch: (() -> Void)?
    
    var searchResultCount: (() -> Int)?
    var setCellWithStock: ((Int) -> TableViewModel?)?
    var didSelectStock: ((Int) -> Void)?
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let lastSearch = searchBar.text,
                !lastSearch.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        canselSearch?()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        searchForQuery?(query)
    }
    
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
