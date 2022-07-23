//
//  SearchedColectionVC.swift
//  Stock App
//
//  Created by Aidyn Assan on 22.07.2022.
//

import UIKit
import Algorithms

class SearchedColectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
	
	var tickets: [String]? {
		didSet {
			collectionView.reloadData()
		}
	}
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "You've searched for this"
		label.font = .boldSystemFont(ofSize: 24)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsets(top: 2, left: 15, bottom: 2, right: 0)
		layout.minimumLineSpacing = 3
		layout.minimumInteritemSpacing = 3
		layout.scrollDirection = .horizontal
		let collectionView = UICollectionView(frame: .zero,
											  collectionViewLayout: layout)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
	func appendNew(ticket: String) {
		if tickets != nil {
			tickets?.append(ticket)
		}else {
			tickets = [ticket]
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		configureUI()
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(SearchedCVCell.self, forCellWithReuseIdentifier: SearchedCVCell.reuseId)
    }
	
	func configureUI() {
		view.addSubview(titleLabel)
		view.addSubview(collectionView)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
			titleLabel.heightAnchor.constraint(equalToConstant: 28),
			
			collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		tickets?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchedCVCell.reuseId, for: indexPath) as! SearchedCVCell
		cell.set(title: tickets?[indexPath.row] ?? "")
		return cell
	}
}


extension SearchedColectionVC: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let label = UILabel()
		label.text = tickets![indexPath.item]
		label.font = .boldSystemFont(ofSize: 30)
		label.sizeToFit()
		return label.frame.size
	}
}
