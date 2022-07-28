//
//  CompanyProfile.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 27.07.2022.
//

import Foundation

struct CompanyProfile: Codable, Hashable {
    let currency: String
    let name: String
    let ticker: String
    let logo: String
}
