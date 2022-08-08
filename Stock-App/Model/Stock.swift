//
//  Stock.swift
//  Stock App
//
//  Created by Aidyn Assan on 19.07.2022.
//

import Foundation

struct Stock {
	let symbol: String
	let price: Double
	let image: String?
	let companyName: String
	let changes: Double
	var isFavorite: Bool
	
	static var stocks: [Stock] = [Stock(symbol: "AAPL", price: 144, image: "AAPL", companyName: "Apple Inc.", changes: 3.21, isFavorite: true), Stock(symbol: "AAPL", price: 144, image: "AAPL", companyName: "Apple Inc.", changes: 3.21, isFavorite: false), Stock(symbol: "AAPL", price: 144, image: "AAPL", companyName: "Apple Inc.", changes: 3.21, isFavorite: false), Stock(symbol: "AAPL", price: 144, image: "AAPL", companyName: "Apple Inc.", changes: 3.21, isFavorite: false), Stock(symbol: "AAPL", price: 144, image: "AAPL", companyName: "Apple Inc.", changes: 3.21, isFavorite: true), Stock(symbol: "AAPL", price: 144, image: "AAPL", companyName: "Apple Inc.", changes: 3.21, isFavorite: false), Stock(symbol: "AAPL", price: 144, image: "AAPL", companyName: "Apple Inc.", changes: 3.21, isFavorite: false), Stock(symbol: "AAPL", price: 144, image: "AAPL", companyName: "Apple Inc.", changes: 3.21, isFavorite: false), Stock(symbol: "AAPL", price: 144, image: "AAPL", companyName: "Apple Inc.", changes: 3.21, isFavorite: true), Stock(symbol: "AAPL", price: 144, image: "AAPL", companyName: "Apple Inc.", changes: 3.21, isFavorite: false), Stock(symbol: "AAPL", price: 144, image: "AAPL", companyName: "Apple Inc.", changes: 3.21, isFavorite: true),]
}

enum Constant {
	static var isGray = true
}
