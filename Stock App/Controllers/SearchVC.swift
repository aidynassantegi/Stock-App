//
//  SearchVC.swift
//  Stock App
//
//  Created by Aidyn Assan on 19.07.2022.
//

import UIKit

class SearchVC: UIViewController {
	
	let tickets = ["AAPL", "GOOG", "S&P500", "NVDI", "AMD", "AAPL", "GOOG", "S&P500", "NVDI", "AMD", "AAPL", "GOOG", "S&P500", "NVDI", "AMD", "AAPL", "GOOG", "S&P500", "NVDI", "AMD"]
	
	let searchedCVView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		configureSearchVC()
		configureUI()
    }
    
	func configureSearchVC() {
		searchedCVView.isHidden = true
		let searchController = UISearchController()
		searchController.searchBar.placeholder = "Search for a stock"
		searchController.searchBar.delegate = self
		searchController.searchResultsUpdater = self
		navigationItem.searchController = searchController
	}

	func configureUI() {
		searchedCVView.translatesAutoresizingMaskIntoConstraints = false
		let vc = SearchedColectionVC()
		vc.tickets = tickets
		add(childVC: vc, to: searchedCVView)
		view.addSubview(searchedCVView)
		NSLayoutConstraint.activate([
			searchedCVView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			searchedCVView.heightAnchor.constraint(equalToConstant: 122),
			searchedCVView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			searchedCVView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
	
}

extension SearchVC: UISearchResultsUpdating, UISearchBarDelegate {
	func updateSearchResults(for searchController: UISearchController) {
		guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		
	}
	
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		searchedCVView.isHidden = false
	}
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		searchedCVView.isHidden = true
	}
}
