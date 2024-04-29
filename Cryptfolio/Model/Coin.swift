//
//  Coin.swift
//  Cryptfolio
//
//  Created by Yusuf Burak on 27/04/2024.
//

import Foundation

struct Coin: Codable, Hashable, Identifiable {
    let id: String
    let name: String
    let symbol: String
    let marketCapRank: Int
    let currentPrice: Double
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, image
        case marketCapRank = "market_cap_rank"
        case currentPrice = "current_price"
    }
    
    static let example = Coin(id: "bitcoin", name: "Bitcoin", symbol: "btc", marketCapRank: 1, currentPrice: 63000, image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")
}
