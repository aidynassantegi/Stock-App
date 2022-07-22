//
//  NewsTableViewCell.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 22.07.2022.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {

    static let identifier = "NewsTableViewCell"
    static let prefferedHeight: CGFloat = 120
    
    struct ViewModel {
        let source: String
        let headline: String
        let date: String
        let imageUrl: URL?
        
        init(model: News) {
            self.source = model.source
            self.headline = model.headline
            self.date = .string(from: model.datetime)
            self.imageUrl = URL(string: model.image)
        }
    }
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let headlineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        addSubviews(sourceLabel, headlineLabel, dateLabel, storyImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = contentView.height - 6
        
        NSLayoutConstraint.activate([storyImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2), storyImageView.widthAnchor.constraint(equalToConstant: imageSize),
                                     storyImageView.heightAnchor.constraint(equalToConstant: imageSize), storyImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 2),
                                     sourceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
                                     sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                                     sourceLabel.trailingAnchor.constraint(equalTo: storyImageView.leadingAnchor, constant: 5),
                                     
                                     headlineLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 5),
                                     headlineLabel.leadingAnchor.constraint(equalTo: sourceLabel.leadingAnchor),
                                     headlineLabel.trailingAnchor.constraint(equalTo: sourceLabel.trailingAnchor),
                                     
                                     dateLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 5),
                                     dateLabel.leadingAnchor.constraint(equalTo: sourceLabel.leadingAnchor),
                                     dateLabel.trailingAnchor.constraint(equalTo: sourceLabel.trailingAnchor),
                                     dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5)
                                    ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sourceLabel.text = nil
        headlineLabel.text = nil
        dateLabel.text = nil
        storyImageView.image = nil
    }
    
    func configure(with viewModel: ViewModel) {
        headlineLabel.text = viewModel.headline
        sourceLabel.text = viewModel.source
        dateLabel.text = viewModel.date
        storyImageView.sd_setImage(with: viewModel.imageUrl, completed: nil)
    }
}
