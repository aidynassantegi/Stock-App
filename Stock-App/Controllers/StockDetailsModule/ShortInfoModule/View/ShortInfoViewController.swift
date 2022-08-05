//
//  ShortInfoViewController.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 04.08.2022.
//

import UIKit

protocol ShortInfoViewInput: AnyObject {
    func handleObtainedEntity(_ entity: ShortInfoEntity)
}

protocol ShortInfoViewOutput {
    func didLoadView()
}

class ShortInfoViewController: UIViewController {
    
    private var entity: ShortInfoEntity!
    var shortInfoViewOutput: ShortInfoViewOutput?
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let changesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
        
        shortInfoViewOutput?.didLoadView()
    }
    
    private func setUpConstraints() {
        view.addSubviews(symbolLabel, companyNameLabel, priceLabel, changesLabel)
        NSLayoutConstraint.activate([symbolLabel.topAnchor.constraint(equalTo: view.topAnchor),
                                     symbolLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
                                    
                                     companyNameLabel.topAnchor.constraint(equalTo: view.topAnchor),
                                     companyNameLabel.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 5),
                                     companyNameLabel.heightAnchor.constraint(equalTo: symbolLabel.heightAnchor),
                                    
                                     priceLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 5),
                                     priceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
                                     priceLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -2),
                                    
                                     changesLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 5),
                                     changesLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 5),
                                     changesLabel.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor)])
    }

}

extension ShortInfoViewController: ShortInfoViewInput {
    func handleObtainedEntity(_ entity: ShortInfoEntity) {
        symbolLabel.text = entity.symbol
        companyNameLabel.text = entity.name
        priceLabel.text = entity.price + " USD"
        changesLabel.text = entity.changePercentage
        changesLabel.textColor = entity.color
    }
    
    
}
