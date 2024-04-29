//
//  ContentView.swift
//  Cryptfolio
//
//  Created by Yusuf Burak on 27/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.coins) { coin in
                HStack(spacing: 15) {
                    Text(String(coin.marketCapRank))
                    AsyncImage(url: URL(string: coin.image)) { image in
                        image.image?.resizable().scaledToFit().frame(width: 20)
                    }
                    VStack(alignment: .leading) {
                        Text(coin.name.capitalized)
                            .bold()
                        Text(coin.symbol.uppercased())
                    }
                    Spacer()
                    Text(viewModel.formatPrice(price: coin.currentPrice))
                }
            }
            .navigationTitle("Cryptfolio")
        }
    }
}

#Preview {
    ContentView()
}
