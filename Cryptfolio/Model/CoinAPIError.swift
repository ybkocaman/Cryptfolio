//
//  CoinAPIError.swift
//  Cryptfolio
//
//  Created by Yusuf Burak on 28/04/2024.
//

import Foundation

enum CoinAPIError: Error {
    case requestFailed(String)
    case invalidData
    case invalidStatusCode(Int)
    case decodingFailed
    case unknown(Error)
    
    func handleError() {
        switch self {
        case .requestFailed(let description):
            print("Request failed: \(description)")
        case .invalidData:
            print("Invalid data")
        case .invalidStatusCode(let statusCode):
            print("Invalid status code: \(statusCode)")
        case .decodingFailed:
            print("Failed to decode data.")
        case .unknown(let error):
            print("An unknown error occurred: \(error.localizedDescription)")
        }
    }
}
