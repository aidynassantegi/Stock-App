//
//  StockTableViewCell.swift
//  Stock App
//
//  Created by Aidyn Assan on 19.07.2022.
//

import UIKit
import Charts
import SDWebImage

class StockTableViewCell: UITableViewCell {
	
	static let reuseId = "StockTableViewCell"
	
    struct ViewModel {
        let symbol: String
        let companyName: String
        let price: String
        let isFavorite: Bool
        let changeColor: UIColor // red or green
        let changePercentage: String
    }
    
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
        label.numberOfLines = 0
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
		label.textColor = .white
		label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 3
		return label
	}()
    
    let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let miniChartView: StockChartView = {
        let chartView = StockChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        return chartView
    }()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
        
		configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    func configure(with viewModel: TableViewModel, index: Int) {
        
//        if viewModel.logo == "" {
//            stockImageView.image = UIImage(named: "local-file-not-found")
//        }else {
//            stockImageView.sd_setImage(with: URL(string: viewModel.logo), completed: nil)
//        }
        symbolLabel.text = viewModel.symbol
        companyNameLabel.text = viewModel.companyName
        priceLabel.text = viewModel.price
        changesLabel.text = viewModel.changePercentage
        changesLabel.backgroundColor = viewModel.changeColor
        currencyLabel.text = viewModel.currency
        backgroundColor = index % 2 == 0 ? .systemGray6 : .systemBackground
        
        miniChartView.configure(with: viewModel.chartView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        symbolLabel.text = nil
        companyNameLabel.text = nil
        priceLabel.text = nil
        changesLabel.text = nil
        miniChartView.reset()
    }
    
	private func configureUI() {
		layer.masksToBounds = true
		layer.cornerRadius = 16
		
        addSubviews(symbolLabel, currencyLabel ,companyNameLabel, priceLabel, changesLabel, miniChartView)
		
		let padding: CGFloat = 8
		NSLayoutConstraint.activate([
//			stockImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
//			stockImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
//			stockImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
//			stockImageView.widthAnchor.constraint(equalTo: stockImageView.heightAnchor),
			
			symbolLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
			symbolLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14),
			symbolLabel.heightAnchor.constraint(equalToConstant: 24),
			
            currencyLabel.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 2),
            currencyLabel.centerYAnchor.constraint(equalTo: symbolLabel.centerYAnchor),
            currencyLabel.heightAnchor.constraint(equalToConstant: 16),
            //currencyLabel.widthAnchor.constraint(equalToConstant: 16),
			
			//companyNameLabel.heightAnchor.constraint(equalToConstant: 16),
            
			priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14),
			priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17),
			priceLabel.heightAnchor.constraint(equalToConstant: 24),
			
			changesLabel.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor),
			changesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            changesLabel.heightAnchor.constraint(equalToConstant: 16),
            
            companyNameLabel.leadingAnchor.constraint(equalTo: symbolLabel.leadingAnchor),
            companyNameLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 2),
            companyNameLabel.trailingAnchor.constraint(equalTo: changesLabel.leadingAnchor, constant: 2),
            
            miniChartView.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            miniChartView.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -(contentView.width/3) - 5),
            miniChartView.widthAnchor.constraint(equalToConstant: contentView.width/3),
            miniChartView.heightAnchor.constraint(equalToConstant: contentView.height * 0.8)
            // miniChartView.trailingAnchor.constraint(equalTo: changesLabel.leadingAnchor, constant: -5)
           // miniChartView.trailingAnchor.constraint(equalTo: changesLabel.leadingAnchor, constant: -5)
		])
	}
}
