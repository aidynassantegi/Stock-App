//
//  DataParserProtocol.swift
//  Stock App
//
//  Created by Айгерим Абдурахманова on 25.07.2022.
//

import Foundation

protocol DataParserProtocol {
  func parse<T: Decodable>(data: Data) -> T
}
