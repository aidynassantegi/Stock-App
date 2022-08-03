//
//  TimePeriodCollectionViewCell.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 01.08.2022.
//

import UIKit

class TimePeriodCollectionViewCell: UICollectionViewCell {
    static let identifier = "TimePeriodCollectionViewCell"
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .black
                label.textColor = .white
            }else {
                backgroundColor = .systemGray6
                label.textColor = .black
            }
        }
    }
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.backgroundColor = .clear
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        layer.cornerRadius = 14
        layer.cornerCurve = .continuous
        backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: String) {
        label.text = title
    }
}
