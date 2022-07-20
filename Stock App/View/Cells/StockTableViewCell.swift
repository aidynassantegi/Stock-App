//
//  StockTableViewCell.swift
//  Stock App
//
//  Created by Aidyn Assan on 19.07.2022.
//

import UIKit

class StockTableViewCell: UITableViewCell {
	
	static let reuseId = "StockTableViewCell"
	
	let stockImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = 10
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	let symbolLabel: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 18)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let starImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.tintColor = .systemGray
		imageView.image = UIImage(systemName: "star.fill")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	let companyNameLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let priceLabel: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 18)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let changesLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12)
		label.textColor = .systemGreen
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func set(stock: Stock, index: Int) {
		stockImageView.image = UIImage(named: stock.image ?? "")
		symbolLabel.text = stock.symbol
		companyNameLabel.text = stock.companyName
		starImageView.tintColor = stock.isFavorite ? UIColor.systemYellow : UIColor.systemGray
		priceLabel.text = "$\(stock.price)"
		changesLabel.text = "\(stock.changes)%"
		backgroundColor = index%2==0 ? .systemGray6 : .systemBackground
	}
	
	private func configureUI() {
		layer.masksToBounds = true
		layer.cornerRadius = 16
		
		addSubview(stockImageView)
		addSubview(symbolLabel)
		addSubview(starImageView)
		addSubview(companyNameLabel)
		addSubview(priceLabel)
		addSubview(changesLabel)
		
		let padding: CGFloat = 8
		NSLayoutConstraint.activate([
			stockImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
			stockImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			stockImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
			stockImageView.widthAnchor.constraint(equalTo: stockImageView.heightAnchor),
			
			symbolLabel.leadingAnchor.constraint(equalTo: stockImageView.trailingAnchor, constant: 12),
			symbolLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14),
			symbolLabel.heightAnchor.constraint(equalToConstant: 24),
			
			starImageView.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 2),
			starImageView.centerYAnchor.constraint(equalTo: symbolLabel.centerYAnchor),
			starImageView.heightAnchor.constraint(equalToConstant: 16),
			starImageView.widthAnchor.constraint(equalToConstant: 16),
			
			companyNameLabel.leadingAnchor.constraint(equalTo: symbolLabel.leadingAnchor),
			companyNameLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 2),
			companyNameLabel.heightAnchor.constraint(equalToConstant: 16),
			
			priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14),
			priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17),
			priceLabel.heightAnchor.constraint(equalToConstant: 24),
			
			changesLabel.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor),
			changesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
			changesLabel.heightAnchor.constraint(equalToConstant: 16)
		])
	}
}
