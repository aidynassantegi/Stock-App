//
//  TopNewsViewController.swift
//  Stock App
//
//  Created by Айгерим Абдурахманова on 21.07.2022.
//

import UIKit
import SafariServices

enum NewsType {
    case topNews
    case company(symbol: String)
    
    var title: String {
        switch self {
        case .topNews:
            return "Business News"
        case .company(let symbol):
            return symbol.uppercased()
        }
    }
}

protocol NewsViewInput: AnyObject {
    func handleObtainedNews(_ news: [News])
}

protocol NewsViewOutput: AnyObject {
    func didLoadView()
    func didSelectNew(with url: URL)
}

class NewsViewController: UIViewController {
    
    private let type: NewsType
    var newsTableDataManager: NewsTableDataManager!
    var output: NewsViewOutput?
    
    let newsTableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableHeaderView.self, forHeaderFooterViewReuseIdentifier: NewsTableHeaderView.identifier)
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        table.separatorStyle = .singleLine
        table.separatorColor = .label
        table.separatorInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        table.backgroundColor = .clear
        table.rowHeight = 50
//        table.rowHeight = UITableView.automaticDimension
//        table.estimatedRowHeight = 70
        return table
    }()
    
    init(type: NewsType){
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.didLoadView()
        setUpTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newsTableView.frame = view.bounds
    }
    
    func setUpTable() {
        view.addSubview(newsTableView)
        newsTableDataManager.onNewDidSelect = { [weak self] newsUrl in
            self?.output?.didSelectNew(with: URL(string: newsUrl)!)
        }
        newsTableView.delegate = newsTableDataManager
        newsTableView.dataSource = newsTableDataManager
    }

//    private func openNews(url: URL) {
//        let vc = SFSafariViewController(url: url)
//        present(vc, animated: true)
//    }
//    
//    private func failedToOpenNewAlert() {
//        let alert = UIAlertController(title: "Unable to open", message: "Sorry, we were unable to open", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
//        present(alert, animated: true)
//    }
}

extension NewsViewController: NewsViewInput {
    func handleObtainedNews(_ news: [News]) {
        newsTableDataManager.news = news
        newsTableView.reloadData()
    }
}
