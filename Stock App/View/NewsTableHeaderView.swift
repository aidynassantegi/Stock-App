//
//  NewsTableHeaderView.swift
//  Stock App
//
//  Created by Айгерим Абдурахманова on 22.07.2022.
//

import UIKit

class NewsTableHeaderView: UITableViewHeaderFooterView {

    static let identifier = "NewsTableHeaderView"
    static let preferredHeight: CGFloat = 50
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("+ Watchlist", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        return button
    }()
    
    struct ViewModel {
        let title: String
        let showButton: Bool
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundColor = .secondarySystemBackground
       // contentView.addSubviews(label, button)
        addSubview(label)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
                                     label.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 5),
                                     label.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5),
//                                     label.heightAnchor.constraint(equalToConstant: 40),
                                     label.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
                                    ])
        //label.frame = CGRect(x: 14, y: 0, width: contentView.width-20, height: contentView.height)
    }
    
    @objc private func didTapButton() {}
    
    func configure(with viewModel: ViewModel) {
        label.text = viewModel.title
       // button.isHidden = !viewModel.showButton
    }
}

