//
//  TopNewsViewController.swift
//  Stock App
//
//  Created by Айгерим Абдурахманова on 21.07.2022.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController {

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
    
    private let type: NewsType
    private var news: [News] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableHeaderView.self, forHeaderFooterViewReuseIdentifier: NewsTableHeaderView.identifier)
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        table.separatorStyle = .singleLine
        table.separatorColor = .label
        table.separatorInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        table.backgroundColor = .clear
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
        setUpTable()
        fetchNews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func setUpTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchNews() {
        APIManager().perform(MarketNewsRequest(type: .topNews)) { [weak self] (result: Result<[News], Error>) in
    
                switch result {
                case .success(let data):
                    self?.news = data
                case .failure(let error):
                    print(error)
                }
            
        }
    }

    private func openNews(url: URL) {
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    private func failedToOpenNewAlert() {
        let alert = UIAlertController(title: "Unable to open", message: "Sorry, we were unable to open", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else { fatalError() }
        cell.configure(with: .init(model: news[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        NewsTableViewCell.prefferedHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsTableHeaderView.identifier) as? NewsTableHeaderView else {return nil}
        header.configure(with: .init(title: self.type.title, showButton: true))
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        NewsTableHeaderView.preferredHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let new = news[indexPath.row]
        guard let url = URL(string: new.url) else {
            failedToOpenNewAlert()
            return
        }
        openNews(url: url)
    }
    
}
