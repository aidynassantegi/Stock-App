//
//  NewsTableDataManager.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 28.07.2022.
//

import Foundation
import UIKit

final class NewsTableDataManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var news: [News] = []
    var onNewDidSelect: ((String) -> Void)?
    var newType: NewsType = NewsType.topNews
    
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
        header.configure(with: .init(title: newType.title, showButton: true))
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        NewsTableHeaderView.preferredHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onNewDidSelect?(news[indexPath.row].url)
//        let new = news[indexPath.row]
//        guard let url = URL(string: new.url) else {
//            failedToOpenNewAlert()
//            return
//        }
//        openNews(url: url)
    }
    
}
