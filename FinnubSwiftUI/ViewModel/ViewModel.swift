//
//  ViewModel.swift
//  FinnubSwiftUI
//
//  Created by Angelos Staboulis on 3/5/23.
//

import Foundation
import Combine
class ViewModel{
    var symbols:[Symbols]=[]
    var quotes:[PriceTarget]=[]
    var listFinhub:[Finnhub]=[]
    private var apishared:APIManager!
    init(){
        apishared = APIManager.shared
    }
    func fetchListPrices() async throws -> [Finnhub]{
        return try await withUnsafeThrowingContinuation{ continuation in
            Task.init{
                symbols = try await APIManager.shared.fetchSymbols()
                for symbol in symbols{
                    quotes.append(contentsOf: try await APIManager.shared.fetchQuote(symbol: symbol.symbol))
                }
                for quote in 0..<quotes.count{
                    let record = Finnhub(symbol: symbols[quote].symbol, price: quotes[quote].price)
                    listFinhub.append(record)
                }
                continuation.resume(returning:listFinhub)
            }
        }
                
        
    }
}
