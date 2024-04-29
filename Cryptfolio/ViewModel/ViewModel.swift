//
//  ViewModel.swift
//  Cryptfolio
//
//  Created by Yusuf Burak on 27/04/2024.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var coins = [Coin]()
    
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=false&price_change_percentage=24h&locale=en"
    
    init() { fetchCoins() }
    
    func fetchCoins() {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            if let error = error {
                self?.handleError(CoinAPIError.unknown(error))
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                self?.handleError(CoinAPIError.requestFailed("Request Failed."))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                self?.handleError(CoinAPIError.invalidStatusCode(httpResponse.statusCode))
                return
            }
            
            guard let data = data else {
                self?.handleError(CoinAPIError.invalidData)
                return
            }
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                DispatchQueue.main.async {
                    self?.coins = coins
                }
            } catch {
                self?.handleError(CoinAPIError.decodingFailed)
            }
            
        }
        task.resume()
        
    }
    
    private func handleError(_ error: CoinAPIError) { error.handleError() }
    
    func formatPrice(price: Double) -> String {
        let formatter = NumberFormatter()
        
        if price > 1000 {
            formatter.maximumFractionDigits = 0
        } else if price > 100 {
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 1
        } else if price > 10 {
            formatter.minimumFractionDigits = 1
            formatter.maximumFractionDigits = 2
        } else if price > 1 {
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 3
        } else if price > 0.1 {
            formatter.minimumFractionDigits = 3
            formatter.maximumFractionDigits = 4
        } else if price > 0.01 {
            formatter.minimumFractionDigits = 4
            formatter.maximumFractionDigits = 5
        } else if price > 0.001 {
            formatter.minimumFractionDigits = 5
            formatter.maximumFractionDigits = 6
        } else if price > 0.0001 {
            formatter.minimumFractionDigits = 6
            formatter.maximumFractionDigits = 7
        } else if price > 0.00001 {
            formatter.minimumFractionDigits = 7
            formatter.maximumFractionDigits = 8
        } else if price > 0.000001 {
            formatter.minimumFractionDigits = 8
            formatter.maximumFractionDigits = 9
        } else if price > 0.0000001 {
            formatter.minimumFractionDigits = 9
            formatter.maximumFractionDigits = 10
        } else {
            formatter.minimumFractionDigits = 10
            formatter.maximumFractionDigits = 11
        }
        
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
        
    }
    
}
