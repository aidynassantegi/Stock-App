//
//  News.swift
//  Stock App
//
//  Created by Айгерим Абдурахманова on 26.07.2022.
//

import Foundation

struct News: Codable {
    let category: String
    let datetime: TimeInterval
    let headline: String
    let id: Int
    let image: String
    let related: String
    let source: String
    let summary: String
    let url: String
}
