//
//  SearchedCVCell.swift
//  Stock-App
//
//  Created by Aidyn Assan on 01.08.2022.
//

import UIKit

class SearchedCVCell: UICollectionViewCell {
    static let reuseId = "SearchedCVCell"
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.backgroundColor = .clear
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        
        layer.masksToBounds = true
        layer.cornerRadius = 16
        
        backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: String) {
        label.text = title
    }
}
