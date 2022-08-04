//
//  MetricCollectionViewCell.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 29.07.2022.
//

import UIKit

class MetricCollectionViewCell: UICollectionViewCell {
    static let identifier = "MetricCollectionViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(nameLabel, valueLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        valueLabel.sizeToFit()
        nameLabel.sizeToFit()
        
        NSLayoutConstraint.activate([nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
                                     nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
                                     nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),

                                     valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
                                     valueLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
                                     valueLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
                                     valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
                                    ])
    }
 
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        valueLabel.text = nil
    }
    
    func configure(with viewModel: MetricCollectionViewEntity){
        print(viewModel)
        nameLabel.text = viewModel.name + ":"
        valueLabel.text = viewModel.value
    }
}
